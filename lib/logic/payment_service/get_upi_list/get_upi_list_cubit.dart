import 'package:baapapp/models/upi_response_model/upi_response_model.dart';
import 'package:baapapp/repositories/paymet_services_repo/paymet_services_repo.dart';
import 'package:baapapp/repositories/profile_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'get_upi_list_state.dart';

class GetUPIListCubit extends Cubit<GetUPIListState> {
  final PaymentRepo _paymentRepo = PaymentRepo();
  final ProfileRepo _profileRepo = ProfileRepo();
  GetUPIListCubit() : super(GetUPIListInitial());

  void getUpiList({int? groupId}) async {
    // int i = 0;
    try {
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      emit(GetUPIListLoading());
      final response = await _paymentRepo.getUPILIst(userId);
      response.fold((error) {
        // if (error.message == AppStrings.internalServerError &&
        //     (i == 0 || i == 1)) {
        //   getUpiList();
        //   i++;
        // }
        emit(GetUPIListError(error: error.message));
      }, (data) {
        emit(GetUPIListLoaded(getUPIListModel: data));
      });
    } catch (e) {
      emit(GetUPIListError(error: e.toString()));
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
      emit(GetUPIListLoading());
      var userId = LocalStorageUtils.tokenResponseModel.userId;
      var response = await _profileRepo.updateCustomerUpi(userId, payload);
      response.fold((error) {
        getUpiList();
        context.pop();
        emit(GetUPIListError(error: error.message));
      }, (data) {
        getUpiList();
        context.pop();
      });
    } catch (e) {
      emit(GetUPIListError(error: e.toString()));
    }
  }
}
