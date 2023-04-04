import 'package:json_annotation/json_annotation.dart';
part 'township_vo.g.dart';
@JsonSerializable()
class TownShipVO {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "township")
  String? township;
  @JsonKey(name: "charges")
  int? charges;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  TownShipVO({
    this.id,
    this.township,
    this.charges,
    this.createdAt,
    this.updatedAt,
  });

  factory TownShipVO.fromJson(Map<String, dynamic> json) =>
      _$TownShipVOFromJson(json);
  Map<String, dynamic> toJson() => _$TownShipVOToJson(this);
}
