import 'package:bloc/bloc.dart';
part 'radio_button_state.dart';

class RadioButtonCubit extends Cubit<RadioButtonState> {
  RadioButtonCubit() : super(RadioButtonState(''));

  void selectUpiId(String upiId) {
    emit(RadioButtonState(upiId));
  }
}
