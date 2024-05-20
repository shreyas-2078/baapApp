import 'dart:developer';
import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:baapapp/repositories/profile_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo = ProfileRepo();
  ProfileCubit() : super(ProfileInitial());

  void getCustomerData() async {
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.getCustomerData(userId);
      response.fold((error) {
        emit(ProfileError(error.message));
      }, (data) {
        emit(ProfileLoaded(customerData: data.data));
        LocalStorageUtils.saveLocationAndPin(
          data.data?.location ?? '',
          data.data?.pinCode ?? "422611",
        );
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateUserInfo(
    BuildContext context, {
    String? name,
    String? location,
    String? phoneNumber,
    String? imageUrl,
    String? profileImage,
    String? profileCircle,
  }) async {
    var payload = {
      "name": name,
      "location": location,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "profileImage": profileImage,
      "profileCircle": profileCircle,
    };
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateCustomerData(userId, payload);
      response.fold((error) {
        getCustomerData();
        emit(ProfileError(error.message));
      }, (data) {
        emit(ProfileUploadSuccess());
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateDistance(
    BuildContext context, {
    double? destination,
  }) async {
    var payload = {
      "destination": destination,
    };
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateCustomerData(userId, payload);
      response.fold((error) {
        getCustomerData();
        emit(ProfileError(error.message));
      }, (data) {
        // emit(ProfileUploadSuccess());
        getCustomerData();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateUPI(BuildContext context, String? upi) async {
    var payload = {
      "accountDetails": [
        {
          "upi": {"upi": upi}
        }
      ]
    };
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateCustomerUpi(userId, payload);
      response.fold((error) {
        emit(UpiAddingError(error.message));
        getCustomerData();
      }, (data) {
        getCustomerData();
        // emit(ProfileUploadSuccess());
        context.pop();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void addUserAddress(
    BuildContext context, {
    String? tag,
    String? street,
    String? locality,
    String? city,
    String? state,
    String? zipCode,
    bool? defaultAddress,
  }) async {
    var payload = {
      "addresses": [
        {
          "tag": tag ?? "घर",
          "street": street,
          "locality": locality,
          "city": city,
          "state": state,
          "zip": zipCode,
          "default": defaultAddress
        }
      ]
    };
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateCustomerData(userId, payload);
      response.fold((error) {
        emit(ProfileError(error.message));
        getCustomerData();
      }, (data) {
        emit(ProfileUploadSuccess());
        // getCustomerData();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateUserAddressById(
    BuildContext context, {
    String? tag = "Home",
    int? addressId,
    String? street,
    String? locality,
    String? city,
    String? state,
    String? zipCode,
    bool? defaultAddress,
  }) async {
    var payload = {
      "addressId": addressId,
      "address": {
        "tag": tag,
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zipCode,
        "default": defaultAddress
      }
    };
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateAddress(
        addressId: addressId,
        userId: userId,
        data: payload,
      );
      response.fold((error) {
        emit(ProfileError(error.message));
        getCustomerData();
      }, (data) {
        emit(ProfileUploadSuccess());
        // getCustomerData();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void deleteUserAddressById(BuildContext context,
      {int? custId, int? addressId}) async {
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.deleteAddress(
          addressId: addressId, userId: userId);
      response.fold((error) {
        emit(ProfileError(error.message));
        getCustomerData();
      }, (data) {
        emit(ProfileUploadSuccess());
        getCustomerData();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void deleteUPIByUserId(
    BuildContext context, {
    int? accountId,
  }) async {
    try {
      emit(ProfileLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.deleteUPIAddress(
        accountId: accountId,
        userId: userId,
      );
      response.fold((error) {
        emit(ProfileError(error.message));
        getCustomerData();
      }, (data) {
        emit(ProfileUploadSuccess());
        getCustomerData();
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void signOut(BuildContext context) async {
    emit(LogoutState());
    await LocalStorageUtils.instance.clear();
    log(await LocalStorageUtils.fetchToken() ?? "");
  }
}
