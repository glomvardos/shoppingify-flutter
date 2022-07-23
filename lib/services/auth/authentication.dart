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

    return sharedPrefs.getKey('token');
  }

  @override
  Future<String?> login(String email, String password) async {
    try {
      Response response = await _client.post('${Config.API_URL}/auth/signin',
          data: {"email": email, "password": password});
      await sharedPrefs.addKey('token', response.data['access']);

      _client.options.headers['Authorization'] =
          'Bearer ${sharedPrefs.getKey('token')}';

      return sharedPrefs.getKey('token');
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
    Response response = await _client.post('/auth/signup', data: {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    });

    return response;
  }

  @override
  Future<void> logout() async {
    await sharedPrefs.removeKey('token');
  }
}
