import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/accounts_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/beneficiaries_repository.dart';
import '../../data/repositories/cards_repository.dart';
import '../../data/repositories/insights_repository.dart';
import '../../data/repositories/notifications_repository.dart';
import '../../data/repositories/transactions_repository.dart';
import '../../data/repositories/transfer_repository.dart';
import '../network/dio_client.dart';
import '../storage/prefs_store.dart';
import '../storage/secure_token_store.dart';

/// Overridden in `main()` once SharedPreferences has been loaded.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final prefsStoreProvider = Provider<PrefsStore>(
  (ref) => PrefsStore(ref.watch(sharedPreferencesProvider)),
);

final secureTokenStoreProvider = Provider<SecureTokenStore>(
  (ref) => SecureTokenStore(),
);

/// The configured Dio instance shared across all repositories.
final dioProvider = Provider<Dio>((ref) {
  final tokenStore = ref.watch(secureTokenStoreProvider);
  return buildDio(tokenReader: tokenStore.readToken);
});

// ---------------------------------------------------------------------------
// Repository providers
// ---------------------------------------------------------------------------

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(dioProvider)),
);

final accountsRepositoryProvider = Provider<AccountsRepository>(
  (ref) => AccountsRepositoryImpl(ref.watch(dioProvider)),
);

final cardsRepositoryProvider = Provider<CardsRepository>(
  (ref) => CardsRepositoryImpl(ref.watch(dioProvider)),
);

final transactionsRepositoryProvider = Provider<TransactionsRepository>(
  (ref) => TransactionsRepositoryImpl(ref.watch(dioProvider)),
);

final beneficiariesRepositoryProvider = Provider<BeneficiariesRepository>(
  (ref) => BeneficiariesRepositoryImpl(ref.watch(dioProvider)),
);

final transferRepositoryProvider = Provider<TransferRepository>(
  (ref) => TransferRepositoryImpl(ref.watch(dioProvider)),
);

final insightsRepositoryProvider = Provider<InsightsRepository>(
  (ref) => InsightsRepositoryImpl(ref.watch(dioProvider)),
);

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepositoryImpl(ref.watch(dioProvider)),
);
