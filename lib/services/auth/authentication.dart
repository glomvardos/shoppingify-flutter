import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shoppingify/config.dart';
import 'package:shoppingify/services/interfaces/auth_interface.dart';
import 'package:shoppingify/utils/shared_prefs.dart';
part 'exception.dart';

class AuthenticationApi implements AuthenticationService {
  final Dio _client;

  AuthenticationApi() : _client = Dio(BaseOptions(baseUrl: Config.API_URL));

  @override
  get client => _client;

  @override
  Future<String?> isAuthenticated() async {
    _client.options.headers['Authorization'] =
        'Bearer ${sharedPrefs.getKey('token')}';

    final String? token = sharedPrefs.getKey('token');

    return token;
  }

  @override
  Future<void> getAuthUser() async {
    try {
      final response = await _client.get('/auth/user');
      await sharedPrefs.addKey('user', json.encode(response.data));
    } on DioError catch (error) {
      throw AuthenticationException(message: error.response!.data['message']);
    }
  }

  @override
  Future<String?> login(String email, String password) async {
    try {
      Response response = await _client
          .post('/auth/signin', data: {"email": email, "password": password});
      await sharedPrefs.addKey('token', response.data['access']);
      final String? token = sharedPrefs.getKey('token');
      _client.options.headers['Authorization'] = 'Bearer $token';

      if (token != null) {
        await getAuthUser();
      }

      return token;
    } on DioError catch (error) {
      throw AuthenticationException(message: error.response!.data['message']);
    }
  }

  @override
  Future<Response> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final Response response = await _client.post('/auth/signup', data: {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    });

    return response;
  }

  @override
  Future<Response> deleteUser() async {
    try {
      final Response response = await _client.delete('/auth/user');
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await sharedPrefs.removeKey('token');
    await sharedPrefs.removeKey('user');
  }
}
