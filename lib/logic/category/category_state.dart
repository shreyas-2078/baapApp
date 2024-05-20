part of 'category_cubit.dart';

abstract class CategoryState {
  List<CategoryModel>? categoryModel;
  CategoryState({this.categoryModel});
}

class HomePageInitital extends CategoryState {
  HomePageInitital({super.categoryModel,});
}

class CategoryLoading extends CategoryState {
  CategoryLoading({super.categoryModel,});
}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({super.categoryModel});
}


class CategoryError extends CategoryState {
  final String? error;
  CategoryError({this.error, super.categoryModel,});
}
