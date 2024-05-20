
import 'package:baapapp/models/group_response_model/group_response_model.dart';
import 'package:baapapp/repositories/product_repo.dart';
import 'package:bloc/bloc.dart';

part 'group_data_state.dart';


class GroupDataCubit extends Cubit<GroupDataState> {
  final ProductRepo _productRepo = ProductRepo();
  GroupDataCubit() : super(GroupDataInitial());
  
  void getGroupData({int? groupId}) async { 
    try {
      emit(GroupDataLoading());
      var data = await _productRepo.getGroupDetail(groupId: groupId);
      data.fold((error) {
        emit(GroupDataError(errorMessage: error.message));
      }, (data) {
        emit(GroupDataLoaded(groupData: data.data));
      });
    } catch (e) {
      emit(GroupDataError(errorMessage: e.toString()));
    }
  }



}
