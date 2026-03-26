import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } catch (e) {
      // For simplicity, we rethrow. In a real scenario, we'd map this to a Failure.
      rethrow;
    }
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async {
    try {
      return await remoteDataSource.register(name, email, password);
    } catch (e) {
      rethrow;
    }
  }
}
