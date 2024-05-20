part of 'check_vpa_cubit.dart';

abstract class CheckVPAState {}

class CheckVPAInitial extends CheckVPAState {}

class CheckVPALoading extends CheckVPAState {}

class CheckVPAError extends CheckVPAState {
  final String? error;
  CheckVPAError({this.error});
}

class CheckVPASuccess extends CheckVPAState {}
