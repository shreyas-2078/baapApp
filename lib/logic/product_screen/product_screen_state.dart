part of 'product_screen_cubit.dart';

abstract class ProductListState {
   List<ProductList>?  productModel; 
  ProductListState({this.productModel});
}

class ProductListInitial extends ProductListState {
  ProductListInitial({super.productModel});
}

class ProductListLoading extends ProductListState {
  ProductListLoading({super.productModel});
}

class ProductListLoaded extends ProductListState {
  ProductListLoaded({super.productModel});
}

class ProductListError extends ProductListState {
  final String? error;
  ProductListError({this.error, super.productModel});
}
