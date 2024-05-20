part of 'image_upload_cubit.dart';

@immutable
abstract class ImageUploadState {}

class ImageUploadInitial extends ImageUploadState {}

class ImageUploadError extends ImageUploadState {
  final String error;
  ImageUploadError(this.error);
}

class ImageUploadLoading extends ImageUploadState {}

class ImageUploadSuccess extends ImageUploadState {
  final String? url;
  final String? fileName;
  ImageUploadSuccess(this.url, this.fileName);
}
