library cred;

import 'api/auth.dart';
import 'api/product.dart';
import 'api/category.dart';

class Cred {
  final Auth auth;
  final Product product;
  final Category category;

  Cred()
      : auth = Auth(),
        product = Product(),
        category = Category();
}
