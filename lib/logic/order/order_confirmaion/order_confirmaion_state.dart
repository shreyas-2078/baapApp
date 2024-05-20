part of 'order_confirmaion_cubit.dart';

abstract class OrderDetailsState {
  OrderDetailsModel? orderModel;
  OrderDetailsState({this.orderModel});
}

class OrderDetailsInitial extends OrderDetailsState {
  OrderDetailsInitial({super.orderModel});
}

class OrderDetailsLoading extends OrderDetailsState {
  OrderDetailsLoading({super.orderModel});
}

class OrderDetailsError extends OrderDetailsState {
  final String? error;
  OrderDetailsError({this.error,super.orderModel});
}

class OrderDetailsLoaded extends OrderDetailsState {
  OrderDetailsLoaded({super.orderModel});
}
