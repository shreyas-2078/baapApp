import 'package:baapapp/models/payment_services/collect_vap_response_model.dart';
import 'package:baapapp/repositories/paymet_services_repo/paymet_services_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collect_vpa_state.dart';

class CollectVPACubit extends Cubit<CollectVPAState> {
  final PaymentRepo _paymentRepo = PaymentRepo();
  CollectVPACubit() : super(CollectVPAInitial());

  void collectVpa({
    double? amount,
    int? groupId,
    String? message,
    String? vpaId,
  }) async {
    var payload = {
      "groupId": "$groupId",
      "amount": amount ?? 0,
      "description": message,
      "payeeVpa": vpaId
    };
    emit(CollectVPALoading());
    final response = await _paymentRepo.collectVPA(payload);
    response.fold((error) {
      emit(CollectVPAError(error: error.message));
    }, (data) {
      emit(CollectVPASuccess(collectVpaModel: data.data));
    });
  }
}
