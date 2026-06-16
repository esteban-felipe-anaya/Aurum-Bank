import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/app_notification.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../../shared/widgets/status_views.dart';
import '../application/notifications_controller.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  IconData _iconFor(String type) => switch (type) {
    'transaction' => Icons.swap_horiz_rounded,
    'security' => Icons.shield_outlined,
    'promo' => Icons.local_offer_outlined,
    _ => Icons.info_outline_rounded,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => ref
                .read(notificationsControllerProvider.notifier)
                .markAllRead(),
            child: const Text('Mark all read'),
          ),
          const SizedBox(width: Spacing.sm),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(notificationsControllerProvider.notifier).refresh(),
        child: MaxWidthBody(
          maxWidth: 640,
          child: AsyncValueView<List<AppNotification>>(
            value: notifications,
            onRetry: () =>
                ref.read(notificationsControllerProvider.notifier).refresh(),
            data: (list) {
              if (list.isEmpty) {
                return const EmptyView(
                  icon: Icons.notifications_off_rounded,
                  title: 'No notifications',
                  message: 'You are all caught up.',
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(Spacing.lg),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: Spacing.sm),
                itemBuilder: (context, i) {
                  final n = list[i];
                  return Card(
                    color: n.read
                        ? null
                        : scheme.primaryContainer.withValues(alpha: 0.35),
                    child: ListTile(
                      onTap: n.read
                          ? null
                          : () => ref
                                .read(notificationsControllerProvider.notifier)
                                .markRead(n.id),
                      leading: CircleAvatar(
                        backgroundColor: scheme.secondaryContainer,
                        child: Icon(
                          _iconFor(n.type),
                          color: scheme.onSecondaryContainer,
                        ),
                      ),
                      title: Text(
                        n.title,
                        style: TextStyle(
                          fontWeight: n.read
                              ? FontWeight.w500
                              : FontWeight.w700,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n.body),
                          const SizedBox(height: Spacing.xs),
                          Text(
                            Formatters.relativeDay(n.date),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: n.read
                          ? null
                          : Icon(Icons.circle, size: 10, color: scheme.primary),
                    ),
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
