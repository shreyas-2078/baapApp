import 'package:baapapp/models/profile_response_model/customer_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownAddressCubit extends Cubit<AddressElement?> {
  DropdownAddressCubit() : super(AddressElement());

  void updateSelected(AddressElement? option) => emit(option);
}
