import 'api/auth.dart';
import 'api/product.dart';
import 'api/category.dart';

class Cred {
  static final Cred _instance = Cred._internal();

  late Auth auth;
  late Product product;
  late Category category;

  factory Cred() {
    return _instance;
  }

  Cred._internal();

  void initialize({
    required String baseUrl,
    required String apiKey,
    required List<String> allowedSHA1Certificates,
  }) {
    auth = Auth(baseUrl, apiKey, allowedSHA1Certificates);
    product = Product(baseUrl, apiKey, allowedSHA1Certificates);
    category = Category(baseUrl, apiKey, allowedSHA1Certificates);
  }
}
