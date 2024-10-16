import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String _baseUrl = "https://api.yourservice.com"; // Change to your actual base URL

  Future<List<dynamic>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load products: ${response.body}");
    }
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productData),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add product: ${response.body}");
    }
  }

  Future<void> deleteProduct(String productId) async {
    final response = await http.delete(Uri.parse('$_baseUrl/products/$productId'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete product: ${response.body}");
    }
  }
}
