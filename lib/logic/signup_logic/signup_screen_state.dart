part of 'signup_screen_cubit.dart';
abstract class SignUpState {}

class SignUpInitial extends SignUpState{}

class SendOtpError extends SignUpState {
  final String? errorMesage;

  SendOtpError(this.errorMesage);
}

class SendOtpLoading extends SignUpState{}

class SendOtpSuccess extends SignUpState{}

class VerifyOtpInitial extends SignUpState {}

class VerifyOtpSuccess extends SignUpState {}

class VerifyOtpLoading extends SignUpState {}

class VerifyOtpError extends SignUpState {
  final String? errorMesage;

  VerifyOtpError(this.errorMesage);
}

class VerifyOtpUserExists extends SignUpState {}

class VerifyOtpUserNotExists extends SignUpState {
  final String? phoneNumber;
  VerifyOtpUserNotExists({this.phoneNumber});
}

class UserLoggedIn extends SignUpState {
  UserLoggedIn();
}

class UserLoggedOut extends SignUpState {}

class UserSaveError extends SignUpState {
  final String error;
  UserSaveError(this.error);
}

class CustomerInfoError extends SignUpState {
  final String error;
  CustomerInfoError(this.error);
}

class CustomerInfoLoading extends SignUpState {}

class CustomerInfoSuccess extends SignUpState {}
