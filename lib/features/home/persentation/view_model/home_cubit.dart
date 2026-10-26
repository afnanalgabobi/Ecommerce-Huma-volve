import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/persentation/view_model/home_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStats> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  int _selectedCategory = 0;
  int _limit = 10;
  int _offset = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  final List<HomeProductEntity> _products = [];
  void loadingData() async {
    emit(CategoriesLoading());

    final categoriesResult = await getCategoriesUseCase.invoke();
    categoriesResult.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
        return null;
      },
      (categories) {
        _selectedCategory = categories.first.id;
        emit(CategoriesSuccess(categories));
        getProducts(categoryId: _selectedCategory);
      },
    );
  }

  void changeSelectedCategory({required int categoryId}) async {
    _selectedCategory = categoryId;
    _offset = 0;
    _limit = 10;
    _products.clear();
    _isLoadingMore = false;
    _hasMore = true;
    await getProducts(categoryId: _selectedCategory);
  }

  Future<void> getProducts({required categoryId}) async {
    emit(ProductsLoading());
    _hasMore = true;

    final result = await getProductsUseCase.invoke(
      categoryId,
      offset: _offset,
      limit: _limit,
    );
    result.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        _products.clear();
        _products.addAll(products);
        _offset = products.length;

        if (products.length < _limit) {
          _hasMore = false;
        }
        // _categoryId = categoryId;
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    emit(ProductsLoading());
    final result = await getProductsUseCase.invoke(
      _selectedCategory,
      offset: _offset,
      limit: _limit,
    );
    result.fold(
      (failure) {
        emit(ProductsLoadingError(failure.failureMessage));
      },
      (newProducts) {
        _products.addAll(newProducts);
        _offset += newProducts.length;
        if (newProducts.length < _limit) {
          _hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

}
