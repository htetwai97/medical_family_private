import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';

abstract class PreOrderItemDao {
  void savePreOrderItem(PreOrderItemVO? preOrderItem);
  void deletePreOrderItem(String? itemName);
  void clearPreOrders();
  List<PreOrderItemVO?>? getAllPreOrders();
  void saveAllPreOrders(List<PreOrderItemVO?>? preOrderList);

  /// Reactive
  Stream<void> getAllPreOrdersEventStream();
  Stream<List<PreOrderItemVO?>?> getAllPreOrdersStream();
}
