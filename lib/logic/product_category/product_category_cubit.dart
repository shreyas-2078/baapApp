import 'package:baapapp/models/catogory_response_model/product_category_response_model.dart';
import 'package:baapapp/repositories/home_page_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final HomePageRepo _homePageRepo = HomePageRepo();
  ProductCategoryCubit() : super(HomePageInitital());

  void getCategoryByGroupId(BuildContext context) async {
    try {
      emit(ProductCategoryLoading());
      var data = await _homePageRepo.getCategoryByGroupId();
      data.fold((error) {
        emit(ProductCategoryError(error: error.message));
      }, (data) {
        emit(ProductCategoryLoaded(productCategoryModel: data.data?.items ?? []));  
      });
    } catch (e) {
      emit(ProductCategoryError(error: e.toString()));
    }
  }

}
