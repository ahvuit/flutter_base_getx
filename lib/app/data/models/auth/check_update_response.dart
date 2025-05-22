import 'package:flutter_base_getx/app/data/models/auth/check_update.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_update_response.g.dart';

@JsonSerializable()
class CheckUpdateResponse {
  @JsonKey(name: "data")
  final CheckUpdate? data;

  CheckUpdateResponse({this.data});

  factory CheckUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckUpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUpdateResponseToJson(this);
}
