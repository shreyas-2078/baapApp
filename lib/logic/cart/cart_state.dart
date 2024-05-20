part of 'cart_cubit.dart';

abstract class CartState {
  final CartResponseModel? data;
  const CartState(this.data);
}

class CartInitial extends CartState {
  const CartInitial(super.cartResponseModel);

  List<Object?> get props => [];
}

class CartLoading extends CartState {
  const CartLoading(super.cartResponseModel);

  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  const CartLoaded(super.cartResponseModel);

  List<Object?> get props => [super.data];
}

class CartError extends CartState {
  final String error;
  const CartError(super.cartResponseModel, this.error);

  List<Object?> get props => [];
}

class CartAddSuccess extends CartState {
  CartAddSuccess(super.data);
}

class CartQuantityIncrement extends CartState {
  final int? value;
  const CartQuantityIncrement(super.cartResponseModel, this.value);

  List<Object?> get props => [];
}

class CartQuantityDecrement extends CartState {
  final int value;
  const CartQuantityDecrement(super.cartResponseModel, this.value);

  List<Object?> get props => [];
}

class QuantityLoading extends CartState {
  const QuantityLoading(super.cartResponseModel);

  List<Object?> get props => [];
}
