import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/account.dart';
import '../../../data/models/bank_card.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/credit_card_widget.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../../shared/widgets/status_views.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/cards_controller.dart';

class CardsScreen extends ConsumerWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsControllerProvider);
    final accounts = ref.watch(accountsProvider).value ?? const <Account>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
        actions: [
          IconButton(
            tooltip: 'Add card',
            onPressed: () => context.push(AppRoutes.addCard),
            icon: const Icon(Icons.add_rounded),
          ),
          const SizedBox(width: Spacing.sm),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(cardsControllerProvider.notifier).refresh(),
        child: MaxWidthBody(
          maxWidth: 560,
          child: AsyncValueView<List<BankCard>>(
            value: cards,
            onRetry: () => ref.read(cardsControllerProvider.notifier).refresh(),
            data: (list) {
              if (list.isEmpty) {
                return EmptyView(
                  icon: Icons.credit_card_off_rounded,
                  title: 'No cards yet',
                  message: 'Add your first card to get started.',
                  action: FilledButton.icon(
                    onPressed: () => context.push(AppRoutes.addCard),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add card'),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(Spacing.lg),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: Spacing.xl),
                itemBuilder: (context, i) {
                  final card = list[i];
                  Account? account;
                  for (final a in accounts) {
                    if (a.id == card.accountId) {
                      account = a;
                      break;
                    }
                  }
                  return CreditCardWidget(
                    card: card,
                    heroTag: 'card-${card.id}',
                    balanceLabel: account == null
                        ? null
                        : Formatters.money(account.balance, account.currency),
                    onTap: () => context.push(AppRoutes.cardDetail(card.id)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
