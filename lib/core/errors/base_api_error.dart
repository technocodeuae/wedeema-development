import 'package:json_annotation/json_annotation.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/models/base_entity.dart';

// "error": {
// "code": "string",
// "message_En": "string",
// "message_Ar": "string"
// },

part 'base_api_error.g.dart';

/// This class represent the Certificate model
@JsonSerializable()
class ApiErrorModel extends BaseError {
  final String? status;
  final String? message;

  const ApiErrorModel({
    this.status,
    this.message,
  }) : super((message ?? ''));

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  ApiErrorEntity toEntity() {
    return ApiErrorEntity();
  }
}

class ApiErrorEntity extends BaseEntity {
  final String? status;
  final String? message;

  const ApiErrorEntity({
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
    status,
        this.message,
      ];
}
