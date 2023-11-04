import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/categories/states/categories_state.dart';
import 'package:wadeema/data/models/categories/entity/categories_entity.dart';
import 'package:wadeema/data/models/properties/entity/properties_entity.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/categories/categories_repo_i.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesFacade categoriesRepo;

  CategoriesCubit(
    this.categoriesRepo,
  ) : super(CategoriesState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Map<int,String?> selectedSubprop = {};

  List<PropertiesEntity>? _data;
  bool isAcceptPrivacy = false;
  List<CategoriesEntity> categories = [];

  clear(){
    selectedSubprop = {};
    // _data = null;
    isAcceptPrivacy = false;
  }

  bool isJobs(String title){
    return title.toLowerCase().contains('jobs') || title.toLowerCase().contains('عمل') || title.toLowerCase().contains('وظائف');
  }

  bool isCommunity(String title){
    return title.toLowerCase().contains('community') || title.toLowerCase().contains('اجتماعي') || title.toLowerCase().contains('مجتمع');
  }

  bool isPriceRange(String title){
    // return title.toLowerCase().contains('price to') || title.toLowerCase().contains('price from') || title.toLowerCase().contains('السعر من') || title.toLowerCase().contains('السعر إلى');
    return title.toLowerCase().contains('price to') || title.toLowerCase().contains('السعر إلى');
  }

  Future<void> getMainCategories({bool withEmit = true,VoidCallback? onDone}) async {
    if(withEmit) {
      emit(state.copyWith(getMainCategoriesState: BaseLoadingState()));
    }
    final result = await categoriesRepo.getMainCategories();
    if (result.hasDataOnly) {
      if(withEmit) {
        emit(state.copyWith(
            getMainCategoriesState: GetMainCategoriesSuccessState(result.data!)));
      }
      categories = result.data ?? [];
      if(onDone != null){
        onDone();
      }
    } else {
      if(withEmit) {
        emit(
          state.copyWith(
            getMainCategoriesState: BaseFailState(
              result.error,
              callback: () => this.getMainCategories(),
            ),
          ),
        );
      }
    }
  }

  int currentSelect2 =0;
  void sendCurrentSelect({required int currentSelect}){
    currentSelect2= currentSelect;
    emit(state.copyWith(SendCurrentSelect: SendCurrentSelectSuccessState()));
  }

  Future<void> getSubCategories(int id) async {
    emit(state.copyWith(getSubCategoriesState: BaseLoadingState()));
    final result = await categoriesRepo.getSubCategories(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getSubCategoriesState: GetSubCategoriesSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getSubCategoriesState: BaseFailState(
            result.error,
            callback: () => this.getSubCategories(id),
          ),
        ),
      );
    }
  }

  Future<void> getPropertiesCategories(int id) async {
    emit(state.copyWith(getPropertiesCategories: BaseLoadingState()));
    final result = await categoriesRepo.getPropertiesCategories(id);
    if (result.hasDataOnly) {
      _data = result.data;
      emit(state.copyWith(
          getPropertiesCategories: GetPropertiesCategoriesSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getPropertiesCategories: BaseFailState(
            result.error,
            callback: () => this.getPropertiesCategories(id),
          ),
        ),
      );
    }
  }

  refresh() {
    emit(state.copyWith(getPropertiesCategories: BaseLoadingState()));
    emit(state.copyWith(getPropertiesCategories: GetPropertiesCategoriesSuccessState(_data!)));
  }

  List<Map<String,dynamic>> getPropertyData() {
    List<Map<String,dynamic>> mapDetails = [];
    for (int catId in selectedSubprop.keys.toList()) {
      mapDetails.add({"id": catId, "description": selectedSubprop[catId]});
    }

    return mapDetails;
  }
}
