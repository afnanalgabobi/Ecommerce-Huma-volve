import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entities/home_product_entity.dart';
import '../repository/product_details_repository.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository _productDetailsRepository;
  GetProductDetailsUseCase(this._productDetailsRepository);
  Future<Either<Failure, HomeProductEntity>> invoke(int? productId) =>
      _productDetailsRepository.getProductById(productId);
}
