import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/insights.dart';

final insightsProvider = FutureProvider<Insights>(
  (ref) => ref.watch(insightsRepositoryProvider).getSpending(),
);
