part of 'sub_category_cubit.dart';

abstract class SubCategoryState {
  List<SubCategoryModel>? subCategoryModel;
  SubCategoryState({this.subCategoryModel});
}

class SubCategoryInitital extends SubCategoryState {
  SubCategoryInitital({super.subCategoryModel});
}

class SubCategoryLoading extends SubCategoryState {
  SubCategoryLoading({super.subCategoryModel});
}

class SubCategoryLoaded extends SubCategoryState {
  SubCategoryLoaded({super.subCategoryModel});
}

class SubCategoryError extends SubCategoryState {
  final String? error;
  SubCategoryError({this.error, super.subCategoryModel});
}
