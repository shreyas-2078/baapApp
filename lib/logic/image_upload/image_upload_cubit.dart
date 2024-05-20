// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../constants/app_strings.dart';
import '../../repositories/image_upload_repo/image_upload_repo.dart';
import '../../utils/api/api_manager.dart';
import '../../utils/app_utils/snackbar/snackbar.dart';

part 'image_upload_state.dart';

class ImageUploadCubit extends Cubit<ImageUploadState> {
  final ImageUplaodRepo _imageRepo = ImageUplaodRepo();
  ImageUploadCubit() : super(ImageUploadInitial());

  Future<void> captureAndUploadImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      try {
        // final filePath = File(pickedFile.path);
        final bytes = pickedFile.readAsBytes();
        final mimeType = lookupMimeType(pickedFile.path);
        String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
        final String fileName = 'profile/${timestamp()}.jpg';
        // context.pop();
        getImageUrl(
          imageType: mimeType,
          imageName: fileName,
          bytes: await bytes,
        );
      } catch (e) {
        SnackBarWidget.showSnackbar(context, e.toString());
      }
    } else {
      Navigator.pop(context);
      SnackBarWidget.showSnackbar(context, AppStrings.notselectFile);
    }
  }

  void changeState() {
    emit(ImageUploadInitial());
  }

  void clearData() {
    emit(ImageUploadSuccess("", ""));
  }

  Future<void> pickImage(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      try {
        final image = result.files.single.name;
        final bytes = result.files.single.bytes;
        final imageType = lookupMimeType(result.files.single.name);
        if (image != '' && imageType != null) {
          getImageUrl(imageName: image, imageType: imageType, bytes: bytes);
          // Navigator.pop(context);
        }
      } catch (e) {
        SnackBarWidget.showSnackbar(context, e.toString());
      }
    } else {
      Navigator.pop(context);
      SnackBarWidget.showSnackbar(context, AppStrings.notselectFile);
    }
  }

  void getImageUrl({
    String? imageName,
    String? imageType,
    Uint8List? bytes,
  }) async {
    emit(ImageUploadLoading());
    var response = await _imageRepo.uploadImage(imageName, imageType);
    response.fold((error) {
      emit(ImageUploadError(error.message));
    }, (data) {
      uploadImage(data, imageName, imageType, bytes);
    });
  }

  void uploadImage(data, fileName, fileType, fileDataBinary) async {
    var url = Uri.parse(data.url?.split("?").first ?? "");
    var response = await ApiManager().dioPutFile(
        uploadFile: XFile.fromData(fileDataBinary!),
        url: data.url!,
        contentType: fileType,
        fileLength: fileDataBinary!.length);
    log(response ?? "");
    emit(ImageUploadSuccess(url.toString(), fileName));
  }
}
