part of 'profile_cubit.dart';

abstract class ProfileState {
  CustomerModel? customerData;
  ProfileState({this.customerData});
}

class ProfileInitial extends ProfileState {
  ProfileInitial({super.customerData});
}

class ProfileGenderUpdated extends ProfileState {
  final bool isMale;

  ProfileGenderUpdated(this.isMale);
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({super.customerData});
}

class ProfileLoading extends ProfileState {
  ProfileLoading({super.customerData});
}
class ProfileUploadSuccess extends ProfileState {
  ProfileUploadSuccess({super.customerData});
}

class ProfileError extends ProfileState {
  final String? errorMesage;
  ProfileError(this.errorMesage, {super.customerData});
}
class UpiAddingError extends ProfileState {
  final String? error;
  UpiAddingError(this.error, {super.customerData});
}

class LogoutState extends ProfileState {
  LogoutState({super.customerData});
}

class ImageSelected extends ProfileState {
  final String imagePath;
  ImageSelected(this.imagePath);
}
