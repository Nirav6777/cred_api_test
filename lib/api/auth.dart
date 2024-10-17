import 'package:cred/helper/http_helper.dart';

class Auth {
  final HttpHelper httpHelper;

  Auth(String baseUrl, String apiKey, List<String> allowedSHA1Certificates)
      : httpHelper = HttpHelper(baseUrl, apiKey, allowedSHA1Certificates);

  Future<void> login(String username, String password) async {
    try {
      final response = await httpHelper.post(
        '/auth/login',
        {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        print("Login successful: ${response.body}");
      } else {
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  Future<void> logout() async {
    try {
      final response = await httpHelper.post('/auth/logout', {});

      if (response.statusCode == 200) {
        print("Logout successful: ${response.body}");
      } else {
        throw Exception("Logout failed: ${response.body}");
      }
    } catch (e) {
      print("Error during logout: $e");
    }
  }
}
