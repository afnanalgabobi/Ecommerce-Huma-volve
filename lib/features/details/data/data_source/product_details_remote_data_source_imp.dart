import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_manager.dart';

class ProductDetailsRemoteDataSourceImp
    implements ProductDetailsRemoteDataSource {
  ApiManager apiManager;
  ProductDetailsRemoteDataSourceImp(this.apiManager);
  @override
  Future<ProductModel> getProductById(int? productId) async {
    final response = await ApiManager().dio.get(
      "${ApiEndpoints.productsEndpoint}/$productId",
    );
    final Map<String, dynamic> jsonData = response.data;
    final ProductModel dartData = ProductModel.fromJson(jsonData);
    print("\n\n >>>>>>>>>>>>>${dartData}>>>>>>>>>\n\n");

    return dartData ;
  }
}
