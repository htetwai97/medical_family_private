import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
import 'package:medical_family_app/persistence/hive/daos/abstracts/pre_order_item_dao.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';

class PreOrderItemDaoImpl extends PreOrderItemDao {
  static final PreOrderItemDaoImpl _singleton = PreOrderItemDaoImpl._internal();

  factory PreOrderItemDaoImpl() {
    return _singleton;
  }
  PreOrderItemDaoImpl._internal();

  /// Persistence
  @override
  void savePreOrderItem(PreOrderItemVO? preOrderItem) async {
    await getPreOrderBox().put(preOrderItem?.itemName, preOrderItem!);
  }

  @override
  void deletePreOrderItem(String? itemName) async {
    await getPreOrderBox().delete(itemName);
  }

  @override
  List<PreOrderItemVO?>? getAllPreOrders() {
    return getPreOrderBox().values.toList();
  }

  @override
  void saveAllPreOrders(List<PreOrderItemVO?>? preOrderList) async {
    Map<String?, PreOrderItemVO> preOrderMap = Map.fromIterable(
        preOrderList ?? [],
        key: (orderItem) => orderItem.itemName,
        value: (orderItem) => orderItem);
    await getPreOrderBox().putAll(preOrderMap);
  }

  /// Reactive
  @override
  Stream<void> getAllPreOrdersEventStream() {
    return getPreOrderBox().watch();
  }

  @override
  Stream<List<PreOrderItemVO?>?> getAllPreOrdersStream() {
    return Stream.value(getAllPreOrders());
  }

  @override
  void clearPreOrders() async {
    await getPreOrderBox().clear();
  }

  /// Box
  Box<PreOrderItemVO> getPreOrderBox() {
    return Hive.box<PreOrderItemVO>(BOX_NAME_PRE_ORDER_ITEM_VO);
  }
}
