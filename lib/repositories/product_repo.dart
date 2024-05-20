import 'package:baapapp/main.dart';
import 'package:baapapp/models/group_response_model/group_response_model.dart';
import 'package:baapapp/models/product_response_model/product_response_model.dart';
import 'package:baapapp/utils/api/api_exceptions.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:baapapp/utils/api/failure.dart';
import 'package:dartz/dartz.dart';

class ProductRepo {
  final ApiManager _apiManager = ApiManager();

  Future<Either<Failure, ProductListResponseModel>>
      getProductDataBySubCategoryId({int? subcategoryId, int? groupId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getProduct}$groupId?subcategoryId=$subcategoryId");
      var json = ProductListResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductListResponseModel>> getProductDataByCategoryId(
      {int? categoryId, int? groupId}) async {
    try {
      if (categoryId == null) {
        var jsonResponse = await _apiManager
            .get("${apiEndpoints.baseUrl}${apiEndpoints.getProduct}$groupId");
        var json = ProductListResponseModel.fromJson(jsonResponse);
        return right(json);
      } else {
        var jsonResponse = await _apiManager.get(
            "${apiEndpoints.baseUrl}${apiEndpoints.getProduct}$groupId?categoryId=$categoryId");
        var json = ProductListResponseModel.fromJson(jsonResponse);
        return right(json);
      }
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductListResponseModel>> getProductDataBySearch(
      {String? value, int? groupId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getProduct}$groupId?search=$value");
      var json = ProductListResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, GroupResponseModel>> getGroupDetail(
      {int? groupId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.authBaseUrl}${apiEndpoints.getGroup}$groupId");
      var json = GroupResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
