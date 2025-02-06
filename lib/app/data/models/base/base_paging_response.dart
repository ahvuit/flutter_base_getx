import 'package:json_annotation/json_annotation.dart';

part 'base_paging_response.g.dart';

@JsonSerializable()
class BasePagingResponse extends Object {

  @JsonKey(name: "current_page")
  int? currentPage;

  @JsonKey(name: "last_page")
  int? lastPage;

  @JsonKey(name: "per_page")
  int? perPage;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "total_rows")
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