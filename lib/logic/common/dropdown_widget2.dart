import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownButtonCubit2 extends Cubit<String?> {
  DropdownButtonCubit2() : super('प्रीमियम');

  void updateSelectedOption2(String? option) => emit(option);
  void updateSelected2(String? option) => emit(option);
}
