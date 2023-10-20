import '../../../core/results/result.dart';
import '../../core/models/empty_entity.dart';
import '../../data/models/more_info_profile/entity/more_info_profile_entity.dart';
import '../../data/models/more_info_profile/more_info_profile_model.dart';
import '../../data/models/other_profile/entity/other_profile_entity.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../data/models/profile/profile_model.dart';
import '../../data/models/settings/entity/settings_entity.dart';
import '../../data/models/share_link/entity/share_link_entity.dart';

abstract class SettingsFacade {
  Future<Result<ShareLinkEntity>> getShareLink(String url);
  Future<Result<ItemsSettingsEntity>> getAboutApp();
  Future<Result<ItemsSettingsEntity>> getPrivacyPolicy();
  Future<Result<ItemsSettingsEntity>> getTerms();
  Future<Result<FAQEntity>> getFAQ(int page);

}
