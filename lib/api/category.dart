import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {
  final String _baseUrl = "https://api.yourservice.com"; // Change to your actual base URL

  Future<List<dynamic>> fetchAllCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load categories: ${response.body}");
    }
  }

  Future<void> addCategory(Map<String, dynamic> categoryData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/categories'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoryData),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add category: ${response.body}");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/categories/$categoryId'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete category: ${response.body}");
    }
  }
}
