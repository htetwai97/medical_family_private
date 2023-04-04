import 'package:medical_family_app/data/vo_models/pre_order_vo.dart';

class PreOrderDummyData {
  List<PreOrderVO> preOrderBrandList = [
    PreOrderVO(
      id: 1,
      url: "assets/images/pre_order_two.png",
      priceRange: "22000-25500",
    ),
    PreOrderVO(
      id: 2,
      url: "assets/images/pre_order_three.png",
      priceRange: "30000-65000",
    ),
    PreOrderVO(
      id: 3,
      url: "assets/images/pre_order_one.png",
      priceRange: "18000-20000",
    )
  ];
}
