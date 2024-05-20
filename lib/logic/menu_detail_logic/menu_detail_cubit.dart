import 'package:baapapp/main.dart';
import 'package:baapapp/models/service_request_detail_model/service_request_detail_model.dart';
import 'package:baapapp/repositories/menu_repo.dart';
import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_detail_state.dart';

class ServiceRequestDetailCubit extends Cubit<ServiceRequestDetailState> {
  ServiceRequestDetailCubit() : super(ServiceRequestDetailInitial());

  final MenuRepo _menuRepo = MenuRepo();

  void getDetailServiceRequests({int? servicerequestId}) async {
    // var userId = LocalStorageUtils.tokenResponseModel.userId;
    try {
      emit(ServiceRequestDetailLoading());
      var data = await _menuRepo.getDetailServiceRequests(servicerequestId);
      data.fold((error) {
        emit(ServiceRequestDetailError());
      }, (data) {
        emit(
            ServiceRequestDetailLoaded(serviceRequestDetail: data.data?.items));
      });
    } catch (e) {
      emit(ServiceRequestDetailError(error: e.toString()));
    }
  }

  void postServiceRequestsResponse(
      {int? servicerequestId, int? handleById, String? response}) async {
    var groupId = apiEndpoints.experienceGroupId;
    var userId = LocalStorageUtils.tokenResponseModel.userId;
    var payload = {
      // "servicerequestId": servicerequestId,
      // "handledById": handleById,
      // "groupId": groupId,
      // "comments": response,

      "servicerequestId": servicerequestId,
      "userId": userId,
      "groupId": groupId,
      "comments": response,
    };
    // var userId = LocalStorageUtils.tokenResponseModel.userId;
    try {
      emit(ServiceRequestDetailLoading());
      var data = await _menuRepo.postServiceRequestsResponse(payload);
      data.fold((error) {
        emit(ServiceRequestDetailError());
      }, (data) {
        emit(ServiceResponseSuccess());
      });
    } catch (e) {
      emit(ServiceRequestDetailError(error: e.toString()));
    }
  }
}
