import 'package:baapapp/repositories/home_page_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/catogory_response_model/category_response_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomePageRepo _homePageRepo = HomePageRepo();
  CategoryCubit() : super(HomePageInitital());

  void getCategory(BuildContext context) async {
    try {
      emit(CategoryLoading());
      var data = await _homePageRepo.getCategory();
      data.fold((error) {
        emit(CategoryError(error: error.message));
      }, (data) {
        emit(CategoryLoaded(categoryModel: data.data?.items ?? []));
        // if (data.data?.items?.isNotEmpty ?? false) {
        //   context
        //       .read<SubCategoryCubit>()
        //       .getSubCategory(categoryId: data.data?.items?[0].categoryId);
        // }
      });
    } catch (e) {
      emit(CategoryError(error: e.toString()));
    }
  }

}
