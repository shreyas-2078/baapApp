import 'package:baapapp/repositories/paymet_services_repo/paymet_services_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_vpa_state.dart';

class CheckVPACubit extends Cubit<CheckVPAState> {
  final PaymentRepo _paymentRepo = PaymentRepo();
  CheckVPACubit() : super(CheckVPAInitial());

  void checkVpa({String? vpaId}) async {
    var payload = {'vpaName': vpaId};
    emit(CheckVPALoading());
    final response = await _paymentRepo.checkVPA(payload);
    response.fold((error) {
      emit(CheckVPAError(error: error.message));
    }, (data) {
      if (data.data?.code == 'A') {
        emit(CheckVPASuccess());
      } else {
        emit(CheckVPAError(error: 'UPI Id चुकीचा आहे'));
      }
    });
  }

  void changeState() {
    emit(CheckVPAInitial());
  }
}
