import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class HomeStats {}

class HomeInitial extends HomeStats {}

class CategoriesLoading extends HomeStats {}

class CategoriesSuccess extends HomeStats {
  final List<HomeCategoryEntity> categories;
  CategoriesSuccess(this.categories);
}

class CategoriesError extends HomeStats {
  final String errorMessage;
  CategoriesError(this.errorMessage);
}

class ProductsLoading extends HomeStats {}

class ProductsLoadingMore extends HomeStats {}

class ProductsLoadingError extends HomeStats {
  final String errorMessage;
  ProductsLoadingError(this.errorMessage);
}

class ProductsError extends HomeStats {
  ProductsError(this.errorMessage);

  final String errorMessage;
}

class ProductsSuccess extends HomeStats {
  ProductsSuccess(this.products);

  final List<HomeProductEntity> products;
}
class ProductSuccess extends HomeStats {
final HomeProductEntity product;
ProductSuccess(this.product);
}
class ProductError extends HomeStats {
  final String errorMessage;
  ProductError(this.errorMessage);
}
class ProductLoading extends HomeStats {}
