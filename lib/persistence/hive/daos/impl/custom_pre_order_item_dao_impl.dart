import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/persistence/hive/daos/abstracts/custom_pre_order_item_dao.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';

class CustomPreOrderItemDaoImpl extends CustomPreOrderItemDao {
  static final CustomPreOrderItemDaoImpl _singleton =
      CustomPreOrderItemDaoImpl._internal();

  factory CustomPreOrderItemDaoImpl() {
    return _singleton;
  }
  CustomPreOrderItemDaoImpl._internal();

  /// database
  @override
  void clearCustomPreOrders() async {
    await getCustomPreOrderItemBox().clear();
  }

  @override
  void deleteCustomPreOrderItem(String? timeStamp) async {
    await getCustomPreOrderItemBox().delete(timeStamp);
  }

  @override
  List<CustomPreOrderItemVO?>? getAllCustomPreOrders() {
    return getCustomPreOrderItemBox().values.toList();
  }

  @override
  CustomPreOrderItemVO? getCustomOrderItem(String? timeStamp) {
    return getCustomPreOrderItemBox().get(timeStamp);
  }

  @override
  void saveAllCustomPreOrders(List<CustomPreOrderItemVO?>? customList) async {
    Map<String?, CustomPreOrderItemVO> customOrderMap = Map.fromIterable(
        customList ?? [],
        key: (customItem) => customItem.timeStamp.toString(),
        value: (customItem) => customItem);
    await getCustomPreOrderItemBox().putAll(customOrderMap);
  }

  @override
  void saveCustomPreOrderItem(CustomPreOrderItemVO? customPreOrderItem) async {
    await getCustomPreOrderItemBox()
        .put(customPreOrderItem?.timeStamp, customPreOrderItem!);
  }

  /// Reactive
  @override
  Stream<void> getAllCustomPreOrdersEventStream() {
    return getCustomPreOrderItemBox().watch();
  }

  @override
  Stream<List<CustomPreOrderItemVO?>?> getAllCustomPreOrdersStream() {
    return Stream.value(getAllCustomPreOrders());
  }

  /// Box
  Box<CustomPreOrderItemVO> getCustomPreOrderItemBox() {
    return Hive.box<CustomPreOrderItemVO>(BOX_NAME_CUSTOM_PRE_ORDER_ITEM_VO);
  }
}
