import 'package:baapapp/main.dart';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';

import 'package:baapapp/utils/api/api_exceptions.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:baapapp/utils/api/failure.dart';
import 'package:dartz/dartz.dart';

class ProfileRepo {
  final ApiManager _apiManager = ApiManager();

  Future<Either<Failure, CustomerResponseModel>> getCustomerData(
      int? userId) async {
    try {
      var jsonResponse = await _apiManager
          .get("${apiEndpoints.baseUrl}${apiEndpoints.getCustomer}$userId");
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CustomerResponseModel>> updateCustomerData(
      int? userId, data) async {
    try {
      var jsonResponse = await _apiManager.put(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.commerceGateway}${apiEndpoints.updateCustomer}$userId", data);
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CustomerResponseModel>> updateCustomerUpi(
      int? userId, data) async {
    try {
      var jsonResponse = await _apiManager.put(
          "${apiEndpoints.baseUrl}${apiEndpoints.updateCustomerUPI}$userId",
          data);
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CustomerResponseModel>> updateAddress(
      {int? addressId, int? userId, data}) async {
    try {
      var jsonResponse = await _apiManager.put(
          "${apiEndpoints.baseUrl}${apiEndpoints.updateAddress}${apiEndpoints.experienceGroupId}/$userId/$addressId",
          data);
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CustomerResponseModel>> deleteAddress(
      {int? addressId, int? userId}) async {
    try {
      var jsonResponse = await _apiManager.delete(
          "${apiEndpoints.baseUrl}${apiEndpoints.deleteAddress}/${apiEndpoints.experienceGroupId}/$userId/$addressId");
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CustomerResponseModel>> deleteUPIAddress({
    int? accountId,
    int? userId,
  }) async {
    try {
      var jsonResponse = await _apiManager.delete(
          "${apiEndpoints.baseUrl}${apiEndpoints.updateCustomerUPI}/${apiEndpoints.experienceGroupId}/$userId/$accountId");
      var json = CustomerResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
