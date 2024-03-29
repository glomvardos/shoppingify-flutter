import 'package:dio/dio.dart';

abstract class AuthenticationService {
  Future<String?> isAuthenticated();
  Future<void> getAuthUser();
  Future<String?> login(String email, String password);
  Future<Response> register(
      String email, String password, String firstName, String lastName);
  Future<Response> deleteUser();
  Future<void> logout();

  get client => Dio();
}
