import 'package:cred/helper/http_helper.dart';


class Category {
  final HttpHelper httpHelper;

  Category(String baseUrl, String apiKey, List<String> allowedSHA1Certificates)
      : httpHelper = HttpHelper(baseUrl, apiKey, allowedSHA1Certificates);

  Future<List<dynamic>> fetchAllCategories() async {
    try {
      final response = await httpHelper.get('/categories');

      if (response.statusCode == 200) {
        return List.from(response.bodyBytes);
      } else {
        throw Exception("Failed to fetch categories: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }

  Future<void> addCategory(Map<String, dynamic> categoryData) async {
    try {
      final response = await httpHelper.post('/categories', categoryData);

      if (response.statusCode != 201) {
        throw Exception("Failed to add category: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error adding category: $e");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final response = await httpHelper.delete('/categories/$categoryId');

      if (response.statusCode != 200) {
        throw Exception("Failed to delete category: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error deleting category: $e");
    }
  }
}
