import 'package:json_annotation/json_annotation.dart';
part 'fabric_vo.g.dart';

@JsonSerializable()
class FabricVO {
  @JsonKey(name: "fabric")
  Map<String,dynamic>? fabrics;

  FabricVO({this.fabrics});

  factory FabricVO.fromJson(Map<String, dynamic> json) =>
      _$FabricVOFromJson(json);
  Map<String, dynamic> toJson() => _$FabricVOToJson(this);

  @override
  String toString() {
    return 'FabricVO{fabrics: $fabrics}';
  }
}
