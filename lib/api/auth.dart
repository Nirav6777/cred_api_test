import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  final String _baseUrl = "https://api.yourservice.com"; // Change to your actual base URL

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Handle successful login
      print("Login successful: ${response.body}");
    } else {
      // Handle errors
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful logout
      print("Logout successful: ${response.body}");
    } else {
      // Handle errors
      throw Exception("Logout failed: ${response.body}");
    }
  }
}
