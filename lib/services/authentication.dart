import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingify/config.dart';
part 'exception.dart';

abstract class AuthenticationService {
  Future<String?> isAuthenticated();
  Future<String?> login(String email, String password);
  Future<bool> register(
      String email, String password, String firstName, String lastName);
  Future<void> logout();
}

class AuthenticationApiService implements AuthenticationService {
  final Dio _client = Dio();

  @override
  Future<String?> isAuthenticated() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString('token');

    return token;
  }

  @override
  Future<String?> login(String email, String password) async {
    final _prefs = await SharedPreferences.getInstance();
    try {
      Response response = await _client.post('${Config.API_URL}/auth/signin',
          data: {"email": email, "password": password});

      await _prefs.setString('token', response.data['access']);
      final token = _prefs.getString('token');
      return token;
    } on DioError catch (error) {
      throw AuthenticationException(message: error.response!.data['message']);
    }
  }

  @override
  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    Response response =
        await _client.post('${Config.API_URL}/auth/signup', data: {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    });

    return response.data['access'] != null ? true : false;
  }

  @override
  Future<void> logout() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('token');
  }
}
