import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/biller.dart';

/// Payees available in the "Pay bills" flow.
final billersProvider = FutureProvider<List<Biller>>(
  (ref) => ref.watch(paymentsRepositoryProvider).getBillers(),
);
