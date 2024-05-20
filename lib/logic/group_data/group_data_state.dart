part of 'group_data_cubit.dart';

abstract class GroupDataState {
  GroupModel? groupData;
  GroupDataState({this.groupData});
}

class GroupDataInitial extends GroupDataState {
  GroupDataInitial({super.groupData});
}

class GroupDataLoading extends GroupDataState {
  GroupDataLoading({super.groupData});
}

class GroupDataLoaded extends GroupDataState {
  GroupDataLoaded({super.groupData});
}

class GroupDataError extends GroupDataState {
  final String? errorMessage;
  GroupDataError({this.errorMessage, super.groupData});
}
