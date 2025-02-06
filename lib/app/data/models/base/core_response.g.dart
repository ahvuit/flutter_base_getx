// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreResponse _$CoreResponseFromJson(Map<String, dynamic> json) => CoreResponse(
  message: json['message'] as String? ?? "",
  errorMessage: json['errorMessage'] as String? ?? "",
)..headerErrorCode = (json['headerErrorCode'] as num).toInt();

Map<String, dynamic> _$CoreResponseToJson(CoreResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorMessage': instance.errorMessage,
      'headerErrorCode': instance.headerErrorCode,
    };
