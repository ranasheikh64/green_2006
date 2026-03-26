import 'package:dio/dio.dart';
import '../../../../core/constens/api_constants.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  /// Authenticate user via email and password
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Register user via name, email and password
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
