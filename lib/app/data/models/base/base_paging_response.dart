import 'package:json_annotation/json_annotation.dart';

part 'base_paging_response.g.dart';

@JsonSerializable()
class BasePagingResponse extends Object {

  @JsonKey(name: "currentPage")
  int? currentPage;

  @JsonKey(name: "lastPage")
  int? lastPage;

  @JsonKey(name: "perPage")
  int? perPage;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "totalRows")
  int? totalRows;

  BasePagingResponse({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.totalPages,
    this.totalRows
  });

  factory BasePagingResponse.fromJson(Map<String, dynamic> json) =>
      _$BasePagingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasePagingResponseToJson(this);

}