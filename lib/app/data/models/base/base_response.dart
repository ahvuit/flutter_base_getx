import 'package:flutter_base_getx/app/core/constants/core_constants.dart';
import 'package:flutter_base_getx/app/data/models/base/core_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_paging_response.dart' show BasePagingResponse;

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends CoreResponse {
  @JsonKey(name: "data")
  final T? data;
  @JsonKey(name: "pagination")
  BasePagingResponse? pagination;

  BaseResponse({
    this.data,
    super.errorMessage = "",
    super.message = "",
    super.code = CoreConstants.successCode,
    this.pagination,
  });

  @override
  @JsonKey(name: "errorMessage")
  String get errorMessage => super.errorMessage ?? '';

  @override
  void setErrorMessage(String errorMessage) {
    super.errorMessage = errorMessage;
  }

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() =>
      _$BaseResponseToJson(this, (object) => object);
}
