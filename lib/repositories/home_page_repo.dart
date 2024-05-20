import 'package:baapapp/main.dart';
import 'package:baapapp/models/bussiness_detail/bussiness_detail_response_model.dart';
import 'package:baapapp/models/catogory_response_model/product_category_response_model.dart';
import 'package:baapapp/models/local_bussiness_response_model/local_bussiness_response_model.dart';
import 'package:baapapp/models/sub_category_list_response_model/sub_category_list_response_model.dart';
import 'package:baapapp/utils/api/api_exceptions.dart';
import 'package:baapapp/utils/api/api_manager.dart';
import 'package:baapapp/utils/api/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/catogory_response_model/category_response_model.dart';
import '../models/sub_category_response_model/sub_category_response_model.dart';

class HomePageRepo {
  final ApiManager _apiManager = ApiManager();

  Future<Either<Failure, CategoryResponseModel>> getCategory() async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getCategoryByGroupId}${apiEndpoints.experienceGroupId}?isCommerceEnable=true");
      var json = CategoryResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ProductCategoryResponseModel>>
      getCategoryByGroupId() async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getCategoryByGroupId}${apiEndpoints.experienceGroupId}?isBusinessEnable=true");
      var json = ProductCategoryResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SubCategoryResponseModel>> getSubCategory({
    int? categoryId,
    dynamic lat,
    dynamic lon,
    dynamic distance,
  }) async {
    try {
      if (categoryId != null) {
        var jsonResponse = await _apiManager.get(
            "${apiEndpoints.baseUrl}${apiEndpoints.getSubCategoryByCategoryId}${apiEndpoints.experienceGroupId}?categoryId=$categoryId&lat=$lat&lon=$lon&distance=$distance");
        var json = SubCategoryResponseModel.fromJson(jsonResponse);
        return right(json);
      } else {
        var jsonResponse = await _apiManager.get(
            "${apiEndpoints.baseUrl}${apiEndpoints.getSubCategoryByCategoryId}${apiEndpoints.experienceGroupId}?lat=$lat&lon=$lon&distance=$distance");
        var json = SubCategoryResponseModel.fromJson(jsonResponse);
        return right(json);
      }
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SubCategoryResponseModel>> searchSubCategory({
    String? value,
    int? userId,
    dynamic lat,
    dynamic lon,
    dynamic distance,
  }) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.searchSubCategory}${apiEndpoints.experienceGroupId}?search=$value&lat=$lat&lon=$lon&distance=$distance&userId=$userId");
      var json = SubCategoryResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, SubCategoryListResponseModel>> getSubCategoryList(
      {int? subCategoryId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getSubCategoryListBySubCategoryId}${apiEndpoints.experienceGroupId}?parentServiceId=$subCategoryId");
      var json = SubCategoryListResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, BussinessDetailResponseModel>> getBussiessDetail(
      {int? subGroupId}) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.baseUrl}${apiEndpoints.getBussinessByCategoryId}${apiEndpoints.experienceGroupId}?subGroupId=$subGroupId");
      var json = BussinessDetailResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, LocalBussinessResponseModel>> getLocalBussiess(
      {int? categoryId, dynamic lat, dynamic lon, dynamic distance}) async {
    try {
      if (categoryId == null) {
        var jsonResponse = await _apiManager.get(
            "${apiEndpoints.baseUrl}${apiEndpoints.getBussinessByCategoryId}${apiEndpoints.experienceGroupId}?lat=$lat&lon=$lon&distance=$distance");
        var json = LocalBussinessResponseModel.fromJson(jsonResponse);
        return right(json);
      } else {
        var jsonResponse = await _apiManager.get(
            "${apiEndpoints.baseUrl}${apiEndpoints.getBussinessByCategoryId}${apiEndpoints.experienceGroupId}?categoryId=$categoryId&lat=$lat&lon=$lon&distance=$distance");
        var json = LocalBussinessResponseModel.fromJson(jsonResponse);
        return right(json);
      }
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, LocalBussinessResponseModel>> searchLocalBussiness({
    String? value,
    int? userId,
    dynamic lat,
    dynamic lon,
    dynamic distance,
  }) async {
    try {
      var jsonResponse = await _apiManager.get(
          "${apiEndpoints.gatewayBaseUrl}${apiEndpoints.searchLocalBussiness}${apiEndpoints.experienceGroupId}?search=$value&lat=$lat&lon=$lon&distance=$distance&userId=$userId");
      var json = LocalBussinessResponseModel.fromJson(jsonResponse);
      return right(json);
    } on AppException catch (e) {
      return left(ApiFailure(message: e.message));
    } catch (e) {
      return left(ApiFailure(message: e.toString()));
    }
  }
}
