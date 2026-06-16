import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/cards/presentation/add_card_screen.dart';
import '../../features/cards/presentation/card_detail_screen.dart';
import '../../features/cards/presentation/cards_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/insights/presentation/insights_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/application/onboarding_controller.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../features/transactions/presentation/transaction_detail_screen.dart';
import '../../features/transactions/presentation/transactions_screen.dart';
import '../../features/transfer/presentation/transfer_flow_screen.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Bridges Riverpod auth/onboarding state into a [Listenable] so GoRouter
/// re-evaluates `redirect` whenever the session changes.
class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(this._ref) {
    _ref.listen(authControllerProvider, (_, _) => notifyListeners());
    _ref.listen(onboardingSeenProvider, (_, _) => notifyListeners());
  }
  final Ref _ref;
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final onboardingSeen = ref.read(onboardingSeenProvider);
      final loc = state.matchedLocation;

      const authRoutes = {
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      };
      final isAuthRoute = authRoutes.contains(loc);
      final isSplash = loc == AppRoutes.splash;
      final isOnboarding = loc == AppRoutes.onboarding;

      // Still bootstrapping the persisted session → hold on splash.
      if (auth.isLoading) return isSplash ? null : AppRoutes.splash;

      final authed = auth.value?.authenticated ?? false;

      if (authed) {
        if (isSplash || isOnboarding || isAuthRoute) return AppRoutes.dashboard;
        return null;
      }

      // Unauthenticated.
      if (!onboardingSeen) {
        return isOnboarding ? null : AppRoutes.onboarding;
      }
      if (isAuthRoute || isOnboarding) return null;
      return AppRoutes.login;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.transfer,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const TransferFlowScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addCard,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, _) => const AddCardScreen(),
      ),
      // Adaptive shell with bottom-nav / rail branches.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.dashboard,
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.transactions,
                builder: (_, _) => const TransactionsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, state) => TransactionDetailScreen(
                      transactionId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cards,
                builder: (_, _) => const CardsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (_, state) =>
                        CardDetailScreen(cardId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.insights,
                builder: (_, _) => const InsightsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (_, _) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
