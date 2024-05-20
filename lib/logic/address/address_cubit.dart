import 'package:baapapp/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/default_address_response_model/default_address_response_model.dart';
import '../../repositories/cart_repo.dart';
import '../../utils/preferences/local_preferences.dart';
part 'address_state.dart';

class DefaultAddressCubit extends Cubit<DefaultAddressState> {
  final CartRepo _cartRepo = CartRepo();
  DefaultAddressCubit() : super(DefaultAddressInitial());

  void getDefaultAddress() async {
    emit(DefaultAddressLoading());
    var response = await _cartRepo.getDefaultByUserId(
        groupId: apiEndpoints.experienceGroupId,
        userId: LocalStorageUtils.tokenResponseModel.userId);
    response.fold((error) {
      emit(DefaultAddressError(error: error.message));
    }, (data) {
      emit(DefaultAddressLoaded(addressModel: data.data));
    });
  }
}
