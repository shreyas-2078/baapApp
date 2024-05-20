import 'package:baapapp/main.dart';
import 'package:baapapp/models/cart_model/add_cart_response_model.dart';
import 'package:baapapp/utils/api/api_exceptions.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:baapapp/utils/api/failure.dart';
import 'package:dartz/dartz.dart';
import '../models/cart_model/get_cart_response_model.dart';
import '../models/cart_model/update_cart_response_model.dart';
import '../models/default_address_response_model/default_address_response_model.dart';

class CartRepo {
  final _apiManager = ApiManager();

  Future<Either<Failure, CartResponseModel>> getCartByGroupIdAndUserId(
      {required int? groupId, required int? userId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getCartByUserId}$groupId/$userId");
      var response = CartResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, DefalutAddressResponseModel>> getDefaultByUserId(
      {required int? groupId, required int? userId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getDefaultAddress}/$groupId/$userId");
      var response = DefalutAddressResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, AddCartResponseModel>> addToCart(    
      Map<String, Object?> data) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.baseUrl}${apiEndpoints.cart}", data);
      var response = AddCartResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, UpdateCartResponseModel>> updateCartProduct(
    int? groupId,
    Map<String, Object?> data,
    int? userId,
    int? productCode,
  ) async {
    try {
      var jsonResponse = await _apiManager.put(
          "${apiEndpoints.baseUrl}${apiEndpoints.cart}$groupId/$userId/$productCode",
          data);
      var response = UpdateCartResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, dynamic>> deleteCartByProductId(
      {int? groupId, int? cartId, int? productCode}) async {
    try {
      var jsonResponse = await _apiManager.delete(
          "${apiEndpoints.baseUrl}${apiEndpoints.cart}/$groupId/$cartId/$productCode");
      var response = AddCartResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
