import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/order_details_response_model/order_details_response_model.dart';
import '../../../repositories/order/order_repo.dart';

part 'order_confirmaion_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrderRepo _orderRepo = OrderRepo();
  OrderDetailsCubit() : super(OrderDetailsInitial());

  void getOrderConfirmation(int? groupId, int? orderId) async {
    emit(OrderDetailsLoading());
    var response = await _orderRepo.getOrderDetails(
      groupId: groupId,
      orderId: orderId,
    );
    response.fold((error) {
      emit(OrderDetailsError(error: error.message));
    }, (data) async {
      emit(OrderDetailsLoaded(orderModel: data.data?.items?[0]));
    });
  }
}
