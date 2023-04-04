import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';

abstract class CartItemDao {
  void saveCartItem(CartItemVO? cartItem);
  void deleteCartItem(int? countingUnitId);
  List<CartItemVO?>? getAllCarts();
  void clearCarts();

  /// Reactive
  Stream<void> getAllCartEventStream();
  Stream<List<CartItemVO?>?> getAllCartsStream();
}
