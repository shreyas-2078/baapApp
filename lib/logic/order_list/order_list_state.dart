part of 'order_list_cubit.dart';

abstract class OrderListState {
  List<OrderData>? orderModel;
  OrderListState({this.orderModel});
}

class OrderListInitial extends OrderListState {
  OrderListInitial({super.orderModel});
}

class OrderListLoading extends OrderListState {
  OrderListLoading({super.orderModel});
}
class OrderListLoaded extends OrderListState {
  OrderListLoaded({super.orderModel});
}
class OrderListError extends OrderListState {
  final String? error;
  OrderListError({this.error, super.orderModel});
}

