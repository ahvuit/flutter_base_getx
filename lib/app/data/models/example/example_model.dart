import 'package:json_annotation/json_annotation.dart';

part 'example_model.g.dart';

@JsonSerializable()
class ExampleModel {
  final int id;
  final String name;
  final String imageUrl;

  ExampleModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) => _$ExampleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleModelToJson(this);
}