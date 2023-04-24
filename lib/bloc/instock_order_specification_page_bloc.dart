import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_id_vo.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';

class InStockOrderSpecificationPageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App State
  bool isLoading = false;
  List<dynamic>? genders = [];
  List<dynamic>? fabrics = [];
  List<dynamic>? colors = [];
  List<dynamic>? sizes = [];

  /// to filter by login user
  String? userId;

  bool focusQuantity = false;
  bool focusPrice = false;

  /// selected Values
  ItemDetailVO? selectedItem;
  String? selectedGender;
  String? selectedFabric;
  String? selectedColor;
  String? selectedSize;
  String? quantity;
  String? price;
  List<PreOrderItemVO?>? preOrderList;

  List<CountingUnitIdVO?>? countingUnitList = [];
  List<CountingUnitIdVO?>? countingUnitsByGender = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderAndFabric = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderFabricAndColor = [];
  List<CountingUnitIdVO?>? selectedCountingUnits = [];
  CountingUnitIdVO? selectedCountingUnit;

  /// to change selected item color
  bool isSelectedGender = false;
  bool isSelectedFabric = false;
  bool isSelectedColor = false;
  bool isSelectedSize = false;

  /// to change selected item color
  int selectedGenderIndex = -1;
  int selectedFabricIndex = -1;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;

  /// to restrict next steps
  bool isCompleteData = false;
  bool isAllowNextButton = false;

  InStockOrderSpecificationPageBloc(ItemDetailVO this.selectedItem) {
    _showLoading();
    model.getItemById(selectedItem?.id?.toString() ?? "").then((response) {
      countingUnitList = response.countingUnitAll;
      genders =
          countingUnitList?.map((e) => e?.genderName).toList().toSet().toList();
      _notifySafely();

      model.getUserInfoString(USER_ID).then((userId) {
        this.userId = userId;
        _notifySafely();

        model.getAllPreOrdersStream().listen((event) {
          preOrderList =
              event?.where((element) => element?.userId == userId).toList();
          _notifySafely();
          _allowNextButton();
          _hideLoading();
        });
      });
    });
  }

  void onChooseGender(String? gender) {
    selectedGender = gender;
    isSelectedGender = true;
    isSelectedFabric = false;
    isSelectedColor = false;
    isSelectedSize = false;
    fabrics = [];
    _notifySafely();

    /// reset

    countingUnitsByGender = countingUnitList
        ?.where((element) => element?.genderName == gender)
        .toList();
    fabrics = countingUnitsByGender
        ?.map((e) => e?.fabricName)
        .toList()
        .toSet()
        .toList();

    /// reset
    colors = [];
    sizes = [];

    /// reset
    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    selectedFabric = null;
    selectedColor = null;
    selectedSize = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChooseFabric(String? fabric) {
    selectedFabric = fabric;
    isSelectedFabric = true;
    isSelectedColor = false;
    isSelectedSize = false;
    colors = [];
    _notifySafely();

    /// reset

    countingUnitsByGenderAndFabric = countingUnitsByGender
        ?.where((element) => element?.fabricName == fabric)
        .toList();
    colors = countingUnitsByGenderAndFabric
        ?.map((e) => e?.colorName)
        .toList()
        .toSet()
        .toList();

    /// reset
    sizes = [];

    /// reset
    selectedColor = null;
    selectedSize = null;

    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChooseColor(String? color) {
    selectedColor = color;
    isSelectedColor = true;
    isSelectedSize = false;
    sizes = [];
    _notifySafely();

    /// reset

    countingUnitsByGenderFabricAndColor = countingUnitsByGenderAndFabric
        ?.where((element) => element?.colorName == color)
        .toList();
    sizes = countingUnitsByGenderFabricAndColor
        ?.map((e) => e?.sizeName)
        .toList()
        .toSet()
        .toList();

    /// reset
    selectedSize = null;

    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChooseSize(String? size) {
    selectedSize = size;
    isSelectedSize = true;
    focusQuantity = true;
    focusPrice = false;
    selectedCountingUnits = countingUnitList
        ?.where((element) =>
            element?.genderName == selectedGender &&
            element?.fabricName == selectedFabric &&
            element?.colorName == selectedColor &&
            element?.sizeName == selectedSize)
        .toList();
    selectedCountingUnits?.take(1);
    selectedCountingUnit = selectedCountingUnits?.elementAt(0);
    price = selectedCountingUnit?.orderPrice?.toString();
    _notifySafely();
    _allowAddButton();
  }

  void onSubmitQuantity(quantity) {
    if (quantity != null && quantity != "") {
      focusPrice = true;
      focusQuantity = false;
      _notifySafely();
    }
  }

  void onChangeQuantity(String? quantity) {
    this.quantity = quantity;
    _notifySafely();
    _allowAddButton();
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

  void _allowAddButton() {
    if (selectedFabric != null &&
        selectedItem != null &&
        selectedColor != null &&
        selectedSize != null &&
        selectedGender != null &&
        quantity != null &&
        price != null) {
      isCompleteData = true;
      _notifySafely();
    } else {
      isCompleteData = false;
      _notifySafely();
    }
  }

  void _allowNextButton() {
    if (preOrderList != null && preOrderList!.isNotEmpty) {
      isAllowNextButton = true;
      _notifySafely();
    } else {
      isAllowNextButton = false;
      _notifySafely();
    }
  }

  void onTapAddButton() {
    var itemName = selectedItem?.itemName;
    var intPrice = int.parse(price ?? "");
    var intQuantity = int.parse(quantity ?? "");
    var total = intPrice * intQuantity;
    var preOrderItem = PreOrderItemVO(
      orderId: DateTime.now().toString(),
      itemName:
          "$itemName $selectedGender $selectedFabric $selectedColor $selectedSize",
      quantity: quantity,
      price: price,
      total: total.toString(),
      isBrand: false,
      userId: userId,
    );
    _saveItem(preOrderItem).then((value) {
      model.getAllPreOrdersStream().listen((event) {
        preOrderList =
            event?.where((element) => element?.userId == userId).toList();
        _notifySafely();
        _allowNextButton();
      });
    });
  }

  Future _saveItem(PreOrderItemVO preOrderItem) {
    model.savePreOrderItem(preOrderItem);
    return Future.value();
  }

  void onTapDeleteIcon(String? itemName) {
    model.deletePreOrderItem(itemName);
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
