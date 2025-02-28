// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      code: json['code'] ?? '000000',
      errorMessage: json['errorMessage'] ?? "",
      pagination: json['pagination'] == null
          ? null
          : BasePagingResponse.fromJson(
              json['pagination'] as Map<String, dynamic>),
    )..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'pagination': instance.pagination,
      'errorMessage': instance.errorMessage,
    };
