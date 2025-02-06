// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_paging_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePagingResponse _$BasePagingResponseFromJson(Map<String, dynamic> json) =>
    BasePagingResponse(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalRows: (json['total_rows'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BasePagingResponseToJson(BasePagingResponse instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'totalPages': instance.totalPages,
      'total_rows': instance.totalRows,
    };
