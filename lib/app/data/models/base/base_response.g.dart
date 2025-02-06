// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
        data: _$nullableGenericFromJson(json['data'], fromJsonT),
        code: json['code'] ?? CoreErrorCode.successCode,
        errorMessage: json['errorMessage'] as String? ?? "",
        pagination:
            json['pagination'] == null
                ? null
                : BasePagingResponse.fromJson(
                  json['pagination'] as Map<String, dynamic>,
                ),
      )
      ..message = json['message'] as String?
      ..headerErrorCode = (json['headerErrorCode'] as num).toInt();

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'message': instance.message,
  'headerErrorCode': instance.headerErrorCode,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'code': instance.code,
  'pagination': instance.pagination,
  'errorMessage': instance.errorMessage,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
