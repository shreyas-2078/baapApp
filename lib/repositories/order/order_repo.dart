import 'package:baapapp/main.dart';
import 'package:baapapp/models/order_list/order_list_response_model.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:dartz/dartz.dart';

import '../../models/order_details_response_model/order_details_response_model.dart';
import '../../models/place_order_response_model/place_order_response_model.dart';
import '../../utils/api/api_exceptions.dart';
import '../../utils/api/failure.dart';

class OrderRepo {
  final ApiManager _apiManager = ApiManager();

  Future<Either<Failure, PlaceOrderResponseModel>> placeOrder(
      Map<String, Object?> data) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.commerceGateway}${apiEndpoints.order}",
          data);
      var response = PlaceOrderResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, OrderDetailsResponseModel>> getOrderDetails(
      {int? orderId, int? groupId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getOrderDetailsByGroupId}$groupId?orderId=$orderId");
      var response = OrderDetailsResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, OrderListResponseModel>> getOrderList(
      {int? userId}) async {
    try {
      var jsonResponse = await _apiManager.get(
        "${apiEndpoints.baseUrl}${apiEndpoints.getOrderList}${apiEndpoints.experienceGroupId}?userId=$userId",
        isTokenMandatory: true,
      );
      var response = OrderListResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
