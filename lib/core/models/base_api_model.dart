import 'package:json_annotation/json_annotation.dart';
import '../../../../core/errors/base_api_error.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/models/base_models.dart';

part 'base_api_model.g.dart';

// {
// "status": true,
// "error": {
// "code": "string",
// "message_En": "string",
// "message_Ar": "string"
// },
// "result": "string"
// }
@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T extends BaseModel> extends BaseModel {
  final bool? status;
  final ApiErrorModel? error;
  final T? result;

  const ApiResponseModel(
    this.status,
    this.error,
    this.result,
  );

  factory ApiResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? value) fromJsonModel) =>
      _$ApiResponseModelFromJson(json, fromJsonModel);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ApiResponseModelToJson(this, toJsonT);

  @override
  ApiEntity toEntity() {
    return ApiEntity(
      status: this.status,
      error: this.error?.toEntity(),
      result: this.result?.toEntity(),
    );
  }
}

class ApiEntity<T> extends BaseEntity {
  final bool? status;
  final ApiErrorEntity? error;
  final T? result;

  const ApiEntity({this.status, this.error, this.result});

  @override
  List<Object?> get props => [
        this.status,
        this.error,
        this.result,
      ];
}
