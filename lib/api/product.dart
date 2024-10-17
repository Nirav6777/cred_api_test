
import 'package:cred/helper/http_helper.dart';

class Product {
  final HttpHelper httpHelper;

  Product(String baseUrl, String apiKey, List<String> allowedSHA1Certificates)
      : httpHelper = HttpHelper(baseUrl, apiKey, allowedSHA1Certificates);

  Future<List<dynamic>> fetchAllProducts() async {
    try {
      final response = await httpHelper.get('/products');

      if (response.statusCode == 200) {
        return List.from(response.bodyBytes);
      } else {
        throw Exception("Failed to fetch products: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      final response = await httpHelper.post('/products', productData);

      if (response.statusCode != 201) {
        throw Exception("Failed to add product: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error adding product: $e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final response = await httpHelper.delete('/products/$productId');

      if (response.statusCode != 200) {
        throw Exception("Failed to delete product: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error deleting product: $e");
    }
  }
}
