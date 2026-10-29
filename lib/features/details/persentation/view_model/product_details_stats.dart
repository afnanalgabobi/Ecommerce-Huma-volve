import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class ProductDetailsStats {}

class ProductSuccess extends ProductDetailsStats {
  final HomeProductEntity product;
  ProductSuccess(this.product);
}

class ProductError extends ProductDetailsStats {
  final String errorMessage;
  ProductError(this.errorMessage);
}

class ProductLoading extends ProductDetailsStats {}
class ProductInit extends ProductDetailsStats {}
