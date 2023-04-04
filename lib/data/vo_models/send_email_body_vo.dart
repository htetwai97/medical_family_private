import 'package:json_annotation/json_annotation.dart';
import 'package:medical_family_app/data/vo_models/attach_vo.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
part 'send_email_body_vo.g.dart';

@JsonSerializable()
class SendEmailBodyVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "preorders")
  List<PreOrderItemVO?>? preOrders;

  @JsonKey(name: "attachs")
  List<CustomPreOrderItemVO?>? attaches;

  @JsonKey(name: "type")
  int? type;

  SendEmailBodyVO({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.preOrders,
    this.attaches,
    this.type,
  });

  factory SendEmailBodyVO.fromJson(Map<String, dynamic> json) =>
      _$SendEmailBodyVOFromJson(json);
  Map<String, dynamic> toJson() => _$SendEmailBodyVOToJson(this);
}
