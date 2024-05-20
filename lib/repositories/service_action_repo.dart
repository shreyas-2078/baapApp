import 'package:baapapp/main.dart';
import 'package:baapapp/utils/api/api_exceptions.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:baapapp/utils/api/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/service_action_response_model/serice_userid_action_response_model.dart';
import '../models/service_action_response_model/service_action_response_model.dart';

class ServiceActionRepo {
  final ApiManager _apiManager = ApiManager();

  Future<Either<Failure, ServiceActionResponseModel>> createService(payload) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.serviceAction}",payload, isTokenMandatory: true,);
      var json = ServiceActionResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
  
  Future<Either<Failure, ServiceActionByUserResponseModel>> createServiceUsingUserId(payload) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.serviceActionByCustomer}",payload);
      var json = ServiceActionByUserResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
