import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/repository/product_details_repository_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_manager.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../home/persentation/view_model/home_cubit.dart';
import '../../../home/persentation/view_model/home_stats.dart';
import '../../data/data_source/product_details_remote_data_source.dart';
import '../../domain/repository/product_details_repository.dart';
import '../../domain/use_cases/get_product_details_useCase.dart';
import '../view_model/product_details_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int? productId;

  ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final ApiManager _apiManager;
  late final ProductDetailsRemoteDataSource _productDetailsRemoteDataSource;
  late final ProductDetailsRepository _productDetailsRepository;
  late final GetProductDetailsUseCase _getProductDetailsUseCase;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailsCubit>().getProductById(productId: widget.productId);
    _apiManager = ApiManager();
    _productDetailsRemoteDataSource = ProductDetailsRemoteDataSourceImp(_apiManager);
    _productDetailsRepository = ProductDetailsRepositoryImp(_productDetailsRemoteDataSource);
    _getProductDetailsUseCase = GetProductDetailsUseCase(_productDetailsRepository);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: BlocBuilder<HomeCubit, HomeStats>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 48),
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.primary),
                ),
              ),
            );
          }
          if (state is ProductError) {
            return SliverToBoxAdapter(child: Text(state.errorMessage));
          }
          if (state is ProductSuccess) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  backgroundColor: AppTheme.background,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, size: 18),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'product-${widget.productId}',
                      child: Image.network(
                        state.product.images![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40.0,
                        horizontal: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  state.product.title ?? 'product',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(fontSize: 28, height: 1.2),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '\$${state.product.price!.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: AppTheme.primary,
                                      fontSize: 24,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.product.description ?? '',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(height: 1.6, fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Select Color',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          // ColorSelector(
                          //   colors: widget.product.colors,
                          //   selectedColor: _selectedColor,
                          //   onColorSelected: (color) {
                          //     setState(() {
                          //       _selectedColor = color;
                          //     });
                          //   },
                          // ),
                          const SizedBox(height: 24),
                          Text(
                            'Select Size',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          // SizeSelector(
                          //   sizes: widget.product.sizes,
                          //   selectedSize: _selectedSize,
                          //   onSizeSelected: (size) {
                          //     setState(() {
                          //       _selectedSize = size;
                          //     });
                          //   },
                          // ),
                          const SizedBox(height: 32),
                          PrimaryButton(
                            text: 'Add to Cart',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${state.product.title} added to cart',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
      ),
    );
  }
}
