import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'core_response.g.dart';

@JsonSerializable()
class CoreResponse extends Object {
  String? message;
  String? errorMessage;
  int headerErrorCode = HttpStatus.ok;

  CoreResponse({this.message = "", this.errorMessage = ""});

  bool isSuccessCode() {
    return headerErrorCode == HttpStatus.ok;
  }

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  factory CoreResponse.fromJson(Map<String, dynamic> json) =>
      _$CoreResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CoreResponseToJson(this);
}
