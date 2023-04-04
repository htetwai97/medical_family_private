import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';

class MyCartPageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App States
  bool isLoading = false;
  List<CartItemVO?>? cartList = [];
  String? userId;
  int? subTotal;
  int? totalQuantity;
  int? estimatedShipping = 0;
  int? discount = 0;
  int? totalWithoutDiscount;
  int? totalFinal;

  MyCartPageBloc() {
    _showLoading();
    model.getUserInfoString(USER_ID).then((value) {
      userId = value;
      _notifySafely();
    });
    model.getAllCartsStream().listen((cartList) {
      this.cartList =
          cartList?.where((element) => element?.userId == userId).toList();
      subTotal = cartList?.fold(
          0, (previousValue, cart) => previousValue! + cart!.updatePrice!);
      totalQuantity = cartList?.fold(
          0, (previousValue, element) => previousValue! + element!.quantity!);
      totalWithoutDiscount = subTotal! + estimatedShipping!;
      totalFinal = totalWithoutDiscount! - discount!;
      _notifySafely();
      _hideLoading();
    }).onError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapQuantityButton(int? quantity, CartItemVO? cartItem) {
    cartItem?.updatePrice = cartItem.price! * quantity!;
    cartItem?.quantity = quantity;
    _notifySafely();
    model.saveCartItem(cartItem);
  }

  void onTapDeleteButton(CartItemVO? cartItem) {
    model.deleteCartItem(cartItem?.countingUnitId);
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
