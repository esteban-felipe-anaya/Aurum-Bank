import 'package:dio/dio.dart';

import '../../core/error/error_mapper.dart';
import '../models/auth_models.dart';
import '../models/user.dart';

/// Authentication + current-user endpoints.
abstract interface class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<User> me();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/auth/register',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(res.data!);
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<User> me() async {
    try {
      final res = await _dio.get<Map<String, dynamic>>('/auth/me');
      final data = res.data!;
      // Supports both `{ user: {...} }` and a raw user object.
      final userJson = data['user'] is Map<String, dynamic>
          ? data['user'] as Map<String, dynamic>
          : data;
      return User.fromJson(userJson);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
