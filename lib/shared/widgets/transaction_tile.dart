import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/app_transaction.dart';
import 'category_visuals.dart';

/// Reusable transaction row used on the dashboard and the transactions list.
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
    this.showDate = true,
  });

  final AppTransaction transaction;
  final VoidCallback? onTap;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visual = visualForCategory(transaction.category);
    final isCredit = transaction.type == TransactionType.credit;
    final amountColor = isCredit ? const Color(0xFF00B894) : scheme.onSurface;

    final subtitleParts = <String>[
      categoryLabel(transaction.category),
      if (showDate) Formatters.dayMonth(transaction.date),
    ];

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: visual.color.withValues(alpha: 0.16),
        child: Icon(visual.icon, color: visual.color, size: 22),
      ),
      title: Text(
        transaction.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitleParts.join(' • '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            Formatters.signedMoney(transaction.amount, transaction.currency),
            style: TextStyle(fontWeight: FontWeight.w700, color: amountColor),
          ),
          if (transaction.status != TransactionStatus.completed)
            _StatusChip(status: transaction.status),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      TransactionStatus.pending => ('Pending', scheme.tertiary),
      TransactionStatus.failed => ('Failed', scheme.error),
      TransactionStatus.completed => ('', scheme.primary),
    };
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}
