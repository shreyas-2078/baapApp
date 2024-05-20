part of 'product_category_cubit.dart';

abstract class ProductCategoryState {
  List<ProductCategoryModel>? productCategoryModel;
  ProductCategoryState({this.productCategoryModel});
}

class HomePageInitital extends ProductCategoryState {
  HomePageInitital({ super.productCategoryModel});
}

class ProductCategoryLoading extends ProductCategoryState {
  ProductCategoryLoading({ super.productCategoryModel});
}

class ProductCategoryLoaded extends ProductCategoryState {
  ProductCategoryLoaded({super.productCategoryModel});
}

class ProductCategoryError extends ProductCategoryState {
  final String? error;
  ProductCategoryError({this.error, super.productCategoryModel});
}
