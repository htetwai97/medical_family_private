import 'package:json_annotation/json_annotation.dart';
part 'sub_category_vo.g.dart';

@JsonSerializable()
class SubCategoryVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "subcategory_code")
  String? subcategoryCode;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "photo_path")
  String? photoPath;

  @JsonKey(name: "category_id")
  int? categoryId;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "type_flag")
  int? typeFlag;

  SubCategoryVO({
    this.id,
    this.subcategoryCode,
    this.name,
    this.photoPath,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.typeFlag,
  });

  factory SubCategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryVOFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryVOToJson(this);

  @override
  String toString() {
    return 'SubCategoryVO{id: $id, subcategoryCode: $subcategoryCode, name: $name, photoPath: $photoPath, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, typeFlag: $typeFlag}';
  }
}
