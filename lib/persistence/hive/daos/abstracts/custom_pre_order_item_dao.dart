import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';

abstract class CustomPreOrderItemDao {
  /// database
  void saveCustomPreOrderItem(CustomPreOrderItemVO? customPreOrderItem);
  void deleteCustomPreOrderItem(String? timeStamp);
  void clearCustomPreOrders();
  List<CustomPreOrderItemVO?>? getAllCustomPreOrders();
  CustomPreOrderItemVO? getCustomOrderItem(String? timeStamp);
  void saveAllCustomPreOrders(List<CustomPreOrderItemVO?>? customList);

  /// Reactive
  Stream<void> getAllCustomPreOrdersEventStream();
  Stream<List<CustomPreOrderItemVO?>?> getAllCustomPreOrdersStream();
}
