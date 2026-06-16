import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/app_transaction.dart';
import '../../../data/repositories/transactions_repository.dart';

/// Canonical category keys used for filtering (matches the mock API seed data).
const List<String> kTransactionCategories = [
  'groceries',
  'dining',
  'subscriptions',
  'transport',
  'shopping',
  'utilities',
  'entertainment',
  'health',
  'travel',
  'income',
  'transfers',
];

/// Paginated, filterable transaction list state.
class TransactionsState {
  const TransactionsState({
    this.items = const [],
    this.query = const TransactionQuery(),
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  final List<AppTransaction> items;
  final TransactionQuery query;
  final bool isLoadingMore;
  final bool hasMore;

  TransactionsState copyWith({
    List<AppTransaction>? items,
    TransactionQuery? query,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return TransactionsState(
      items: items ?? this.items,
      query: query ?? this.query,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class TransactionsController extends AsyncNotifier<TransactionsState> {
  static const _pageSize = 15;

  @override
  Future<TransactionsState> build() =>
      _load(const TransactionQuery(limit: _pageSize));

  Future<TransactionsState> _load(TransactionQuery query) async {
    final repo = ref.read(transactionsRepositoryProvider);
    final items = await repo.getTransactions(query);
    return TransactionsState(
      items: items,
      query: query,
      hasMore: items.length >= query.limit,
    );
  }

  /// Re-runs the query from page 1 (used for search & filter changes).
  Future<void> applyQuery(TransactionQuery query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _load(query.copyWith(page: 1, limit: _pageSize)),
    );
  }

  Future<void> refresh() =>
      applyQuery(state.value?.query ?? const TransactionQuery());

  void setSearch(String q) => applyQuery(
    (state.value?.query ?? const TransactionQuery()).copyWith(
      q: q,
      clearQ: q.isEmpty,
    ),
  );

  void setCategory(String? category) => applyQuery(
    (state.value?.query ?? const TransactionQuery()).copyWith(
      category: category,
      clearCategory: category == null,
    ),
  );

  void setAccount(String? accountId) => applyQuery(
    (state.value?.query ?? const TransactionQuery()).copyWith(
      accountId: accountId,
      clearAccountId: accountId == null,
    ),
  );

  void setDateRange(DateTime? from, DateTime? to) => applyQuery(
    (state.value?.query ?? const TransactionQuery()).copyWith(
      from: from,
      to: to,
      clearFrom: from == null,
      clearTo: to == null,
    ),
  );

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true));
    final nextQuery = current.query.copyWith(page: current.query.page + 1);
    try {
      final more = await ref
          .read(transactionsRepositoryProvider)
          .getTransactions(nextQuery);
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...more],
          query: nextQuery,
          isLoadingMore: false,
          hasMore: more.length >= nextQuery.limit,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}

final transactionsControllerProvider =
    AsyncNotifierProvider<TransactionsController, TransactionsState>(
      TransactionsController.new,
    );

/// Compact "recent activity" list for the dashboard.
final recentTransactionsProvider = FutureProvider<List<AppTransaction>>(
  (ref) => ref
      .watch(transactionsRepositoryProvider)
      .getTransactions(const TransactionQuery(limit: 6)),
);

final transactionDetailProvider = FutureProvider.family<AppTransaction, String>(
  (ref, id) => ref.read(transactionsRepositoryProvider).getTransaction(id),
);
