import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Sign in with email and password
  Future<UserEntity> login(String email, String password);

  /// Register a new user
  Future<UserEntity> register(String name, String email, String password);
}
