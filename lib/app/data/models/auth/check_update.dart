import 'package:json_annotation/json_annotation.dart';

part 'check_update.g.dart';

@JsonSerializable()
class CheckUpdate {
  final String version;
  final String linkDownload;

  CheckUpdate({
    required this.version,
    required this.linkDownload,
  });

  factory CheckUpdate.fromJson(Map<String, dynamic> json) =>
      _$CheckUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUpdateToJson(this);
}
