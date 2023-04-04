import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "username")
  String? userName;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "registered_date")
  String? registerDate;

  @JsonKey(name: "last_purchased_date")
  String? lastPurchasedDate;

  @JsonKey(name: "total_purchase_amount")
  int? totalPurchaseAmount;

  @JsonKey(name: "total_purchase_time")
  int? totalPurchaseTime;

  @JsonKey(name: "total_purchase_qty")
  int? totalPurchaseQuantity;

  @JsonKey(name: "gender")
  int? gender;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  UserVO({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.userName,
    this.password,
    this.registerDate,
    this.lastPurchasedDate,
    this.totalPurchaseAmount,
    this.totalPurchaseTime,
    this.totalPurchaseQuantity,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);
  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, address: $address, userName: $userName, password: $password, registerDate: $registerDate, lastPurchasedDate: $lastPurchasedDate, totalPurchaseAmount: $totalPurchaseAmount, totalPurchaseTime: $totalPurchaseTime, totalPurchaseQuantity: $totalPurchaseQuantity, gender: $gender, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
