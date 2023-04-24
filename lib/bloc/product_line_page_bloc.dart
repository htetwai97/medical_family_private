import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/brand_item_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/sub_category_vo.dart';

class ProductLinePageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App States
  bool isLoading = false;
  List<BrandItemVO?>? brandList = [];
  List<ItemVO?>? itemList = [];
  List<SubCategoryVO?>? subcategoryList = [];
  String? categoryId = "1";
  int selectedProductIndex = 0;
  String? hintText = SEARCH_TEXT;

  ProductLinePageBloc(String? searchItem) {
    _showLoading();
    model.getBrandsWithoutLogo().then((brandList) {
      this.brandList = brandList;
      _notifySafely();
    });

    model
        .getItemsAndSubCategoriesByCategory(categoryId ?? "1")
        .then((response) {
      List<String> frontItems = [
        'medicalscrubs3',
        'medicalscrub2',
        'medicalscrubs1',
      ];
      int customCompare(SubCategoryVO? a, SubCategoryVO? b) {
        if (frontItems.contains(a?.name) && frontItems.contains(b?.name)) {
          return subcategoryList!.indexOf(a) - subcategoryList!.indexOf(b);
        } else if (frontItems.contains(a?.name)) {
          return -1;
        } else if (frontItems.contains(b?.name)) {
          return 1;
        } else {
          return 0;
        }
      }

      subcategoryList = response.subs;
      subcategoryList?.sort(customCompare);
      _notifySafely();
      if (searchItem == null) {
        itemList = response.items;
        _notifySafely();
      } else {
        hintText = searchItem;
        _notifySafely();
        model.postSearchStringToGetItems(searchItem).then((value) {
          itemList = value;
          _notifySafely();
        });
      }
    }).whenComplete(() => _hideLoading());
  }

  void onSearchItem(String? search) {
    hintText = search;
    _notifySafely();
    _showLoading();
    model.postSearchStringToGetItems(search ?? "").then((value) {
      itemList = value;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void onTapCategory(String categoryId) {
    this.categoryId = categoryId;
    selectedProductIndex = 0;
    _notifySafely();
    _showLoading();
    model.getItemsAndSubCategoriesByCategory(categoryId).then((response) {
      subcategoryList = response.subs;
      itemList = response.items;
      _notifySafely();
    }).whenComplete(() => _hideLoading());
  }

  void onTapSubCategory(String subCategoryId, int index) {
    selectedProductIndex = index;
    _notifySafely();
    _showLoading();
    if (subCategoryId == "-1") {
      model
          .getItemsAndSubCategoriesByCategory(categoryId ?? "2")
          .then((response) {
        itemList = response.items;
        _notifySafely();
      }).whenComplete(() => _hideLoading());
    } else {
      model
          .getItemsByCategoryAndSubCategory(categoryId ?? "2", subCategoryId)
          .then((response) {
        itemList = response.items;
        _notifySafely();
      }).whenComplete(() => _hideLoading());
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
