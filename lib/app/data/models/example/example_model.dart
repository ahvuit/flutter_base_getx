import 'package:flutter_base_getx/app/data/entities/example_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example_model.g.dart';

@JsonSerializable()
class ExampleModel extends ExampleEntity {
  ExampleModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) => _$ExampleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExampleModelToJson(this);
}