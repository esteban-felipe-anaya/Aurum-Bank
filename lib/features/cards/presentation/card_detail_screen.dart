import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/account.dart';
import '../../../data/models/bank_card.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/credit_card_widget.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/cards_controller.dart';

class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardDetailProvider(cardId));
    final accounts = ref.watch(accountsProvider).value ?? const <Account>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Card details')),
      body: MaxWidthBody(
        maxWidth: 560,
        child: AsyncValueView<BankCard>(
          value: card,
          onRetry: () => ref.invalidate(cardDetailProvider(cardId)),
          data: (c) {
            Account? account;
            for (final a in accounts) {
              if (a.id == c.accountId) {
                account = a;
                break;
              }
            }
            return ListView(
              padding: const EdgeInsets.all(Spacing.lg),
              children: [
                CreditCardWidget(
                  card: c,
                  heroTag: 'card-${c.id}',
                  balanceLabel: account == null
                      ? null
                      : Formatters.money(account.balance, account.currency),
                ),
                const SizedBox(height: Spacing.xl),
                Card(
                  child: SwitchListTile(
                    secondary: const Icon(Icons.ac_unit_rounded),
                    title: const Text('Freeze card'),
                    subtitle: Text(
                      c.frozen
                          ? 'Card is frozen — payments are blocked'
                          : 'Temporarily block all payments',
                    ),
                    value: c.frozen,
                    onChanged: (_) => ref
                        .read(cardsControllerProvider.notifier)
                        .toggleFreeze(c.id),
                  ),
                ),
                const SizedBox(height: Spacing.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                    child: Column(
                      children: [
                        _InfoRow(label: 'Card holder', value: c.holder),
                        _InfoRow(label: 'Brand', value: c.brand.toUpperCase()),
                        _InfoRow(label: 'Number', value: '•••• ${c.last4}'),
                        _InfoRow(label: 'Expires', value: c.expiry),
                        _InfoRow(
                          label: 'Linked account',
                          value: account?.name ?? c.accountId,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}
