import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double?> {
  SliderCubit() : super(40);

  void updateSlider(double? option) {
    // var kilometer = (option ?? 0) * 1000;
    emit(option);
  }
}
