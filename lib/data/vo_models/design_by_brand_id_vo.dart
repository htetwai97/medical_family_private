import 'package:json_annotation/json_annotation.dart';
part 'design_by_brand_id_vo.g.dart';

@JsonSerializable()
class DesignByBrandIdVO {
  @JsonKey(name: "design")
  Map<String, dynamic>? designs;

  DesignByBrandIdVO({
    this.designs,
  });

  factory DesignByBrandIdVO.fromJson(Map<String, dynamic> json) =>
      _$DesignByBrandIdVOFromJson(json);
  Map<String, dynamic> toJson() => _$DesignByBrandIdVOToJson(this);
}
