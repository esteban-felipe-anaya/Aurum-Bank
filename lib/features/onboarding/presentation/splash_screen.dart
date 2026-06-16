import 'package:flutter/material.dart';

import '../../../core/theme/design_tokens.dart';

/// Branded splash shown while the persisted session is being restored. The
/// router redirects away once auth bootstrapping completes.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1),
              duration: Motion.slow,
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: Radii.cardLg,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0C1130).withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: Radii.cardLg,
                  child: Image.asset(
                    'assets/icon/aurum_icon.png',
                    width: 96,
                    height: 96,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Spacing.xl),
            Text(
              'Aurum Bank',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: Spacing.xxxl),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      ),
    );
  }
}
