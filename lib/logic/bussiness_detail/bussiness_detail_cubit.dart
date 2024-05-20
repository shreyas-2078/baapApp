import 'package:baapapp/models/bussiness_detail/bussiness_detail_response_model.dart';
import 'package:bloc/bloc.dart';
import '../../repositories/home_page_repo.dart';

part 'bussiness_detail_state.dart';

class BussinessDetailCubit extends Cubit<BussinessDetailState> {
  final HomePageRepo _homePageRepo = HomePageRepo();
  BussinessDetailCubit() : super(BussinessDetailInitial());

  void getBussiesDetails(int? subGroupId) async {
    try {
      emit(BussinessDetailLoading());
      var data = await _homePageRepo.getBussiessDetail(subGroupId: subGroupId);
      data.fold((error) {
        emit(BussinessDetailError(errorMessage: error.message));
      }, (data) {
        emit(BussinessDetailLoaded(bussinessDetail: data.data?.items ?? []));
      });
    } catch (e) {
      emit(BussinessDetailError(errorMessage: e.toString()));
    }
  }
}
