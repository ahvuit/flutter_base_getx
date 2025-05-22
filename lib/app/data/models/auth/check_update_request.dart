import 'package:json_annotation/json_annotation.dart';

part 'check_update_request.g.dart';

@JsonSerializable()
class CheckUpdateRequest {
  final String? deviceId;
  final String? oldPassword;
  final String? password;
  final String? playerId;
  final String? username;
  final String? version;

  CheckUpdateRequest({
    this.deviceId,
    this.oldPassword,
    this.password,
    this.playerId,
    this.username,
    this.version,
  });

  factory CheckUpdateRequest.fromJson(Map<String, dynamic> json) => _$CheckUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUpdateRequestToJson(this);
}