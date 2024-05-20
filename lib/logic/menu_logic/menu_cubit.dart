import 'package:baapapp/models/local_bussiness_response_model/local_bussiness_response_model.dart';
import 'package:baapapp/models/service_request_response_model/service_request_response_model.dart';
import 'package:baapapp/repositories/menu_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'menu_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  ServiceRequestCubit() : super(ServiceRequestInitial());

  final MenuRepo _menuRepo = MenuRepo();

  void getServiceRequests() async {
    var userId = LocalStorageUtils.tokenResponseModel.userId;
    try {
      emit(ServiceRequestLoading());
      var data = await _menuRepo.getServiceRequest(userId);
      data.fold((error) {
        emit(ServiceRequestError());
      }, (data) {
        emit(ServiceRequestLoaded(menuModel: data.data));
      });
    } catch (e) {
      emit(ServiceRequestError(error: e.toString()));
    }
  }

  void archiveServiceRequests(int? serviceRequestId) async {
    var payload = {
      "status": "archive",
    };

    try {
      emit(ServiceRequestLoading());
      var data = await _menuRepo.putServiceRequest(serviceRequestId, payload);
      data.fold((error) {
        emit(ServiceRequestError());
      }, (data) {
        emit(ServiceRequestUpdateSuccess());
      });
    } catch (e) {
      emit(ServiceRequestError(error: e.toString()));
    }
  }


  void cancelServiceRequests(int? serviceRequestId) async {
    var payload = {
      "status": "close",
    };

    try {
      emit(ServiceRequestLoading());
      var data = await _menuRepo.putServiceRequest(serviceRequestId, payload);
      data.fold((error) {
        emit(ServiceRequestError());
      }, (data) {
        emit(ServiceRequestUpdateSuccess());
      });
    } catch (e) {
      emit(ServiceRequestError(error: e.toString()));
    }
  }
}
