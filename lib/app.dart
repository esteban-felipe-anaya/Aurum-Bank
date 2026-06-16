import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/application/theme_controller.dart';

/// Locales the app advertises support for (UI strings stay English; this
/// drives Material/intl localization and date/number formatting).
const supportedAppLocales = [
  Locale('en'),
  Locale('es'),
  Locale('fr'),
  Locale('de'),
];

class FintechApp extends ConsumerWidget {
  const FintechApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(localeControllerProvider);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightScheme = lightDynamic != null
            ? lightDynamic.harmonized()
            : AppTheme.lightScheme();
        final darkScheme = darkDynamic != null
            ? darkDynamic.harmonized()
            : AppTheme.darkScheme();

        return MaterialApp.router(
          title: 'Aurum Bank',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(lightScheme),
          darkTheme: AppTheme.dark(darkScheme),
          themeMode: themeMode,
          locale: locale,
          supportedLocales: supportedAppLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: router,
        );
      },
    );
  }
}
