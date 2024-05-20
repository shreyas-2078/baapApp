import 'package:baapapp/main.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/place_order_response_model/place_order_response_model.dart';
import '../../../repositories/order/order_repo.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final OrderRepo _placeOrderRepo = OrderRepo();
  PlaceOrderCubit() : super(PlaceOrderInitial());

  void saveOrder(
    BuildContext context, {
    double? totalCartPrice,
    int? subtotal,
    int? saving,
    double? taxes,
    int? userId,
    int? groupId,
    int? cartId,
    int? totalProductQuantity,
    String? userName,
    String? paymentStatus,
    String? txnId,
    String? currency,
    String? streetAddress,
    String? locality,
    String? city,
    String? state,
    String? zip,
    String? paymentMode,
    String? paymentUPI,
    DateTime? transactionDate,
    List<Map<String, dynamic>?>? orderDetails,
  }) async {
    var latGetStorage = GetStorage().read('latitude');
    var lonGetStorage = GetStorage().read('longitude');
    var loggedInUser = LocalStorageUtils.tokenResponseModel.userId;
    var payload = {
      "groupId": groupId ?? apiEndpoints.experienceGroupId,
      "userId": userId,
      "orderDetails": orderDetails,
      "subtotal": subtotal,
      "saving": saving,
      "taxes": taxes,
      "totalCartPrice": totalCartPrice,
      "totalProductQuantity": totalProductQuantity,
      "currency": currency,
      "source": "app",
      "delivery_info": {
        "shipping_address": {
          "street": streetAddress,
          "locality": locality,
          "city": city,
          "state": state,
          "zip": zip,
        }
      },
      "paymentInfo": {
        "mode": paymentMode,
        'upi': paymentUPI,
        'paymentStatus': paymentStatus,
        'transactionDate': transactionDate,
        'txnId': txnId,
        "loggedInUser": loggedInUser,
      },
      "lat": latGetStorage,
      "lon": lonGetStorage,
    };   
    emit(PlaceOrderLoading());
    var response = await _placeOrderRepo.placeOrder(payload);
    response.fold((error) {
      emit(PlaceOrderError(error: error.message));
    }, (data) async {
      emit(PlaceOrderLoaded(placeOrderModel: data.data));
    });
  }
}
