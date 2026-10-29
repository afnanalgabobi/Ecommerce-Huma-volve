import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entities/home_product_entity.dart';
import '../../domain/repository/product_details_repository.dart';
import '../data_source/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImp implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource _productDetailsRemoteDataSource;
  ProductDetailsRepositoryImp(this._productDetailsRemoteDataSource);

  @override
  Future<Either<Failure, HomeProductEntity>> getProductById(
    int? productId,
  ) async {
    try {
      final product = await _productDetailsRemoteDataSource.getProductById(
        productId,
      );
      return Right(product as HomeProductEntity);
    } catch (e) {
      return Left(Failure(failureMessage: e.toString()));
    }
  }
}
