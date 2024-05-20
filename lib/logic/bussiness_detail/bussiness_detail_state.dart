part of 'bussiness_detail_cubit.dart';

abstract class BussinessDetailState {
  List<BussinessDetail>? bussinessDetail;
  BussinessDetailState({this.bussinessDetail});
}

class BussinessDetailInitial extends BussinessDetailState {
  BussinessDetailInitial({super.bussinessDetail});
}

class BussinessDetailLoading extends BussinessDetailState {
  BussinessDetailLoading({super.bussinessDetail});
}

class BussinessDetailLoaded extends BussinessDetailState {
  BussinessDetailLoaded({super.bussinessDetail});
}

class BussinessDetailError extends BussinessDetailState {
  final String? errorMessage;
  BussinessDetailError({this.errorMessage, super.bussinessDetail});
}
