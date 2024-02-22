import '../../../../models/product_model.dart';

abstract class ProductRepository {
  Future<ProductModel> fetchProducts();
  // Future<ProductModel> fetchProduct(int id);
}
