import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'skeletons.dart';
import 'status_views.dart';

/// Renders an [AsyncValue] with consistent loading / error / data handling.
///
/// Provide a [loading] skeleton appropriate to the screen; defaults to a
/// generic [ListSkeleton]. On error shows an [ErrorView] wired to [onRetry].
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
    this.skipLoadingOnRefresh = true,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final VoidCallback? onRetry;
  final bool skipLoadingOnRefresh;

  @override
  Widget build(BuildContext context) {
    // While refreshing, keep showing the previous data instead of a spinner.
    if (skipLoadingOnRefresh && value.isLoading && value.hasValue) {
      return data(value.requireValue);
    }
    return value.when(
      skipLoadingOnReload: skipLoadingOnRefresh,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      data: data,
      loading: () =>
          loading ??
          const Padding(padding: EdgeInsets.all(16), child: ListSkeleton()),
      error: (err, _) => ErrorView(error: err, onRetry: onRetry),
    );
  }
}
