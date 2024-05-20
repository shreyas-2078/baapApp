import 'package:bloc/bloc.dart';

import '../../models/sub_category_list_response_model/sub_category_list_response_model.dart';
import '../../repositories/home_page_repo.dart';

part 'sub_category_list_state.dart';

class SubCategoryListCubit extends Cubit<SubCategoryListState> {
  final HomePageRepo _homePageRepo = HomePageRepo();
  SubCategoryListCubit() : super(SubCategoryListInitital());

  void getSubCategoryList(int? subCategoryListId) async {
    try {
      emit(SubCategoryListLoading());
      var data = await _homePageRepo.getSubCategoryList(subCategoryId: subCategoryListId);
      data.fold((error) {
        emit(SubCategoryListError(error: error.message));
      }, (data) {
        emit(SubCategoryListLoaded(subCategoryListModel: data.data?.items ?? []));
      });
    } catch (e) {
      emit(SubCategoryListError(error: e.toString()));
    }
  }
}
