import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/post_pre_order_object_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/send_email_body_vo.dart';
import 'package:path_provider/path_provider.dart';

class UserInfoForPreOrderBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App states
  String? name = "";
  String? phone = "";
  String? address = "";
  String? email = "";
  String? orderDate = "";
  String? paymentType = "";
  String? paymentChannel = "";
  bool isUnlockConfirmButton = false;
  bool isLoading = false;
  bool isApiCalling = false;
  String? userId;
  List<PreOrderItemVO?>? preOrderItemList = [];
  List<CustomPreOrderItemVO?>? customPreOrderList = [];
  bool isCustomOrder = false;
  File? file;
  String? paymentRemark = "";
  String? payAmount = "";
  bool isSuccessScreenShot = false;
  bool orderSuccess = false;

  UserInfoForPreOrderBloc(bool isCustom) {
    isCustomOrder = isCustom;
    _notifySafely();
    _showLoading();

    orderDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    _notifySafely();
    model.getUserInfoString(USER_ID).then((value) {
      userId = value;
      _notifySafely();

      model.getUserInfoString(USER_NAME).then((value) {
        name = value;
        _notifySafely();

        model.getUserInfoString(CONTACT_NUMBER).then((value) {
          phone = value;
          _notifySafely();

          model.getUserInfoString(SHIPPING_ADDRESS).then((value) {
            address = value;
            _notifySafely();

            model.getUserInfoString(EMAIL).then((value) {
              email = value;
              _notifySafely();

              model.getAllPreOrdersStream().listen((event) {
                preOrderItemList = event
                    ?.where((element) => element?.userId == userId)
                    .toList();
                _notifySafely();

                model.getAllCustomPreOrdersStream().listen((event) {
                  customPreOrderList = event
                      ?.where((element) => element?.userId == userId)
                      .toList();
                  _notifySafely();
                  _hideLoading();
                });
              });
            });
          });
        });
      });
    });
  }

  Future onTapOk() {
    if (isCustomOrder == false) {
      var postObj = PostPreOrderObjectVO(
        id: int.parse(userId ?? ""),
        name: name,
        phone: phone,
        address: address,
        orders: preOrderItemList,
      );

      return model.postPreOrderSave(postObj).then((value) {
        orderSuccess = true;
        _notifySafely();
        var emailBody = SendEmailBodyVO(
          id: int.parse(userId ?? ""),
          name: name,
          phone: phone,
          address: address,
          email: email,
          preOrders: preOrderItemList,
          attaches: [],
          type: 1,
        );
        model.clearPreOrders();
        model.postEmailBodyRetrofit(emailBody).then((value) {
          debugPrint(value.message.toString());
        });
      }).catchError((e) {
        orderSuccess = false;
        _notifySafely();
        debugPrint(e.toString());
      });
    } else {
      var postObjForStepOne = PostPreOrderObjectVO(
        id: int.parse(userId ?? ""),
        name: name,
        phone: phone,
        address: address,

        /// use the common object ,so empty list is an extra for this section
        orders: [],
      );
      return model.postCustomerOrderStepOne(postObjForStepOne).then((id) async {
        for (int i = 0; i < customPreOrderList!.length; i++) {
          var convertedFile =
              await _saveFile(customPreOrderList![i]!.attach!, "$i.png");
          customPreOrderList?[i]?.file = convertedFile;
          _notifySafely();

          var emailBody = SendEmailBodyVO(
            id: int.parse(userId ?? ""),
            name: name,
            phone: phone,
            address: address,
            email: email,
            preOrders: [],
            attaches: customPreOrderList,
            type: 2,
          );

          await model
              .postCustomImageAndBody(
            customPreOrderList![i]?.quantity ?? "",
            customPreOrderList![i]?.description ?? "",
            customPreOrderList![i]?.price ?? "",
            customPreOrderList![i]?.totalQuantity ?? "",
            customPreOrderList![i]?.totalAmount ?? "",
            id.toString(),
            convertedFile,
          )
              .then((value) {
            orderSuccess = true;
            _notifySafely();
            model.clearCustomPreOrders();
            model.postEmailBodyRetrofit(emailBody).then((value) {
              debugPrint(value.message);
            }).catchError((e) {
              debugPrint(e.toString());
            });
          }).catchError((e) {
            orderSuccess = false;
            _notifySafely();
            debugPrint(e.toString());
          });
        }
      });
    }
  }

  Future<File> _saveFile(Uint8List bytes, String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }

  void _unLockConfirmButton() {
    if (name != "" &&
        phone != "" &&
        address != "" &&
        paymentType != "" &&
        orderDate != "" &&
        paymentChannel != "" &&
        isSuccessScreenShot == true) {
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
        debugPrint("success =======> ${value.ecommerceOrderId}  ${value.id}");
        isSuccessScreenShot = true;
        isApiCalling = false;
        _notifySafely();
        _unLockConfirmButton();
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
