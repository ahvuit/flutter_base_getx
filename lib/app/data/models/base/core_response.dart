import 'package:flutter_base_getx/app/core/constants/core_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'core_response.g.dart';

@JsonSerializable()
class CoreResponse extends Object {
  @JsonKey(name: "code")
  dynamic code;
  String? message;
  String? errorMessage;

  CoreResponse({this.code, this.message, this.errorMessage});

  bool isSuccessCode() {
    return (code == CoreConstants.successCode);
  }

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  factory CoreResponse.fromJson(Map<String, dynamic> json) =>
      _$CoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoreResponseToJson(this);
}
