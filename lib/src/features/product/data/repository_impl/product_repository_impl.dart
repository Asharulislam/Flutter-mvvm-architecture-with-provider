import 'package:flutter_architecture_mvvm_with_provider/src/app_constants/enums/api_path_enum.dart';
import 'package:flutter_architecture_mvvm_with_provider/src/network_module/nework_service.dart';
import '../../../../models/product_model.dart';
import '../../../../network_module/api_path.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final NetworkService networkService;

  ProductRepositoryImpl({required this.networkService});

  @override
  Future<ProductModel> fetchProducts() async {
    final response = await networkService.getData(
      APIPathHelper.getValue(APIPath.products),
    );

    return ProductModel.fromJson(response);
  }

  // @override
  // Future<Product> fetchProduct(int id) async {
  //   final jsonData = await networkService.get('/products/$id');
  //   return Product.fromJson(jsonData);
  // }
}
