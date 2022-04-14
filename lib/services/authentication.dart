import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingify/config.dart';

abstract class AuthenticationService {
  String? isAuthenticated();
  Future<String?> login(String email, String password);
  Future<String?> register(
      String email, String password, String firstName, String lastName);
  Future<void> logout();
}

class AuthenticationApiService implements AuthenticationService {
  final Dio _client = Dio();

  @override
  isAuthenticated() async {
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
      error.response?.data['message'] ?? error.message;
    }
  }

  @override
  Future<String?> register(
      String email, String password, String firstName, String lastName) async {
    Response response = await _client.post('');
    return '';
  }

  @override
  Future<void> logout() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('token');
  }
}
