import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/account.dart';

/// All of the user's accounts.
final accountsProvider = FutureProvider<List<Account>>(
  (ref) => ref.watch(accountsRepositoryProvider).getAccounts(),
);

/// Total available balance across non-credit accounts (in the primary
/// currency). Derived from [accountsProvider].
final totalBalanceProvider = Provider<AsyncValue<double>>((ref) {
  return ref.watch(accountsProvider).whenData((accounts) {
    return accounts
        .where((a) => a.type != 'credit')
        .fold<double>(0, (sum, a) => sum + a.balance);
  });
});

/// The currency code to display for headline figures (first account's, or USD).
final primaryCurrencyProvider = Provider<String>((ref) {
  final accounts = ref.watch(accountsProvider).value;
  return accounts != null && accounts.isNotEmpty
      ? accounts.first.currency
      : 'USD';
});
