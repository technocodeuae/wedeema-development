
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

class UploadAdsState {


  GeneralState storeAdsState;


  UploadAdsState({

    required this.storeAdsState,
  });

  factory UploadAdsState.initialState() => UploadAdsState(

    storeAdsState: BaseInitState(),


  );

  UploadAdsState copyWith({

    GeneralState? storeAdsState,


  }) {
    return UploadAdsState(

storeAdsState: storeAdsState??this.storeAdsState
    );
  }
}


class StoreAdsSuccessState extends BaseSuccessState {
  final EmptyEntity ads;

  StoreAdsSuccessState(this.ads);
}