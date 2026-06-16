import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/color_utils.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../auth/application/auth_controller.dart';
import '../application/theme_controller.dart';

const _locales = <String, Locale?>{
  'System default': null,
  'English': Locale('en'),
  'Español': Locale('es'),
  'Français': Locale('fr'),
  'Deutsch': Locale('de'),
};

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _biometricUnlock = false;
  bool _hideBalances = false;

  String _localeLabel(Locale? locale) {
    for (final entry in _locales.entries) {
      if (entry.value?.languageCode == locale?.languageCode) return entry.key;
    }
    return 'System default';
  }

  Future<void> _pickLanguage() async {
    final current = ref.read(localeControllerProvider);
    final selected = await showDialog<Object>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Language'),
        children: [
          for (final entry in _locales.entries)
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.of(context).pop(entry.value ?? _systemSentinel),
              child: Row(
                children: [
                  Icon(
                    entry.value?.languageCode == current?.languageCode
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: Spacing.md),
                  Text(entry.key),
                ],
              ),
            ),
        ],
      ),
    );
    if (selected != null) {
      final locale = selected == _systemSentinel ? null : selected as Locale;
      await ref.read(localeControllerProvider.notifier).set(locale);
    }
  }

  static const _systemSentinel = 'system';

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authControllerProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).value?.user;
    final themeMode = ref.watch(themeModeControllerProvider);
    final locale = ref.watch(localeControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: MaxWidthBody(
        maxWidth: 640,
        child: ListView(
          padding: const EdgeInsets.all(Spacing.lg),
          children: [
            // Profile
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colorFromHex(user?.avatarColor),
                      child: Text(
                        (user?.name.isNotEmpty ?? false) ? user!.name[0] : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: Spacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Aurum member',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (user?.email != null)
                            Text(
                              user!.email,
                              style: TextStyle(color: scheme.onSurfaceVariant),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Appearance
            _SectionTitle('Appearance'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: Spacing.md),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto_rounded),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.light_mode_rounded),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.dark_mode_rounded),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (s) => ref
                          .read(themeModeControllerProvider.notifier)
                          .set(s.first),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Preferences
            _SectionTitle('Preferences'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language_rounded),
                    title: const Text('Language'),
                    subtitle: Text(_localeLabel(locale)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _pickLanguage,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.visibility_off_rounded),
                    title: const Text('Hide balances'),
                    subtitle: const Text('Blur amounts on the home screen'),
                    value: _hideBalances,
                    onChanged: (v) => setState(() => _hideBalances = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Security
            _SectionTitle('Security'),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.fingerprint_rounded),
                    title: const Text('Biometric unlock'),
                    subtitle: const Text(
                      'Use Face ID / fingerprint to sign in',
                    ),
                    value: _biometricUnlock,
                    onChanged: (v) => setState(() => _biometricUnlock = v),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock_reset_rounded),
                    title: const Text('Change password'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Password reset is coming soon'),
                        ),
                      ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.xl),

            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.errorContainer,
                foregroundColor: scheme.onErrorContainer,
              ),
              onPressed: _confirmLogout,
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Log out'),
            ),
            const SizedBox(height: Spacing.lg),
            Center(
              child: Text(
                'Aurum Bank • v1.0.0',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xs, bottom: Spacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
