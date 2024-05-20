part of 'sub_category_list_cubit.dart';

abstract class SubCategoryListState {
  List<SubCategoryListModel>? subCategoryListModel;
  SubCategoryListState({this.subCategoryListModel});
}

class SubCategoryListInitital extends SubCategoryListState {
  SubCategoryListInitital({super.subCategoryListModel});
}

class SubCategoryListLoading extends SubCategoryListState {
  SubCategoryListLoading({super.subCategoryListModel});
}

class SubCategoryListLoaded extends SubCategoryListState {
  SubCategoryListLoaded({super.subCategoryListModel});
}

class SubCategoryListError extends SubCategoryListState {
  final String? error;
  SubCategoryListError({this.error, super.subCategoryListModel});
}
