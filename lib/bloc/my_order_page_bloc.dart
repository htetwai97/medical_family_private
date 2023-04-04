import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/both_order_response_vo.dart';

class MyOrderPageBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// AppState
  bool isLoading = false;
  bool forceLoading = false;
  bool isChooseInStock = true;
  bool isChoosePreorder = false;
  List<BothOrderResponseVO?>? inStockOrderList = [];
  List<BothOrderResponseVO?>? orderList = [];
  List<BothOrderResponseVO?>? preOrderList = [];

  MyOrderPageBloc() {
    _showLoading();
    model.getUserInfoString(USER_ID).then((userId) {
      model.getOrderList().then((value) {
        inStockOrderList = value.inStock
            ?.where((element) => element?.customerId?.toString() == userId)
            .toList();
        inStockOrderList?.sort((a, b) => int.parse(b?.id?.toString() ?? "")
            .compareTo(int.parse(a?.id?.toString() ?? "")));

        preOrderList = value.preOrder
            ?.where((element) => element?.customerId?.toString() == userId)
            .toList();
        preOrderList?.sort((a, b) => int.parse(b?.id?.toString() ?? "")
            .compareTo(int.parse(a?.id?.toString() ?? "")));

        orderList = inStockOrderList;
        _notifySafely();
        _hideLoading();
      });
    });
  }

  void onChooseOrder(int index) async {
    if (index == 0) {
      isChooseInStock = true;
      isChoosePreorder = false;
      forceLoading = true;
      _notifySafely();
      await Future.delayed(const Duration(milliseconds: 100));
      orderList = inStockOrderList;
      forceLoading = false;
      _notifySafely();
    } else {
      isChooseInStock = false;
      isChoosePreorder = true;
      forceLoading = true;
      _notifySafely();
      await Future.delayed(const Duration(milliseconds: 100));
      orderList = preOrderList;
      forceLoading = false;
      _notifySafely();
    }
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
