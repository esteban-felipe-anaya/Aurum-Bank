import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/app_transaction.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/category_visuals.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../application/transactions_controller.dart';

/// Full screen used for narrow layouts and deep links.
class TransactionDetailScreen extends ConsumerWidget {
  const TransactionDetailScreen({super.key, required this.transactionId});

  final String transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txn = ref.watch(transactionDetailProvider(transactionId));
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction')),
      body: MaxWidthBody(
        maxWidth: 640,
        child: AsyncValueView<AppTransaction>(
          value: txn,
          onRetry: () =>
              ref.invalidate(transactionDetailProvider(transactionId)),
          data: (t) => SingleChildScrollView(
            padding: const EdgeInsets.all(Spacing.lg),
            child: TransactionDetailView(transaction: t),
          ),
        ),
      ),
    );
  }
}

/// Embeddable detail body, reused by the two-pane transactions layout.
class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key, required this.transaction});

  final AppTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visual = visualForCategory(transaction.category);
    final isCredit = transaction.type == TransactionType.credit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: Spacing.lg),
        CircleAvatar(
          radius: 36,
          backgroundColor: visual.color.withValues(alpha: 0.16),
          child: Icon(visual.icon, color: visual.color, size: 34),
        ),
        const SizedBox(height: Spacing.lg),
        Text(
          transaction.title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: Spacing.xs),
        Text(
          Formatters.signedMoney(transaction.amount, transaction.currency),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: isCredit ? const Color(0xFF00B894) : scheme.onSurface,
          ),
        ),
        const SizedBox(height: Spacing.md),
        Center(child: _StatusBadge(status: transaction.status)),
        const SizedBox(height: Spacing.xl),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Column(
              children: [
                _DetailRow(label: 'Merchant', value: transaction.merchant),
                _DetailRow(
                  label: 'Category',
                  value: categoryLabel(transaction.category),
                ),
                _DetailRow(
                  label: 'Date',
                  value: Formatters.dateTime(transaction.date),
                ),
                _DetailRow(label: 'Type', value: isCredit ? 'Credit' : 'Debit'),
                _DetailRow(label: 'Account', value: transaction.accountId),
                _DetailRow(
                  label: 'Reference',
                  value: transaction.id,
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(width: Spacing.lg),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      TransactionStatus.completed => ('Completed', const Color(0xFF00B894)),
      TransactionStatus.pending => ('Pending', scheme.tertiary),
      TransactionStatus.failed => ('Failed', scheme.error),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: Radii.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: color),
          const SizedBox(width: Spacing.sm),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
