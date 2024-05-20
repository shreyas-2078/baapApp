part of 'collect_vpa_cubit.dart';

abstract class CollectVPAState {
  CollectVpaModel? collectVpaModel;
  CollectVPAState({this.collectVpaModel});
}

class CollectVPAInitial extends CollectVPAState {
  CollectVPAInitial({super.collectVpaModel});
}

class CollectVPALoading extends CollectVPAState {
  CollectVPALoading({super.collectVpaModel});
}

class CollectVPAError extends CollectVPAState {
  final String? error;
  CollectVPAError({this.error, super.collectVpaModel});
}

class CollectVPASuccess extends CollectVPAState {
  CollectVPASuccess({super.collectVpaModel});
}
