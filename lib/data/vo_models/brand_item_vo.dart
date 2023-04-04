import 'package:json_annotation/json_annotation.dart';
part 'brand_item_vo.g.dart';

@JsonSerializable()
class BrandItemVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "category_code")
  String? categoryCode;

  @JsonKey(name: "category_name")
  String? categoryName;

  @JsonKey(name: "photo_path")
  String? photoPath;

  @JsonKey(name: "created_by")
  String? createdBy;

  @JsonKey(name: "deleted_at")
  String? deletedAt;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "type_flag")
  int? typeFlag;

  BrandItemVO({
    this.id,
    this.categoryCode,
    this.categoryName,
    this.photoPath,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.typeFlag,
  });

  factory BrandItemVO.fromJson(Map<String, dynamic> json) =>
      _$BrandItemVOFromJson(json);
  Map<String, dynamic> toJson() => _$BrandItemVOToJson(this);

  @override
  String toString() {
    return 'BrandItemVO{id: $id, categoryCode: $categoryCode, categoryName: $categoryName, photoPath: $photoPath, createdBy: $createdBy, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, typeFlag: $typeFlag}';
  }
}
