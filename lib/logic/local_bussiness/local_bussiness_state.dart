part of 'local_bussiness_cubit.dart';

abstract class LocalBussinessState {
  List<LocalBussinessModel>? localBussiness;
  LocalBussinessState({this.localBussiness});
}

class LocalBussinessInitial extends LocalBussinessState {
  LocalBussinessInitial({super.localBussiness});
}

class LocalBussinessLoading extends LocalBussinessState {
  LocalBussinessLoading({super.localBussiness});
}

class LocalBussinessLoaded extends LocalBussinessState {
  LocalBussinessLoaded({super.localBussiness});
}

class LocalBussinessError extends LocalBussinessState {
  final String? errorMessage;
  LocalBussinessError({this.errorMessage, super.localBussiness});
}
