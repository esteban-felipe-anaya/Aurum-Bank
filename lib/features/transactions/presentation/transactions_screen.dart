import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../data/models/app_transaction.dart';
import '../../../shared/widgets/category_visuals.dart';
import '../../../shared/widgets/skeletons.dart';
import '../../../shared/widgets/status_views.dart';
import '../../../shared/widgets/transaction_tile.dart';
import '../../accounts/application/accounts_providers.dart';
import '../application/transactions_controller.dart';
import 'transaction_detail_screen.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      ref.read(transactionsControllerProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(transactionsControllerProvider.notifier).setSearch(value);
    });
  }

  Future<void> _openFilters() async {
    final accounts = ref.read(accountsProvider).value ?? const [];
    final current = ref.read(transactionsControllerProvider).value?.query;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _FilterSheet(
        accountIds: {for (final a in accounts) a.id: a.name},
        selectedAccountId: current?.accountId,
        from: current?.from,
        to: current?.to,
        onApply: (accountId, from, to) {
          final notifier = ref.read(transactionsControllerProvider.notifier);
          notifier.setAccount(accountId);
          notifier.setDateRange(from, to);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionsControllerProvider);
    final selectedCategory = state.value?.query.category;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        actions: [
          IconButton(
            tooltip: 'Filters',
            onPressed: _openFilters,
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: Spacing.sm),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacing.lg,
              Spacing.sm,
              Spacing.lg,
              Spacing.sm,
            ),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search transactions',
              leading: const Icon(Icons.search_rounded),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: Spacing.lg),
              ),
              onChanged: _onSearchChanged,
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      _searchController.clear();
                      ref
                          .read(transactionsControllerProvider.notifier)
                          .setSearch('');
                      setState(() {});
                    },
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              children: [
                for (final category in kTransactionCategories)
                  Padding(
                    padding: const EdgeInsets.only(right: Spacing.sm),
                    child: FilterChip(
                      label: Text(categoryLabel(category)),
                      selected: selectedCategory == category,
                      onSelected: (sel) => ref
                          .read(transactionsControllerProvider.notifier)
                          .setCategory(sel ? category : null),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth > 840;
                final list = _TransactionsList(
                  state: state,
                  scrollController: _scrollController,
                  wide: wide,
                  selectedId: _selectedId,
                  onSelect: (id) {
                    if (wide) {
                      setState(() => _selectedId = id);
                    } else {
                      context.push(AppRoutes.transactionDetail(id));
                    }
                  },
                  onRetry: () => ref
                      .read(transactionsControllerProvider.notifier)
                      .refresh(),
                );
                if (!wide) return list;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 2, child: list),
                    const VerticalDivider(width: 1),
                    Expanded(
                      flex: 3,
                      child: _DetailPane(state: state, selectedId: _selectedId),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionsList extends StatelessWidget {
  const _TransactionsList({
    required this.state,
    required this.scrollController,
    required this.wide,
    required this.selectedId,
    required this.onSelect,
    required this.onRetry,
  });

  final AsyncValue<TransactionsState> state;
  final ScrollController scrollController;
  final bool wide;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return state.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      error: (err, _) => ErrorView(error: err, onRetry: onRetry),
      loading: () => const Padding(
        padding: EdgeInsets.all(Spacing.lg),
        child: ListSkeleton(),
      ),
      data: (data) {
        if (data.items.isEmpty) {
          return const EmptyView(
            icon: Icons.search_off_rounded,
            title: 'No transactions found',
            message: 'Try adjusting your search or filters.',
          );
        }
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(
            Spacing.lg,
            0,
            Spacing.lg,
            Spacing.xxxl,
          ),
          itemCount: data.items.length + (data.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= data.items.length) {
              return const Padding(
                padding: EdgeInsets.all(Spacing.lg),
                child: Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ),
              );
            }
            final txn = data.items[index];
            return TransactionTile(
              transaction: txn,
              onTap: () => onSelect(txn.id),
            );
          },
        );
      },
    );
  }
}

class _DetailPane extends StatelessWidget {
  const _DetailPane({required this.state, required this.selectedId});
  final AsyncValue<TransactionsState> state;
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    final items = state.value?.items ?? const [];
    AppTransaction? selected;
    for (final t in items) {
      if (t.id == selectedId) {
        selected = t;
        break;
      }
    }
    if (selected == null) {
      return const EmptyView(
        icon: Icons.touch_app_rounded,
        title: 'Select a transaction',
        message: 'Choose an item from the list to see details.',
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.xl),
      child: TransactionDetailView(transaction: selected),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.accountIds,
    required this.selectedAccountId,
    required this.from,
    required this.to,
    required this.onApply,
  });

  final Map<String, String> accountIds;
  final String? selectedAccountId;
  final DateTime? from;
  final DateTime? to;
  final void Function(String? accountId, DateTime? from, DateTime? to) onApply;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  String? _accountId;
  DateTimeRange? _range;

  @override
  void initState() {
    super.initState();
    _accountId = widget.selectedAccountId;
    if (widget.from != null && widget.to != null) {
      _range = DateTimeRange(start: widget.from!, end: widget.to!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Spacing.lg,
        Spacing.sm,
        Spacing.lg,
        Spacing.lg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.lg),
          Text('Account', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: Spacing.sm),
          Wrap(
            spacing: Spacing.sm,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: _accountId == null,
                onSelected: (_) => setState(() => _accountId = null),
              ),
              for (final entry in widget.accountIds.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: _accountId == entry.key,
                  onSelected: (_) => setState(() => _accountId = entry.key),
                ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
          Text('Date range', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: Spacing.sm),
          OutlinedButton.icon(
            icon: const Icon(Icons.date_range_rounded),
            label: Text(
              _range == null
                  ? 'Any date'
                  : '${_range!.start.month}/${_range!.start.day} – ${_range!.end.month}/${_range!.end.day}',
            ),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                initialDateRange: _range,
              );
              if (picked != null) setState(() => _range = picked);
            },
          ),
          const SizedBox(height: Spacing.xl),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    widget.onApply(null, null, null);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear'),
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    widget.onApply(_accountId, _range?.start, _range?.end);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
