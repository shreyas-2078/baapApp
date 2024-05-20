part of 'menu_detail_cubit.dart';

abstract class ServiceRequestDetailState {
  List<ServiceDetailModel>? serviceRequestDetail;
  ServiceRequestDetailState({this.serviceRequestDetail});
}

class ServiceRequestDetailInitial extends ServiceRequestDetailState {
  ServiceRequestDetailInitial({super.serviceRequestDetail});
}

class ServiceRequestDetailLoading extends ServiceRequestDetailState {
  ServiceRequestDetailLoading({super.serviceRequestDetail});
}

class ServiceRequestDetailLoaded extends ServiceRequestDetailState {
  ServiceRequestDetailLoaded({super.serviceRequestDetail});
}

class ServiceResponseSuccess extends ServiceRequestDetailState {
  ServiceResponseSuccess({super.serviceRequestDetail});
}



class ServiceRequestDetailError extends ServiceRequestDetailState {
  final String? error;
  ServiceRequestDetailError({this.error, super.serviceRequestDetail});
}
