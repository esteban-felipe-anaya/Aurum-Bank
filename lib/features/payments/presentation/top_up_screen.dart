import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/providers/providers.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/account.dart';
import '../../../data/models/bank_card.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';
import '../../cards/application/cards_controller.dart';

/// Adds funds to one of the user's accounts from a linked card. Persists the
/// new balance to the mock API and refreshes account state on success.
class TopUpScreen extends ConsumerStatefulWidget {
  const TopUpScreen({super.key});

  @override
  ConsumerState<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends ConsumerState<TopUpScreen> {
  final _amount = TextEditingController();
  Account? _account;
  BankCard? _source;
  String? _error;
  bool _saving = false;

  static const _presets = [25.0, 50.0, 100.0, 250.0];

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  double? _parse() {
    final value = double.tryParse(_amount.text.trim().replaceAll(',', ''));
    if (value == null || value <= 0) return null;
    return value;
  }

  Future<void> _submit() async {
    final amount = _parse();
    if (amount == null) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    if (_account == null) {
      setState(() => _error = 'Choose an account to top up');
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref
          .read(paymentsRepositoryProvider)
          .topUp(accountId: _account!.id, amount: amount);
      ref.invalidate(accountsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Added ${Formatters.money(amount, _account!.currency)} to ${_account!.name}',
          ),
        ),
      );
      navigator.pop();
    } catch (e) {
      setState(() => _saving = false);
      messenger.showSnackBar(
        SnackBar(content: Text(mapDioError(e).message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider);
    final cards = ref.watch(cardsControllerProvider).value ?? const <BankCard>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Top up')),
      body: MaxWidthBody(
        maxWidth: 560,
        child: AsyncValueView<List<Account>>(
          value: accounts,
          onRetry: () => ref.invalidate(accountsProvider),
          data: (list) {
            final fundable = list.where((a) => a.type != 'credit').toList();
            _account ??= fundable.isNotEmpty ? fundable.first : null;
            _source ??= cards.isNotEmpty ? cards.first : null;

            return ListView(
              padding: const EdgeInsets.all(Spacing.lg),
              children: [
                Text('Amount', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                TextField(
                  controller: _amount,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  onChanged: (_) {
                    if (_error != null) setState(() => _error = null);
                  },
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    hintText: '0.00',
                    errorText: _error,
                    filled: false,
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: Spacing.md),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: Spacing.sm,
                  children: [
                    for (final p in _presets)
                      ActionChip(
                        label: Text(Formatters.money(p, 'USD')),
                        onPressed: () => setState(() {
                          _amount.text = p.toStringAsFixed(0);
                          _error = null;
                        }),
                      ),
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                Text('To account', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: Spacing.sm),
                for (final a in fundable)
                  Card(
                    child: ListTile(
                      onTap: () => setState(() => _account = a),
                      title: Text(a.name),
                      subtitle: Text(
                        '${a.accountNumberMasked} • ${Formatters.money(a.balance, a.currency)}',
                      ),
                      trailing: Icon(
                        _account?.id == a.id
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: _account?.id == a.id
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                if (cards.isNotEmpty) ...[
                  const SizedBox(height: Spacing.lg),
                  Text(
                    'From card',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Spacing.sm),
                  Card(
                    child: Column(
                      children: [
                        for (final c in cards)
                          ListTile(
                            leading: const Icon(Icons.credit_card_rounded),
                            title: Text('${c.brand.toUpperCase()} •••• ${c.last4}'),
                            trailing: Icon(
                              _source?.id == c.id
                                  ? Icons.radio_button_checked_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: _source?.id == c.id
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline,
                            ),
                            onTap: () => setState(() => _source = c),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: Spacing.xxl),
                FilledButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : const Text('Add funds'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
