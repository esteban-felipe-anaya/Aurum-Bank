import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/bank_card.dart';

/// Holds the card list and exposes freeze/unfreeze and add-card mutations.
class CardsController extends AsyncNotifier<List<BankCard>> {
  @override
  Future<List<BankCard>> build() =>
      ref.read(cardsRepositoryProvider).getCards();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(cardsRepositoryProvider).getCards(),
    );
  }

  Future<void> toggleFreeze(String id) async {
    final current = state.value;
    if (current == null) return;
    final card = current.firstWhere((c) => c.id == id);
    final updated = await ref
        .read(cardsRepositoryProvider)
        .setFrozen(id, frozen: !card.frozen);
    state = AsyncData([for (final c in current) c.id == id ? updated : c]);
  }

  Future<void> addCard(BankCard card) async {
    final created = await ref.read(cardsRepositoryProvider).addCard(card);
    state = AsyncData([...?state.value, created]);
  }
}

final cardsControllerProvider =
    AsyncNotifierProvider<CardsController, List<BankCard>>(CardsController.new);

/// Single card by id — served from the already-loaded list when possible.
final cardDetailProvider = FutureProvider.family<BankCard, String>((
  ref,
  id,
) async {
  final list = ref.watch(cardsControllerProvider).value;
  if (list != null) {
    final match = list.where((c) => c.id == id);
    if (match.isNotEmpty) return match.first;
  }
  return ref.read(cardsRepositoryProvider).getCard(id);
});
