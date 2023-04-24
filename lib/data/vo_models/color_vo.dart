import 'package:json_annotation/json_annotation.dart';
part 'color_vo.g.dart';

@JsonSerializable()
class ColorVO {
  @JsonKey(name: "colour")

  ///Map<String,dynamic>? colors;
  List<dynamic>? colors;

  ColorVO({this.colors});

  factory ColorVO.fromJson(Map<String, dynamic> json) =>
      _$ColorVOFromJson(json);
  Map<String, dynamic> toJson() => _$ColorVOToJson(this);

  @override
  String toString() {
    return 'ColorVO{colors: $colors}';
  }
}
