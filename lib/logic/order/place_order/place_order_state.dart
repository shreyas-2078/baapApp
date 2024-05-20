part of 'place_order_cubit.dart';

abstract class PlaceOrderState {
  PlaceOrderModel? placeOrderModel;
  PlaceOrderState({this.placeOrderModel});
}

class PlaceOrderInitial extends PlaceOrderState {
  PlaceOrderInitial({super.placeOrderModel});
}

class PlaceOrderLoading extends PlaceOrderState {
  PlaceOrderLoading({super.placeOrderModel});
}

class PlaceOrderError extends PlaceOrderState {
  final String? error;
  PlaceOrderError({this.error,super.placeOrderModel});
}

class PlaceOrderLoaded extends PlaceOrderState {
  PlaceOrderLoaded({super.placeOrderModel});
}
