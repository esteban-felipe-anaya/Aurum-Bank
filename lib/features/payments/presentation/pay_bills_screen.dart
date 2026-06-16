import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_mapper.dart';
import '../../../core/providers/providers.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/account.dart';
import '../../../data/models/biller.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/payments_providers.dart';

/// Maps the biller's icon name (from the API) to a Material icon.
IconData billerIcon(String name) => switch (name) {
  'bolt' => Icons.bolt_rounded,
  'wifi' => Icons.wifi_rounded,
  'water_drop' => Icons.water_drop_rounded,
  'smartphone' => Icons.smartphone_rounded,
  'credit_card' => Icons.credit_card_rounded,
  'shield' => Icons.shield_rounded,
  _ => Icons.receipt_long_rounded,
};

class PayBillsScreen extends ConsumerStatefulWidget {
  const PayBillsScreen({super.key});

  @override
  ConsumerState<PayBillsScreen> createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends ConsumerState<PayBillsScreen> {
  Biller? _biller;
  final _amount = TextEditingController();
  Account? _account;
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _pay() async {
    final amount = double.tryParse(_amount.text.trim().replaceAll(',', ''));
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    final account = _account!;
    if (amount > account.balance) {
      setState(() => _error = 'Insufficient balance in ${account.name}');
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref.read(paymentsRepositoryProvider).payBill(
        accountId: account.id,
        amount: amount,
        billerName: _biller!.name,
      );
      ref.invalidate(accountsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Paid ${Formatters.money(amount, account.currency)} to ${_biller!.name}',
          ),
        ),
      );
      navigator.pop();
    } catch (e) {
      setState(() => _saving = false);
      messenger.showSnackBar(SnackBar(content: Text(mapDioError(e).message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final billers = ref.watch(billersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Pay bills')),
      body: MaxWidthBody(
        maxWidth: 560,
        child: AsyncValueView<List<Biller>>(
          value: billers,
          onRetry: () => ref.invalidate(billersProvider),
          data: (list) => _biller == null
              ? _BillerPicker(
                  billers: list,
                  onSelected: (b) => setState(() => _biller = b),
                )
              : _PayForm(
                  biller: _biller!,
                  amountController: _amount,
                  errorText: _error,
                  saving: _saving,
                  selectedAccount: _account,
                  onAccountChanged: (a) => setState(() => _account = a),
                  onAmountChanged: () {
                    if (_error != null) setState(() => _error = null);
                  },
                  onChangeBiller: () => setState(() => _biller = null),
                  onPay: _pay,
                  ensureAccount: (a) => _account ??= a,
                ),
        ),
      ),
    );
  }
}

class _BillerPicker extends StatelessWidget {
  const _BillerPicker({required this.billers, required this.onSelected});
  final List<Biller> billers;
  final ValueChanged<Biller> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Text('Choose a biller', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: Spacing.lg),
        for (final b in billers)
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.sm),
            child: Card(
              child: ListTile(
                onTap: () => onSelected(b),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.secondaryContainer,
                  child: Icon(
                    billerIcon(b.icon),
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                title: Text(
                  b.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(b.accountMasked),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ),
      ],
    );
  }
}

class _PayForm extends ConsumerWidget {
  const _PayForm({
    required this.biller,
    required this.amountController,
    required this.errorText,
    required this.saving,
    required this.selectedAccount,
    required this.onAccountChanged,
    required this.onAmountChanged,
    required this.onChangeBiller,
    required this.onPay,
    required this.ensureAccount,
  });

  final Biller biller;
  final TextEditingController amountController;
  final String? errorText;
  final bool saving;
  final Account? selectedAccount;
  final ValueChanged<Account> onAccountChanged;
  final VoidCallback onAmountChanged;
  final VoidCallback onChangeBiller;
  final VoidCallback onPay;
  final void Function(Account) ensureAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider).value ?? const <Account>[];
    final fundable = accounts.where((a) => a.type != 'credit').toList();
    if (fundable.isNotEmpty) ensureAccount(fundable.first);
    final selected = selectedAccount ??
        (fundable.isNotEmpty ? fundable.first : null);

    return ListView(
      padding: const EdgeInsets.all(Spacing.lg),
      children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: Icon(
                billerIcon(biller.icon),
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            title: Text(
              biller.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(biller.accountMasked),
            trailing: TextButton(
              onPressed: onChangeBiller,
              child: const Text('Change'),
            ),
          ),
        ),
        const SizedBox(height: Spacing.xl),
        Text('Amount', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: Spacing.sm),
        TextField(
          controller: amountController,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
          onChanged: (_) => onAmountChanged(),
          decoration: InputDecoration(
            prefixText: '\$ ',
            hintText: '0.00',
            errorText: errorText,
            filled: false,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: Spacing.xl),
        Text('Pay from', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: Spacing.sm),
        for (final a in fundable)
          Card(
            child: ListTile(
              onTap: () => onAccountChanged(a),
              title: Text(a.name),
              subtitle: Text(
                '${a.accountNumberMasked} • ${Formatters.money(a.balance, a.currency)}',
              ),
              trailing: Icon(
                selected?.id == a.id
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected?.id == a.id
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        const SizedBox(height: Spacing.xxl),
        FilledButton(
          onPressed: saving ? null : onPay,
          child: saving
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Text('Pay bill'),
        ),
      ],
    );
  }
}
