import '../../../../core/models/base_entity.dart';

class MockVersionEntity extends BaseEntity {
  @override
  List<Object?> get props => [];
  String? latestVersion;
  String? minimumSupportedVersion;
  String? updateUrl;

  MockVersionEntity(
      {this.latestVersion, this.minimumSupportedVersion, this.updateUrl});
}
