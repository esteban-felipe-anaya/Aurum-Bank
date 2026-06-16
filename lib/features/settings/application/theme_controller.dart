import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';

/// Persists and exposes the app [ThemeMode] (light/dark/system).
class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(prefsStoreProvider).readThemeMode();

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(prefsStoreProvider).writeThemeMode(mode);
  }
}

final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

/// Persists and exposes the selected locale (null = system).
class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() {
    final code = ref.watch(prefsStoreProvider).readLocale();
    return code == null ? null : Locale(code);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    await ref.read(prefsStoreProvider).writeLocale(locale?.languageCode);
  }
}

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);
