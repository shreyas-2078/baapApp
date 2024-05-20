part of 'check_payment_cubit.dart';

abstract class CheckPaymentStatusState {
  CheckPaymentStatusModel? checkPaymentStatusModel;
  CheckPaymentStatusState({this.checkPaymentStatusModel});
}

class CheckPaymentStatusInitial extends CheckPaymentStatusState {
  CheckPaymentStatusInitial({super.checkPaymentStatusModel});
}

class CheckPaymentStatusLoading extends CheckPaymentStatusState {
  CheckPaymentStatusLoading({super.checkPaymentStatusModel});
}

class CheckPaymentStatusError extends CheckPaymentStatusState {
  final String? error;
  CheckPaymentStatusError({this.error});
}

class CheckPaymentStatusSuccess extends CheckPaymentStatusState {
  CheckPaymentStatusSuccess({super.checkPaymentStatusModel});
}

class CheckPaymentStatusFailed extends CheckPaymentStatusState {
  CheckPaymentStatusFailed({super.checkPaymentStatusModel});
}
