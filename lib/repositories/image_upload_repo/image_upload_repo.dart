import 'package:baapapp/main.dart';
import 'package:dartz/dartz.dart';

import '../../models/image_upload_response_model/image_upload_response_model.dart';
import '../../utils/api/api_exceptions.dart';
import '../../utils/api/api_manager.dart';
import '../../utils/api/failure.dart';

class ImageUplaodRepo {

  final _apiManager = ApiManager();
  Future<Either<Failure, ImageUploadResponseModel>> uploadImage(
      String? imageName, String? imageType) async {
    try {
      var jsonResponse = await _apiManager.get(
        "${apiEndpoints.imageUploadBaseUrl}${apiEndpoints.imageUpload}?fileName=$imageName&fileType=$imageType&public=true&action=write",
      );
      var response = ImageUploadResponseModel.fromJson(jsonResponse);
      return right(response);
    } on AppException catch (error) {
      return left(ApiFailure(message: error.message));
    } catch (error) {
      return left(ApiFailure(message: error.toString()));
    }
  }
}
