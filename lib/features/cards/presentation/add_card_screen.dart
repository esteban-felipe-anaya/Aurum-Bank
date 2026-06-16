import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../data/models/bank_card.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/cards_controller.dart';

const _brands = ['visa', 'mastercard', 'amex'];
const _colors = [
  '#1A1A2E',
  '#3D5AFE',
  '#6C5CE7',
  '#00B894',
  '#E17055',
  '#0984E3',
];

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _holder = TextEditingController();
  final _last4 = TextEditingController();
  final _expiry = TextEditingController();
  String _brand = _brands.first;
  String _color = _colors.first;
  bool _saving = false;

  @override
  void dispose() {
    _holder.dispose();
    _last4.dispose();
    _expiry.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final accounts = ref.read(accountsProvider).value ?? const [];
    final accountId = accounts.isNotEmpty ? accounts.first.id : 'acc_01';
    final card = BankCard(
      id: 'card_${DateTime.now().millisecondsSinceEpoch}',
      accountId: accountId,
      brand: _brand,
      last4: _last4.text.trim(),
      holder: _holder.text.trim().toUpperCase(),
      expiry: _expiry.text.trim(),
      frozen: false,
      color: _color,
    );
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await ref.read(cardsControllerProvider.notifier).addCard(card);
      messenger.showSnackBar(const SnackBar(content: Text('Card added')));
      navigator.pop();
    } catch (_) {
      setState(() => _saving = false);
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not add card. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Add card')),
      body: MaxWidthBody(
        maxWidth: 480,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _holder,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Card holder',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Enter the name' : null,
                ),
                const SizedBox(height: Spacing.lg),
                TextFormField(
                  controller: _last4,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Last 4 digits',
                    prefixIcon: Icon(Icons.credit_card_rounded),
                    counterText: '',
                  ),
                  validator: (v) =>
                      (v == null || v.length != 4) ? 'Enter 4 digits' : null,
                ),
                const SizedBox(height: Spacing.lg),
                TextFormField(
                  controller: _expiry,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Expiry (MM/YY)',
                    hintText: '08/28',
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                  validator: (v) =>
                      (v == null ||
                          !RegExp(r'^\d{2}/\d{2}$').hasMatch(v.trim()))
                      ? 'Use MM/YY'
                      : null,
                ),
                const SizedBox(height: Spacing.lg),
                DropdownButtonFormField<String>(
                  initialValue: _brand,
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                  ),
                  items: [
                    for (final b in _brands)
                      DropdownMenuItem(value: b, child: Text(b.toUpperCase())),
                  ],
                  onChanged: (v) => setState(() => _brand = v ?? _brand),
                ),
                const SizedBox(height: Spacing.xl),
                Text(
                  'Card color',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: Spacing.sm),
                Wrap(
                  spacing: Spacing.md,
                  children: [
                    for (final hex in _colors)
                      GestureDetector(
                        onTap: () => setState(() => _color = hex),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse('FF${hex.substring(1)}', radix: 16),
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _color == hex
                                  ? scheme.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: Spacing.xxl),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : const Text('Add card'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
