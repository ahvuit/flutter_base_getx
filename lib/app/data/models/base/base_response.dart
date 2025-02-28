import 'package:flutter_base_getx/app/core/constants/core_constants.dart';
import 'package:flutter_base_getx/app/data/models/base/core_error_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'base_paging_response.dart';
import 'core_response.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse extends CoreResponse {
  @JsonKey(name: "code")
  dynamic code;

  @JsonKey(name: "pagination")
  BasePagingResponse? pagination;

  BaseResponse({
    this.code = '000000',
    errorMessage = "",
    this.pagination,
  }) : super(
          errorMessage: errorMessage,
        );

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  @override
  bool isSuccessCode() {
    return (code == CoreConstants.successCode);
  }

  bool get success => isSuccessCode();

  @override
  @JsonKey(name: "errorMessage")
  String get errorMessage => super.errorMessage ?? '';

  @override
  void setErrorMessage(String errorMessage) {
    super.errorMessage = errorMessage;
  }

  void updateErrorResponse(CoreResponseError error) {
    code = error.errorCode ?? '500';
    errorMessage = (error.errorMessage?.isEmpty ?? true)
        ? "Server error..."
        : error.errorMessage;
  }
}
