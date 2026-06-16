import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';

/// Tracks whether the user has completed the onboarding intro.
class OnboardingController extends Notifier<bool> {
  @override
  bool build() => ref.watch(prefsStoreProvider).readOnboardingSeen();

  Future<void> complete() async {
    state = true;
    await ref.read(prefsStoreProvider).writeOnboardingSeen(true);
  }
}

final onboardingSeenProvider = NotifierProvider<OnboardingController, bool>(
  OnboardingController.new,
);
