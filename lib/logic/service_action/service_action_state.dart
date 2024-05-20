part of 'service_action_cubit.dart';

abstract class ServiceActionState {
  ServiceActionState();
}

class ServiceActionInitital extends ServiceActionState {
  ServiceActionInitital();
}

class ServiceActionLoading extends ServiceActionState {
  ServiceActionLoading();
}

class ServiceActionError extends ServiceActionState {
  final String? error;
  ServiceActionError({this.error});
}

class ServiceActionLoaded extends ServiceActionState {
  ServiceActionLoaded();
}

class ServiceActionStateCheck extends ServiceActionState {
  ServiceActionStateCheck();
}
