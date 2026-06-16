import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/app_notification.dart';

class NotificationsController extends AsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() =>
      ref.read(notificationsRepositoryProvider).getNotifications();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(notificationsRepositoryProvider).getNotifications(),
    );
  }

  Future<void> markRead(String id, {bool read = true}) async {
    final current = state.value;
    if (current == null) return;
    // Optimistic update.
    state = AsyncData([
      for (final n in current)
        if (n.id == id) n.copyWith(read: read) else n,
    ]);
    try {
      await ref.read(notificationsRepositoryProvider).setRead(id, read: read);
    } catch (_) {
      // Revert on failure.
      state = AsyncData(current);
    }
  }

  Future<void> markAllRead() async {
    final current = state.value;
    if (current == null) return;
    for (final n in current.where((n) => !n.read)) {
      await markRead(n.id);
    }
  }
}

final notificationsControllerProvider =
    AsyncNotifierProvider<NotificationsController, List<AppNotification>>(
      NotificationsController.new,
    );

/// Count of unread notifications for the app-bar badge.
final unreadNotificationsCountProvider = Provider<int>((ref) {
  final list = ref.watch(notificationsControllerProvider).value;
  return list?.where((n) => !n.read).length ?? 0;
});
