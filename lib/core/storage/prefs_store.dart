import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin typed wrapper over [SharedPreferences] for non-sensitive prefs
/// (theme mode, locale).
class PrefsStore {
  PrefsStore(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'theme_mode';
  static const _localeKey = 'locale';
  static const _onboardingKey = 'onboarding_seen';

  bool readOnboardingSeen() => _prefs.getBool(_onboardingKey) ?? false;

  Future<void> writeOnboardingSeen(bool seen) =>
      _prefs.setBool(_onboardingKey, seen);

  ThemeMode readThemeMode() {
    switch (_prefs.getString(_themeModeKey)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> writeThemeMode(ThemeMode mode) =>
      _prefs.setString(_themeModeKey, mode.name);

  String? readLocale() => _prefs.getString(_localeKey);

  Future<void> writeLocale(String? code) async {
    if (code == null) {
      await _prefs.remove(_localeKey);
    } else {
      await _prefs.setString(_localeKey, code);
    }
  }
}
