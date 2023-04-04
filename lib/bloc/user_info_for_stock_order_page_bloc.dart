import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/data/vo_models/instock_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/township_vo.dart';

class UserInfoForStockOrderPageBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// bloc state
  String name = "";
  String phone = "";
  String address = "";
  TownShipVO? township;
  String paymentType = "";
  String paymentChannel = "";
  String remark = "";
  bool isUnlockConfirmButton = false;
  bool isLoading = false;
  bool isApiCalling = false;
  List<CartItemVO?>? cartList = [];
  String? userId;
  int? subTotal;
  int? totalQuantity;
  int? estimatedShipping = 0;
  int? discount = 0;
  int? totalWithoutDiscount;
  int? totalFinal;
  List<TownShipVO?>? townshipList;
  File? file;
  String? paymentRemark = "";
  String? payAmount = "";
  bool isSuccessScreenShot = false;

  UserInfoForStockOrderPageBloc() {
    _showLoading();

    model.getTownShips().then((value) {
      townshipList = value;
      _notifySafely();

      model.getUserInfoString(USER_ID).then((value) {
        userId = value;
        _notifySafely();

        model.getAllCartsStream().listen((cartList) {
          this.cartList =
              cartList?.where((element) => element?.userId == userId).toList();
          subTotal = cartList?.fold(
              0, (previousValue, cart) => previousValue! + cart!.updatePrice!);
          totalQuantity = cartList?.fold(0,
              (previousValue, element) => previousValue! + element!.quantity!);
          totalWithoutDiscount = subTotal! + estimatedShipping!;
          totalFinal = totalWithoutDiscount! - discount!;
          _notifySafely();

          model.getUserInfoString(NAME).then((value) {
            name = value;
            _notifySafely();

            model.getUserInfoString(CONTACT_NUMBER).then((value) {
              phone = value;
              _notifySafely();

              model.getUserInfoString(SHIPPING_ADDRESS).then((value) {
                address = value;
                _notifySafely();
              }).whenComplete(() => _hideLoading());
            });
          });
        });
      });
    });
  }

  Future onTapOKToCheckOut() {
    isApiCalling = true;
    _notifySafely();
    var checkOutObj = InStockOrderVO(
      userId: int.parse(userId ?? ""),
      userName: name,
      phone: phone,
      address: address,
      township: township?.township,
      charges: township?.charges,
      paymentType: paymentType,
      paymentChannel: paymentChannel,
      remark: remark,
      products: cartList,
      quantity: totalQuantity,
      total: totalFinal,
    );
    model.clearCarts();
    return model.postOrderSave(checkOutObj).then((value) {
      isApiCalling = false;
      _notifySafely();
    });
  }

  void _unLockConfirmButton() {
    if (name != "" &&
        phone != "" &&
        address != "" &&
        township != null &&
        paymentType != "" &&
        paymentChannel != "" &&
        remark != "" &&
        isSuccessScreenShot) {
      isUnlockConfirmButton = true;
      _notifySafely();
    } else {
      isUnlockConfirmButton = false;
      _notifySafely();
    }
  }

  void onNameChange(String name) {
    this.name = name;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onContactNumberChange(String contactNumber) {
    phone = contactNumber;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onShippingAddressChange(String shippingAddress) {
    address = shippingAddress;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChooseTownship(String? township) {
    _showLoading();
    this.township =
        townshipList?.singleWhere((element) => element?.township == township);
    _notifySafely();
    _hideLoading();
    _unLockConfirmButton();
  }

  void onChoosePaymentType(String paymentType) {
    this.paymentType = paymentType;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChoosePaymentChannel(String paymentChannel) {
    this.paymentChannel = paymentChannel;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChangeRemark(String remark) {
    this.remark = remark;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChosenFile(File file) {
    this.file = file;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChangePaymentRemark(String remark) {
    paymentRemark = remark;
    _notifySafely();
    _unLockConfirmButton();
  }

  void onChangePayAmount(String payAmount) {
    this.payAmount = payAmount;
    _notifySafely();
    _unLockConfirmButton();
  }

  Future onTapSaveFile() {
    isApiCalling = true;
    _notifySafely();
    if (file != null && paymentRemark != "" && payAmount != "") {
      return model
          .postScreenShot(file!, paymentRemark!, payAmount!)
          .then((value) {
        debugPrint("success =======> ${value.amount}");
        isSuccessScreenShot = true;
        isApiCalling = false;
        _notifySafely();
      }).catchError((e) {
        debugPrint("Error======>${e.toString()}");
      });
    } else {
      return Future.error("not complete");
    }
  }

  void onTapCancelFile() {
    file = null;
    payAmount = "";
    paymentRemark = "";
    _notifySafely();
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
