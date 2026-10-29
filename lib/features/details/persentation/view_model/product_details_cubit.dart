import 'package:ecommerce_app_huma_volve/features/details/persentation/view_model/product_details_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_product_details_useCase.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStats> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit({required this.getProductDetailsUseCase})
    : super(ProductInit());

  Future<void> getProductById({required int? productId}) async {
    emit(ProductLoading());
    final result = await getProductDetailsUseCase.invoke(productId!);
    result.fold(
      (failure) {
        emit(ProductError(failure.failureMessage));
      },
      (product) {
        emit(ProductSuccess(product));
      },
    );
  }
}
