import 'package:baapapp/main.dart';
import 'package:dartz/dartz.dart';
import '../../models/refresh_token_response_model/refresh_token_response_model.dart';
import '../../models/save_user_response_model/save_user_response_model.dart';
import '../../models/send_otp_response_model/send_otp_response_model.dart';
import '../../models/verify_otp_response_model.dart/verify_otp_response_model.dart';
import '../../utils/api/api_exceptions.dart';
import '../../utils/api/api_manager.dart';
import '../../utils/api/failure.dart';

class AuthRepo {
  final _apiManager = ApiManager();

  Future<Either<Failure, SendOtpResponseModel>> sendOtp(
      {required Map data}) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.authGateway}${apiEndpoints.sendOtp}",
          data);
      var response = SendOtpResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, VerificationResponseModel>> verifyOtp(
      {required Map data}) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.authBaseUrl}${apiEndpoints.auth}${apiEndpoints.verifyOtp}",
          data);
      var response = VerificationResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, SaveUserResponseModel>> saveCustomer(
      {required Map data}) async {
    try {
      var jsonResponse = await _apiManager.post(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.saveCustomer}", data);
      var response = SaveUserResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, RefreshTokenResponseModel>> refreshToken(
      {required Map data}) async {
    try {
      var jsonResponse =
          await _apiManager.post(apiEndpoints.refreshToken, data);
      var response = RefreshTokenResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
