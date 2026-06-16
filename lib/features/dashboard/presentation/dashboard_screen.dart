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
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/status_views.dart';
import '../../../shared/widgets/transaction_tile.dart';
import '../../accounts/application/accounts_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../cards/application/cards_controller.dart';
import '../../notifications/application/notifications_controller.dart';
import '../../transactions/application/transactions_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(accountsProvider);
    ref.invalidate(cardsControllerProvider);
    ref.invalidate(recentTransactionsProvider);
    await Future.wait([
      ref.read(accountsProvider.future),
      ref.read(recentTransactionsProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value?.user;
    final unread = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: Spacing.lg,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              user?.name ?? 'Aurum member',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.notifications),
            icon: Badge(
              isLabelVisible: unread > 0,
              label: Text('$unread'),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
          const SizedBox(width: Spacing.sm),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: MaxWidthBody(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 840;
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.lg,
                  Spacing.sm,
                  Spacing.lg,
                  Spacing.xxxl,
                ),
                children: [
                  const _BalanceHeader(),
                  const SizedBox(height: Spacing.xl),
                  if (wide)
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: Column(
                              children: [
                                _CardsCarousel(),
                                SizedBox(height: Spacing.xl),
                                _QuickActions(),
                              ],
                            ),
                          ),
                          SizedBox(width: Spacing.xl),
                          Expanded(child: _RecentTransactions()),
                        ],
                      ),
                    )
                  else ...const [
                    _CardsCarousel(),
                    SizedBox(height: Spacing.xl),
                    _QuickActions(),
                    SizedBox(height: Spacing.sm),
                    _RecentTransactions(),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BalanceHeader extends ConsumerWidget {
  const _BalanceHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final total = ref.watch(totalBalanceProvider);
    final currency = ref.watch(primaryCurrencyProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.xl),
      decoration: BoxDecoration(
        borderRadius: Radii.cardLg,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, scheme.tertiary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total balance',
            style: TextStyle(color: scheme.onPrimary.withValues(alpha: 0.8)),
          ),
          const SizedBox(height: Spacing.sm),
          total.when(
            data: (value) => Text(
              Formatters.money(value, currency),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: scheme.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            loading: () =>
                Shimmer(child: SkeletonBox(width: 180, height: 40, radius: 10)),
            error: (_, _) => Text(
              '—',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(color: scheme.onPrimary),
            ),
          ),
          const SizedBox(height: Spacing.md),
          Row(
            children: [
              Icon(
                Icons.trending_up_rounded,
                size: 18,
                color: scheme.onPrimary.withValues(alpha: 0.9),
              ),
              const SizedBox(width: Spacing.xs),
              Text(
                'Across your accounts',
                style: TextStyle(
                  color: scheme.onPrimary.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardsCarousel extends ConsumerWidget {
  const _CardsCarousel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsControllerProvider);
    final accounts = ref.watch(accountsProvider).value ?? const <Account>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Your cards',
          actionLabel: 'Manage',
          onAction: () => context.go(AppRoutes.cards),
        ),
        AsyncValueView<List<BankCard>>(
          value: cards,
          onRetry: () => ref.read(cardsControllerProvider.notifier).refresh(),
          loading: const Shimmer(
            child: SizedBox(
              height: 200,
              child: SkeletonBox(height: 200, radius: 24),
            ),
          ),
          data: (list) {
            if (list.isEmpty) {
              return const EmptyView(
                icon: Icons.credit_card_off_rounded,
                title: 'No cards yet',
              );
            }
            return SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(width: Spacing.lg),
                itemBuilder: (context, i) {
                  final card = list[i];
                  final account = accounts
                      .where((a) => a.id == card.accountId)
                      .cast<Account?>()
                      .firstWhere((a) => true, orElse: () => null);
                  return SizedBox(
                    width: 330,
                    child: CreditCardWidget(
                      card: card,
                      heroTag: 'card-${card.id}',
                      balanceLabel: account == null
                          ? null
                          : Formatters.money(account.balance, account.currency),
                      onTap: () => context.push(AppRoutes.cardDetail(card.id)),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final actions = <(IconData, String, VoidCallback)>[
      (
        Icons.north_east_rounded,
        'Send',
        () => context.push(AppRoutes.transfer),
      ),
      (
        Icons.south_west_rounded,
        'Request',
        () => context.push(AppRoutes.requestMoney),
      ),
      (
        Icons.receipt_long_rounded,
        'Pay',
        () => context.push(AppRoutes.payBills),
      ),
      (
        Icons.add_card_rounded,
        'Top-up',
        () => context.push(AppRoutes.topUp),
      ),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final (icon, label, onTap) in actions)
          Expanded(
            child: _QuickAction(icon: icon, label: label, onTap: onTap),
          ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: Radii.card,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: scheme.onSecondaryContainer),
            ),
            const SizedBox(height: Spacing.sm),
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _RecentTransactions extends ConsumerWidget {
  const _RecentTransactions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentTransactionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Recent activity',
          actionLabel: 'See all',
          onAction: () => context.go(AppRoutes.transactions),
        ),
        AsyncValueView(
          value: recent,
          onRetry: () => ref.invalidate(recentTransactionsProvider),
          loading: const ListSkeleton(itemCount: 5),
          data: (list) {
            if (list.isEmpty) {
              return const EmptyView(
                icon: Icons.receipt_long_rounded,
                title: 'No transactions yet',
                message: 'Your recent activity will appear here.',
              );
            }
            return Column(
              children: [
                for (final txn in list)
                  TransactionTile(
                    transaction: txn,
                    onTap: () =>
                        context.push(AppRoutes.transactionDetail(txn.id)),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
