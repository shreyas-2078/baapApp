import 'package:baapapp/models/order_list/order_list_response_model.dart';
import 'package:baapapp/repositories/order/order_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:bloc/bloc.dart';
part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  OrderListCubit() : super(OrderListInitial());

  final OrderRepo _orderRepo = OrderRepo();

  void getOrderList() async {
    var userId = LocalStorageUtils.tokenResponseModel.userId;

    try {
      emit(OrderListLoading());
      var data = await _orderRepo.getOrderList(userId: userId);
      data.fold((error) {
        emit(OrderListError());
      }, (data) {
        emit(OrderListLoaded(orderModel: data.data?.items));
      });
    } catch (e) {
      emit(OrderListError(error: e.toString()));
    }
  }
}
