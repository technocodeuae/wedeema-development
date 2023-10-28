
import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../data/models/categories/entity/categories_entity.dart';
import '../../../data/models/properties/entity/properties_entity.dart';

class CategoriesState {

  GeneralState getMainCategoriesState;
  GeneralState getSubCategoriesState;
  GeneralState getPropertiesCategories;


  CategoriesState({
    required this.getMainCategoriesState,
    required this.getSubCategoriesState,
    required this.getPropertiesCategories,
  });

  factory CategoriesState.initialState() => CategoriesState(

    getMainCategoriesState: BaseInitState(),
    getSubCategoriesState: BaseInitState(),
    getPropertiesCategories: BaseInitState(),

  );

  CategoriesState copyWith({

    GeneralState? getMainCategoriesState,
    GeneralState? getSubCategoriesState,
    GeneralState? getPropertiesCategories,
    GeneralState? SendCurrentSelect,

  }) {
    return CategoriesState(

      getMainCategoriesState: getMainCategoriesState ?? this.getMainCategoriesState,
      getSubCategoriesState: getSubCategoriesState ?? this.getSubCategoriesState,
      getPropertiesCategories: getPropertiesCategories ?? this.getPropertiesCategories,

    );
  }
}


class GetMainCategoriesSuccessState extends BaseSuccessState {
  final List<CategoriesEntity> categories;

  GetMainCategoriesSuccessState(this.categories);
}



class GetSubCategoriesSuccessState extends BaseSuccessState {
  final List<CategoriesEntity> categories;

  GetSubCategoriesSuccessState(this.categories);
}

class SendCurrentSelectSuccessState extends BaseSuccessState {


  SendCurrentSelectSuccessState();
}

class GetPropertiesCategoriesSuccessState extends BaseSuccessState {
  final List<PropertiesEntity> propertiesCategories;

  GetPropertiesCategoriesSuccessState(this.propertiesCategories);
}