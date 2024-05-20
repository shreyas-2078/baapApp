import 'dart:developer';

import 'package:baapapp/main.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth/auth_repo.dart';
import '../../utils/app_utils/snackbar/snackbar.dart';

part 'signup_screen_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo _authRepo = AuthRepo();
  SignUpCubit() : super(SignUpInitial());

  void sendOtp(
    String number,
    BuildContext context,
  ) async {
    var data = {
      "phoneNumber": number,
      "groupId": apiEndpoints.experienceGroupId,
    };
    try {
      emit(SendOtpLoading());
      var response = await _authRepo.sendOtp(data: data);
      response.fold((error) {
        emit(SendOtpError(error.message));
      }, (data) {
        emit(SendOtpSuccess());
        SnackBarWidget.showSnackbar(context, 'OTP sent successfully!');
      });
    } catch (e) {
      emit(SendOtpError(e.toString()));
    }
  }

  void verifyOtp({required String phoneNumber, int? otp}) async {
    var data = {"phoneNumber": phoneNumber, "otp": otp};
    emit(VerifyOtpLoading());
    var response = await _authRepo.verifyOtp(data: data);
    response.fold((error) {
      emit(VerifyOtpError(error.message));
    }, (data) {
      emit(VerifyOtpSuccess());
      if (data.data?.userExists != true) {
        emit(VerifyOtpUserNotExists(phoneNumber: phoneNumber));
      } else {
        updateToken(data.token, userNotExists: false);
      }
    });
  }

  void saveUserProfile(
    String? phoneNumber,
    String? name,
    String? pin,
    String? location,
  ) async {
    var data = {
      "groupId": apiEndpoints.experienceGroupId,
      "password": "12345",
      "phoneNumber": phoneNumber,
      "name": name,
      "pinCode": pin,
      "location": location,
      "roleId": apiEndpoints.roleId,
    };
    emit(CustomerInfoLoading());
    var response = await _authRepo.saveCustomer(
      data: data,
    );
    response.fold((error) {
      emit(CustomerInfoError(error.message));
    }, (data) async {
      updateToken(data.user?.token, userNotExists: true);
    });
  }

  void updateToken(String? token, {bool? userNotExists}) async {
    var groupId = apiEndpoints.experienceGroupId;
    var data = {"token": token, "groupId": groupId};
    if (userNotExists ?? false) {
      emit(CustomerInfoLoading());
    } else {
      emit(VerifyOtpLoading());
    }
    var response = await _authRepo.refreshToken(
      data: data,
    );
    response.fold((error) {
      if (userNotExists ?? false) {
        emit(CustomerInfoError(error.message));
      } else {
        emit(VerifyOtpError(error.message));
      }
    }, (data) async {
      if (userNotExists ?? false) {
        emit(CustomerInfoSuccess());
      }
      if ((data.data?.customerExists ?? false) &&
          (data.data?.userExists ?? false)) {
        emit(UserLoggedIn());
        LocalStorageUtils.saveUserDetails(data.token ?? "");
      } else {
        emit(VerifyOtpUserNotExists());
      }
    });
  }

  void signOut(BuildContext context) async {
    emit(UserLoggedOut());
    await LocalStorageUtils.instance.clear();
    log(await LocalStorageUtils.fetchToken() ?? "");
  }
}
