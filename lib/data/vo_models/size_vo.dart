import 'package:json_annotation/json_annotation.dart';
part 'size_vo.g.dart';
@JsonSerializable()
class SizeVO {
  @JsonKey(name: "size")
  Map<String,dynamic>? sizes;

  SizeVO({this.sizes});

  factory SizeVO.fromJson(Map<String, dynamic> json) => _$SizeVOFromJson(json);
  Map<String, dynamic> toJson() => _$SizeVOToJson(this);

  @override
  String toString() {
    return 'SizeVO{sizes: $sizes}';
  }
}
