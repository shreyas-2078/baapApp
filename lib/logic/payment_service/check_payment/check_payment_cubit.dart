import 'package:baapapp/models/payment_services/check_payment_status_response_model.dart';
import 'package:baapapp/repositories/paymet_services_repo/paymet_services_repo.dart';
import 'package:bloc/bloc.dart';

part 'check_payment_state.dart';

class CheckPaymentStatusCubit extends Cubit<CheckPaymentStatusState> {
  final PaymentRepo _paymentRepo = PaymentRepo();
  CheckPaymentStatusCubit() : super(CheckPaymentStatusInitial());

  void checkPaymentStatus({
    String? tranxitionId,
    int? groupId,
  }) async {
    var payload = {
      "id": tranxitionId,
      "groupId": groupId.toString(),
    };
    emit(CheckPaymentStatusLoading());
    final response = await _paymentRepo.checkPaymentStatus(payload);
    response.fold((error) {
      emit(CheckPaymentStatusError(error: error.message));
    }, (data) {
      if (data.data?.status == 'SUCCESS') {
        emit(CheckPaymentStatusSuccess(checkPaymentStatusModel: data.data));
      } else {
        emit(CheckPaymentStatusFailed(checkPaymentStatusModel: data.data));
      }
    });
  }
}
