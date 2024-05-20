import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/sub_category_response_model/sub_category_response_model.dart';
import '../../repositories/home_page_repo.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  final HomePageRepo _homePageRepo = HomePageRepo();
  SubCategoryCubit() : super(SubCategoryInitital());

  void getSubCategory({int? categoryId}) async {
    var latGetStorage = GetStorage().read('latitude');
    var lonGetStorage = GetStorage().read('longitude');
    var distance = LocalStorageUtils.getDistance();
    try {
      emit(SubCategoryLoading());
      var data = await _homePageRepo.getSubCategory(
          categoryId: categoryId,
          lat: latGetStorage,
          lon: lonGetStorage,
          distance: distance);
      data.fold((error) {
        emit(SubCategoryError(error: error.message));
      }, (data) {
        emit(SubCategoryLoaded(subCategoryModel: data.data?.items ?? []));
      });
    } catch (e) {
      emit(SubCategoryError(error: e.toString()));
    }
  }

  void searchSubCategory({String? value}) async {
    try {
      emit(SubCategoryLoading());
      // ignore: prefer_typing_uninitialized_variables
      var distance, userId;
      var latGetStorage = GetStorage().read('latitude');
      var lonGetStorage = GetStorage().read('longitude');
      var user = await LocalStorageUtils.fetchToken();
      if (user?.isNotEmpty ?? false) {
        distance = LocalStorageUtils.getDistance();
        userId = LocalStorageUtils.tokenResponseModel.userId;
      }

      var data = await _homePageRepo.searchSubCategory(
        value: value,
        lat: latGetStorage,
        lon: lonGetStorage,
        distance: distance,
        userId: userId,
      );
      data.fold((error) {
        emit(SubCategoryError(error: error.message));
      }, (data) {
        emit(SubCategoryLoaded(subCategoryModel: data.data?.items ?? []));
      });
    } catch (e) {
      emit(SubCategoryError(error: e.toString()));
    }
  }
}
