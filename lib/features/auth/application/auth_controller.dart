import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/providers.dart';
import '../../../data/models/auth_models.dart';
import '../../../data/models/user.dart';

/// Immutable auth session state.
class AuthSession {
  const AuthSession({this.user, this.authenticated = false});

  final User? user;
  final bool authenticated;

  static const unauthenticated = AuthSession();
}

/// Owns the authentication lifecycle: bootstrapping a persisted session,
/// login, register and logout. The router listens to this to gate routes.
class AuthController extends AsyncNotifier<AuthSession> {
  @override
  Future<AuthSession> build() async {
    final tokenStore = ref.read(secureTokenStoreProvider);
    final token = await tokenStore.readToken();
    if (token == null || token.isEmpty) {
      return AuthSession.unauthenticated;
    }
    // Token exists — try to hydrate the user, but stay authenticated even if
    // the (chaos-prone) /auth/me call fails.
    try {
      final user = await ref.read(authRepositoryProvider).me();
      return AuthSession(user: user, authenticated: true);
    } catch (_) {
      return const AuthSession(authenticated: true);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final res = await repo.login(
        LoginRequest(email: email, password: password),
      );
      await ref.read(secureTokenStoreProvider).writeToken(res.token);
      return AuthSession(user: res.user, authenticated: true);
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final res = await repo.register(
        RegisterRequest(name: name, email: email, password: password),
      );
      await ref.read(secureTokenStoreProvider).writeToken(res.token);
      return AuthSession(user: res.user, authenticated: true);
    });
  }

  /// Persists profile edits and updates the in-memory session user.
  Future<void> updateProfile(User updated) async {
    final saved = await ref.read(authRepositoryProvider).updateProfile(updated);
    final current = state.value;
    state = AsyncData(
      AuthSession(
        user: saved,
        authenticated: current?.authenticated ?? true,
      ),
    );
  }

  Future<void> logout() async {
    await ref.read(secureTokenStoreProvider).clear();
    state = const AsyncData(AuthSession.unauthenticated);
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthSession>(AuthController.new);
