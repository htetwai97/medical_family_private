import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/brand_item_vo.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';

class HomePageBloc extends ChangeNotifier {
  /// Bloc state
  bool isDisposed = false;

  /// states
  List<BrandItemVO>? brandList = [];
  List<ItemVO>? newArrivalItemList = [];
  List<ItemVO>? hotSaleItemList = [];
  List<ItemVO>? promotionItemList = [];
  bool isLoading = false;
  List<CartItemVO?>? cartList = [];
  String? userId;
  String? hintText = "search in family";

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  HomePageBloc() {
    _showLoading();
    model.getBrandsWithLogo().then((brandList) {
      this.brandList = brandList;
      _notifySafely();

      model.getUserInfoString(USER_ID).then((value) {
        userId = value;
        _notifySafely();
      });

      model.getAllCartsStream().listen((cartList) {
        this.cartList =
            cartList?.where((element) => element?.userId == userId).toList();
        _notifySafely();
      });

      model.getNewArrivalItems().then((newArrivalItemList) {
        this.newArrivalItemList = newArrivalItemList;
        _notifySafely();

        model.getHotSaleItems().then((hotSaleItemList) {
          this.hotSaleItemList = hotSaleItemList;
          _notifySafely();

          model.getPromotionItems().then((promotionItemList) {
            this.promotionItemList = promotionItemList;
            _notifySafely();
          }).whenComplete(() => _hideLoading());
        });
      });
    });
  }

  Future onTapLogOut() {
    return model.clearSharedPreferences();
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
