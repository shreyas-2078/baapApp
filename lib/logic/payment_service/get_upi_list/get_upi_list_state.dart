part of 'get_upi_list_cubit.dart';

abstract class GetUPIListState {
  UpiResponseModel? getUPIListModel;
  GetUPIListState({this.getUPIListModel});
}

class GetUPIListInitial extends GetUPIListState {
  GetUPIListInitial({super.getUPIListModel});
}

class GetUPIListLoading extends GetUPIListState {
  GetUPIListLoading({super.getUPIListModel});
}

class GetUPIListError extends GetUPIListState {
  final String? error;
  GetUPIListError({this.error});
}

class GetUPIListLoaded extends GetUPIListState {
  GetUPIListLoaded({super.getUPIListModel});
}

class GetUPIListFailed extends GetUPIListState {
  GetUPIListFailed({super.getUPIListModel});
}
