import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_id_vo.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
import 'package:medical_family_app/data/vo_models/item_to_post_related_item_vo.dart';
import 'package:medical_family_app/network/responses/get_item_by_id_response.dart';

class ItemDetailPageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App States
  GetItemByIdResponse? response;
  bool isLoading = false;

  List<ItemDetailVO?>? relatedItemList = [];

  List<dynamic>? genderList;
  List<dynamic>? fabricList = [];
  List<dynamic>? colorList = [];
  List<dynamic>? sizeList = [];

  String? selectedGender;
  String? selectedFabric;
  String? selectedColor;
  String? selectedSize;


  List<CountingUnitIdVO?>? countingUnitList = [];
  List<CountingUnitIdVO?>? countingUnitsByGender = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderAndFabric = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderFabricAndColor = [];
  List<CountingUnitIdVO?>? selectedCountingUnits = [];
  CountingUnitIdVO? selectedCountingUnit;


  bool isSelectedGender = false;
  bool isSelectedFabric = false;
  bool isSelectedColor = false;
  bool isSelectedSize = false;
  int selectedGenderIndex = -1;
  int selectedFabricIndex = -1;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  bool isAddToCartAllowed = false;
  bool isCompleteData = false;
  int? valueOfPreOrder;
  int? valueOfStock;

  List<CartItemVO?>? cartList = [];

  String? userId;

  ItemDetailPageBloc(String itemId) {
    _showLoading();
    model.getItemById(itemId).then((response) {
      this.response = response;
      valueOfStock = response.valueOfInStock;
      valueOfPreOrder = response.valueOfPreorder;
      countingUnitList = response.countingUnits;
      genderList =
          countingUnitList?.map((e) => e?.genderName).toList().toSet().toList();
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
      var bodyToPost = ItemToPostRelatedItemVO(
        itemId: "${response.item?.id}",
        categoryId: "${response.item?.categoryId}",
        subCategoryId: "${response.item?.subCategoryId}",
      );
      model.postRelatedItem(bodyToPost).then((relatedItemList) {
        this.relatedItemList = relatedItemList;
        _notifySafely();
      }).whenComplete(() => _hideLoading());
    });
  }

  void onChooseGender(String? gender) {
    selectedGender = gender;
    isSelectedGender = true;
    isSelectedFabric = false;
    isSelectedColor = false;
    isSelectedSize = false;
    countingUnitsByGender = countingUnitList
        ?.where((element) => element?.genderName == gender)
        .toList();
    fabricList = countingUnitsByGender
        ?.map((e) => e?.fabricName)
        .toList()
        .toSet()
        .toList();
    colorList = [];
    sizeList = [];

    ///
    selectedFabric = null;
    selectedColor = null;
    selectedSize = null;

    ///
    selectedCountingUnits = null;
    selectedCountingUnit = null;
    _notifySafely();
    _checkCompleteData();
    _allowAddToCartButton();
  }

  void onChooseFabric(String? fabric) {
    selectedFabric = fabric;
    isSelectedFabric = true;
    isSelectedColor = false;
    isSelectedSize = false;

    ///
    selectedColor = null;
    selectedSize = null;

    ///
    countingUnitsByGenderAndFabric = countingUnitsByGender
        ?.where((element) => element?.fabricName == fabric)
        .toList();
    colorList = countingUnitsByGenderAndFabric
        ?.map((e) => e?.colorName)
        .toList()
        .toSet()
        .toList();
    sizeList = [];
    selectedCountingUnits = null;
    selectedCountingUnit = null;
    _notifySafely();
    _checkCompleteData();
    _allowAddToCartButton();
  }

  void onChooseColor(String? color) {
    selectedColor = color;
    isSelectedColor = true;
    isSelectedSize = false;

    ///
    selectedSize = null;

    ///
    countingUnitsByGenderFabricAndColor = countingUnitsByGenderAndFabric
        ?.where((element) => element?.colorName == color)
        .toList();
    sizeList = countingUnitsByGenderFabricAndColor
        ?.map((e) => e?.sizeName)
        .toList()
        .toSet()
        .toList();
    selectedCountingUnits = null;
    selectedCountingUnit = null;
    _notifySafely();
    _checkCompleteData();
    _allowAddToCartButton();
  }

  void onChooseSize(String? size) {
    selectedSize = size;
    isSelectedSize = true;
    selectedCountingUnits = countingUnitList
        ?.where((element) =>
            element?.genderName == selectedGender &&
            element?.fabricName == selectedFabric &&
            element?.colorName == selectedColor &&
            element?.sizeName == selectedSize)
        .toList();
    selectedCountingUnits?.take(1);
    selectedCountingUnit = selectedCountingUnits?.elementAt(0);
    _notifySafely();
    _checkCompleteData();
    _allowAddToCartButton();
  }

  void _allowAddToCartButton() {
    if (isCompleteData) {
      if (selectedCountingUnit?.currentQuantity != 0 &&
          response?.valueOfInStock == 1) {
        isAddToCartAllowed = true;
        _notifySafely();
      } else {
        isAddToCartAllowed = false;
        _notifySafely();
      }
    }
  }

  void _checkCompleteData() {
    if (selectedFabric != null &&
        selectedColor != null &&
        selectedSize != null) {
      isCompleteData = true;
      _notifySafely();
    } else {
      isCompleteData = false;
      _notifySafely();
    }
  }

  void onTapGender(int index) {
    selectedGenderIndex = index;
    _notifySafely();
  }

  void onTapFabric(int index) {
    selectedFabricIndex = index;
    _notifySafely();
  }

  void onTapColor(int index) {
    selectedColorIndex = index;
    _notifySafely();
  }

  void onTapSize(int index) {
    selectedSizeIndex = index;
    _notifySafely();
  }

  Future onTapAddToCart() async {
    var userId = await model.getUserInfoString(USER_ID);
    var timeStamp = DateTime.now().toString();
    CartItemVO cartItem = CartItemVO(
      cartItemId: timeStamp,
      itemName: response?.item?.itemName,
      countingUnitId: selectedCountingUnit?.id,
      gender: selectedGender,
      color: selectedColor,
      fabric: selectedFabric,
      size: selectedSize,
      updatePrice: selectedCountingUnit?.purchasePrice,
      price: selectedCountingUnit?.purchasePrice,
      quantity: 1,
      stockQuantity: selectedCountingUnit?.currentQuantity,
      userId: userId,
      itemImage: response?.item?.photoPath,
      unitCode: selectedCountingUnit?.unitCode,
      unitName: selectedCountingUnit?.unitName,
    );
    model.saveCartItem(cartItem);
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
