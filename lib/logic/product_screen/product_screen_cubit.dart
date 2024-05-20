import 'package:baapapp/models/product_response_model/product_response_model.dart';
import 'package:baapapp/repositories/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_screen_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());

  final ProductRepo _productRepo = ProductRepo();

  void getProductBySubCategoryId({int? subcategoryId, int? groupId}) async {
    try {
      emit(ProductListLoading());
      var data = await _productRepo.getProductDataBySubCategoryId(
          subcategoryId: subcategoryId, groupId: groupId);
      data.fold((error) {
        emit(ProductListError());
      }, (data) {
        emit(ProductListLoaded(productModel: data.data?.items));
      });
    } catch (e) {
      emit(ProductListError(error: e.toString()));
    }
  }

  void getProductByCategoryId({int? categoryId, int? groupId}) async {
    try {
      emit(ProductListLoading());
      var data = await _productRepo.getProductDataByCategoryId(
        categoryId: categoryId,
        groupId: groupId,
      );
      data.fold((error) {
        emit(ProductListError());
      }, (data) {
        emit(ProductListLoaded(productModel: data.data?.items));
      });
    } catch (e) {
      emit(ProductListError(error: e.toString()));
    }
  }

  void getProductBySearch({String? value, int? groupId}) async {
    try {
      emit(ProductListLoading());
      var data = await _productRepo.getProductDataBySearch(
        groupId: groupId,
        value: value,
      );
      data.fold((error) {
        emit(ProductListError());
      }, (data) {
        emit(ProductListLoaded(productModel: data.data?.items));
      });
    } catch (e) {
      emit(ProductListError(error: e.toString()));
    }
  }
}
