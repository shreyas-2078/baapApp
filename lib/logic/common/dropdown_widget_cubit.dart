import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownButtonCubit extends Cubit<String?> {
  DropdownButtonCubit() : super('घर');

  void updateSelectedOption(String? option) => emit(option);
  void updateSelected(String? option) => emit(option);
}
