
import '../../../home/data/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductModel> getProductById(int? productId);
}
