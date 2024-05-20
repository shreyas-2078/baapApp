part of 'menu_cubit.dart';

abstract class ServiceRequestState {
   List<MenuModel>?  menuModel;
   List<Data>?  data;
  ServiceRequestState({this.menuModel});
}

class ServiceRequestInitial extends ServiceRequestState {
  ServiceRequestInitial({super.menuModel});
}

class ServiceRequestLoading extends ServiceRequestState {
  ServiceRequestLoading({super.menuModel});
}

class ServiceRequestLoaded extends ServiceRequestState {
  ServiceRequestLoaded({super.menuModel});
}

// class ServiceRequestUpdatedDataLoaded extends ServiceRequestState {
//   ServiceRequestUpdatedDataLoaded({super.menuModel});
// }
class ServiceRequestUpdatedDataLoding extends ServiceRequestState {
  ServiceRequestUpdatedDataLoding({super.menuModel});
}
class ServiceRequestUpdateSuccess extends ServiceRequestState {
  ServiceRequestUpdateSuccess();
}

class ServiceRequestError extends ServiceRequestState {
  final String? error;
  ServiceRequestError({this.error, super.menuModel});
}
