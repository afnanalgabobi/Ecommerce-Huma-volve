import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, HomeProductEntity>> getProductById(int? productId);
}
