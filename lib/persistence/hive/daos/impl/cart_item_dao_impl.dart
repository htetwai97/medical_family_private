import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/persistence/hive/daos/abstracts/cart_item_dao.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';

class CartItemDaoImpl extends CartItemDao {
  static final CartItemDaoImpl _singleton = CartItemDaoImpl._internal();

  factory CartItemDaoImpl() {
    return _singleton;
  }
  CartItemDaoImpl._internal();

  /// Persistence
  @override
  void saveCartItem(CartItemVO? cartItem) async {
    await getCartBox().put(cartItem?.countingUnitId, cartItem!);
  }

  @override
  void deleteCartItem(int? countingUnitId) async {
    await getCartBox().delete(countingUnitId);
  }

  @override
  void clearCarts() async {
    await getCartBox().clear();
  }

  @override
  List<CartItemVO?>? getAllCarts() {
    return getCartBox().values.toList();
  }

  /// Reactive
  @override
  Stream<void> getAllCartEventStream() {
    return getCartBox().watch();
  }

  @override
  Stream<List<CartItemVO?>?> getAllCartsStream() {
    return Stream.value(getAllCarts());
  }

  /// Box
  Box<CartItemVO> getCartBox() {
    return Hive.box<CartItemVO>(BOX_NAME_CART_ITEM_VO);
  }
}
