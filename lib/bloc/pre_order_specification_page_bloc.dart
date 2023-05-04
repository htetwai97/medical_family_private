import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/color_for_family_arrow_vo.dart';
import 'package:medical_family_app/data/vo_models/counting_unit_id_vo.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/design_object_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';

class PreOrderSpecificationPageBloc extends ChangeNotifier {
  /// bloc state
  bool isDisposed = false;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  /// App State
  bool isLoading = false;
  List<DesignObjectVO?>? designObjectList = [];
  List<dynamic>? designs = [];
  List<dynamic>? genders = [];
  List<dynamic>? fabrics = [];
  List<dynamic>? colors = [];
  List<dynamic>? sizes = [];
  List<dynamic>? firstColors = [];
  List<ColorForFamilyArrowVO?>? colorObjectList = [];
  List<ItemVO?>? itemDemoList = [];
  ItemVO? itemDemoVO;
  bool isChecked = false;
  bool isApiLoad = false;
  bool showFirstColor = true;

  /// to filter by login user
  String? userId;

  /// selected Values
  String? selectedDesign;
  String? selectedGender;
  String? selectedFabric;
  String? selectedFirstColor;
  String? selectedColor;
  String? selectedSize;
  String? quantity;
  String? price;
  String? description;
  String? photoUrl;
  File? file;
  List<PreOrderItemVO?>? preOrderList;
  List<CustomPreOrderItemVO?>? customPreOrderList;

  List<CountingUnitIdVO?>? countingUnitList = [];
  List<CountingUnitIdVO?>? countingUnitsByGender = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderAndFabric = [];
  List<CountingUnitIdVO?>? countingUnitsByGenderFabricAndColor = [];
  List<CountingUnitIdVO?>? selectedCountingUnits = [];
  CountingUnitIdVO? selectedCountingUnit;

  /// to change selected item color
  bool isSelectedDesign = false;
  bool isSelectedGender = false;
  bool isSelectedFabric = false;
  bool isSelectedFirstColor = false;
  bool isSelectedColor = false;
  bool isSelectedSize = false;

  /// to change selected item color
  int selectedDesignIndex = -1;
  int selectedGenderIndex = -1;
  int selectedFabricIndex = -1;
  int selectedFirstColorIndex = -1;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;

  /// to restrict next steps
  bool isCompleteData = false;
  bool isAllowNextButton = false;

  bool autoFocusPrice = false;
  bool autoFocusQuantity = false;
  bool autoFocusDescription = false;

  PreOrderSpecificationPageBloc(
      List<DesignObjectVO?>? designList, List<ItemVO?>? itemDemos) {
    _showLoading();

    model.getUserInfoString(USER_ID).then((userId) {
      this.userId = userId;
      _notifySafely();

      model.getAllPreOrdersStream().listen((event) {
        preOrderList =
            event?.where((element) => element?.userId == userId).toList();
        _notifySafely();
        _allowNextButton();
      });
      model.getAllCustomPreOrdersStream().listen((event) {
        customPreOrderList =
            event?.where((element) => element?.userId == userId).toList();
        itemDemoList = itemDemos;
        designObjectList = designList;
        designs = designList?.map((e) => e?.designName).toList();
        _notifySafely();
        _allowNextButton();
        _hideLoading();
      });
    });
  }

  void onChooseDesign(String? design) {
    selectedDesign = design;
    isSelectedDesign = true;
    isSelectedGender = false;
    isSelectedFabric = false;
    isSelectedFirstColor = false;
    isSelectedColor = false;
    isSelectedSize = false;
    genders = [];
    _notifySafely();

    /// reset

    List<ItemVO?>? testList = itemDemoList
        ?.where((element) => element?.itemName == selectedDesign)
        .toList();
    if (testList != null && testList.isNotEmpty) {
      testList.take(1);
      itemDemoVO = testList.elementAt(0);
      photoUrl = itemDemoVO?.photoPath;
      isApiLoad = true;
      _notifySafely();
      model.getItemById(itemDemoVO?.id?.toString() ?? "").then((response) {
        countingUnitList = response.countingUnitAll;
        genders = countingUnitList
            ?.map((e) => e?.genderName)
            .toList()
            .toSet()
            .toList();
        isApiLoad = false;
        _notifySafely();
      });
    } else {
      photoUrl = null;
      _notifySafely();
    }

    /// reset
    fabrics = [];
    firstColors = [];
    colors = [];
    sizes = [];

    /// reset
    selectedGender = null;
    selectedFabric = null;
    selectedFirstColor = null;
    selectedColor = null;
    selectedSize = null;

    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChooseGender(String? gender) {
    selectedGender = gender;
    isSelectedGender = true;
    isSelectedFabric = false;
    isSelectedFirstColor = false;
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
    firstColors = [];
    colors = [];
    sizes = [];

    /// reset
    selectedFabric = null;
    selectedFirstColor = null;
    selectedColor = null;
    selectedSize = null;

    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChooseFabric(String? fabric) {
    selectedFabric = fabric;
    isSelectedFabric = true;
    _notifySafely();
    if (selectedFabric == "familyarrow") {
      showFirstColor = true;
      _notifySafely();
      onChooseFabricNew();
    } else {
      showFirstColor = false;
      _notifySafely();
      onChooseFabricNew();
      onChooseFirstColor("");
    }
  }

  void onChooseFabricNew() {
    isSelectedFirstColor = false;
    isSelectedColor = false;
    isSelectedSize = false;
    firstColors = [];
    isApiLoad = true;
    _notifySafely();
    model.getColorsForFamilyArrow("$selectedFabric/1").then((value) {
      colorObjectList = value.colorObjects;
      firstColors = colorObjectList
          ?.map(
            (e) => e?.colorDescription
                ?.toLowerCase()
                .replaceAll(" ", "")
                .replaceAll("-", ""),
          )
          .toList()
          .toSet()
          .toList();
      isApiLoad = false;
      _notifySafely();
    });

    /// reset
    colors = [];
    sizes = [];

    /// reset
    selectedFirstColor = null;
    selectedColor = null;
    selectedSize = null;
    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;
    _notifySafely();
    _allowAddButton();
  }

  void onChooseFirstColor(String? firstColor) {
    selectedFirstColor = firstColor;
    isSelectedFirstColor = true;
    isSelectedColor = false;
    isSelectedSize = false;
    colors = [];
    _notifySafely();
    countingUnitsByGenderAndFabric = countingUnitsByGender
        ?.where((element) => element?.fabricName == selectedFabric)
        .toList();
    isApiLoad = true;
    _notifySafely();
    if (selectedFabric == "familyarrow") {
      List<ColorForFamilyArrowVO?>? list = colorObjectList
          ?.where((element) =>
              element?.colorDescription
                  ?.toLowerCase()
                  .replaceAll(" ", "")
                  .replaceAll("-", "") ==
              selectedFirstColor)
          .toList();

      colors = list
          ?.map(
            (e) => e?.colorName
                ?.toLowerCase()
                .replaceAll(" ", "")
                .replaceAll("-", ""),
          )
          .toList();
      isApiLoad = false;
      _notifySafely();
    } else {
      colors = countingUnitsByGenderAndFabric
          ?.map(
            (e) => e?.colorName
                ?.toLowerCase()
                .replaceAll(" ", "")
                .replaceAll("-", ""),
          )
          .toList()
          .toSet()
          .toList();
      isApiLoad = false;
      _notifySafely();
    }

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

    var maleSizeList = [
      "xsm",
      "smm",
      "mem",
      "lgm",
      "xlm",
      "xxlm",
      "xxxlm",
      "xxxxlm"
    ];
    var femaleSizeList = [
      "xsf",
      "smf",
      "mef",
      "lgf",
      "xlf",
      "xxlf",
      "xxxlf",
      "xxxxlf"
    ];
    if (selectedFabric == "familyarrow") {
      if (selectedGender == "f") {
        sizes = femaleSizeList;
        _notifySafely();
      } else if (selectedGender == "m") {
        sizes = maleSizeList;
        _notifySafely();
      } else {
        sizes = countingUnitsByGenderFabricAndColor
            ?.map((e) => e?.sizeName)
            .toList()
            .toSet()
            .toList();
        _notifySafely();
      }
    } else {
      sizes = countingUnitsByGenderFabricAndColor
          ?.map((e) => e?.sizeName)
          .toList()
          .toSet()
          .toList();
      _notifySafely();
    }

    /// reset
    selectedSize = null;

    selectedCountingUnits = null;
    selectedCountingUnit = null;
    price = null;

    _notifySafely();
    _allowAddButton();
  }

  void onChecked(bool value) {
    isChecked = value;
    _notifySafely();
    _allowNextButton();
  }

  void onChooseSize(String? size) {
    selectedSize = size;
    isSelectedSize = true;
    var list = designObjectList
        ?.where((element) => element?.designName == selectedDesign)
        .toList();
    list?.take(1);
    var designObj = list?.elementAt(0);
    _notifySafely();
    if (size == "xsm" ||
        size == "smm" ||
        size == "mem" ||
        size == "xsf" ||
        size == "smf" ||
        size == "mef" && designObj?.normalSizePrice != null) {
      price = designObj?.normalSizePrice.toString();
      _notifySafely();
    } else if (size == "lgm" ||
        size == "xlm" ||
        size == "xxlm" ||
        size == "xxxlm" ||
        size == "xxxxlm" ||
        size == "lgf" ||
        size == "xlf" ||
        size == "xxlf" ||
        size == "xxxlf" ||
        size == "xxxxlf" && designObj?.plusSizePrice != null) {
      price = designObj?.plusSizePrice.toString();
      _notifySafely();
    } else {
      price = "0";
      _notifySafely();
    }
    _allowAddButton();
    // selectedCountingUnits = countingUnitList
    //     ?.where((element) =>
    // element?.genderName == selectedGender &&
    //     element?.fabricName == selectedFabric &&
    //     element?.colorName == selectedColor &&
    //     element?.sizeName == selectedSize)
    //     .toList();
    // selectedCountingUnits?.take(1);
    // selectedCountingUnit = selectedCountingUnits?.elementAt(0);
    // price = selectedCountingUnit?.orderPrice?.toString();
    // _notifySafely();
  }

  void onChangeQuantity(String? quantity) {
    int q = int.parse(quantity ?? "");
    if (q >= 30) {
      this.quantity = quantity;
      _notifySafely();
      _allowAddButton();
    }
  }

  void onChangePrice(String? price) {
    this.price = price;
    _notifySafely();
    _allowAddButton();
  }

  void onChangeDescription(String? description) {
    this.description = description;
    _notifySafely();
    _allowAddButton();
  }

  void onChosenFile(File? file) {
    this.file = file;
    _notifySafely();
    _allowAddButton();
  }

  void onTapDesign(int index) {
    selectedDesignIndex = index;
    _notifySafely();
  }

  void onTapGender(int index) {
    selectedGenderIndex = index;
    _notifySafely();
  }

  void onTapFabric(int index) {
    selectedFabricIndex = index;
    _notifySafely();
  }

  void onTapFirstColor(int index) {
    selectedFirstColorIndex = index;
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

  void _allowNextButton() {
    if (isChecked == false) {
      if (preOrderList != null && preOrderList!.isNotEmpty) {
        isAllowNextButton = true;
        _notifySafely();
      } else {
        isAllowNextButton = false;
        _notifySafely();
      }
    } else {
      if (customPreOrderList != null && customPreOrderList!.isNotEmpty) {
        isAllowNextButton = true;
        _notifySafely();
      } else {
        isAllowNextButton = false;
        _notifySafely();
      }
    }
  }

  void _allowAddButton() {
    if (isChecked == false) {
      if (selectedFabric != null &&
          selectedDesign != null &&
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
    } else {
      if (description != null &&
          file != null &&
          quantity != null &&
          price != null) {
        isCompleteData = true;
        _notifySafely();
      } else {
        isCompleteData = false;
        _notifySafely();
      }
    }
  }

  void onTapAddButton() {
    if (isChecked == false) {
      _onTapAddNotCustom();
    } else {
      _onTapAddCustom();
    }
  }

  void _onTapAddCustom() async {
    var intPrice = int.parse(price ?? "");
    var intQuantity = int.parse(quantity ?? "");
    var total = intPrice * intQuantity;
    var timeStamp = DateTime.now().millisecond.toString();
    final bytes = await file?.readAsBytes();
    var customItem = CustomPreOrderItemVO(
      orderId: timeStamp,
      timeStamp: timeStamp,
      attach: bytes,
      quantity: quantity,
      price: price,
      totalAmount: total.toString(),
      description: description,
      totalQuantity: quantity,
      userId: userId,
    );
    _saveCustomItem(customItem).then((value) {
      model.getAllCustomPreOrdersStream().listen((event) {
        customPreOrderList =
            event?.where((element) => element?.userId == userId).toList();
        _notifySafely();
        _allowNextButton();
      });
    });
  }

  void _onTapAddNotCustom() {
    var intPrice = int.parse(price ?? "");
    var intQuantity = int.parse(quantity ?? "");
    var total = intPrice * intQuantity;
    var preOrderItem = PreOrderItemVO(
      orderId: DateTime.now().millisecond.toString(),
      itemName:
          "$selectedDesign $selectedGender $selectedFabric $selectedColor $selectedSize",
      quantity: quantity,
      price: price,
      total: total.toString(),
      isBrand: true,
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
    _allowNextButton();
    return Future.value();
  }

  Future _saveCustomItem(CustomPreOrderItemVO customPreOrderItem) {
    model.saveCustomPreOrderItem(customPreOrderItem);
    _allowNextButton();
    return Future.value();
  }

  void onTapDeleteIcon(String? itemName) {
    model.deletePreOrderItem(itemName);
    _allowNextButton();
  }

  void onTapDeleteIconCustom(String? timeStamp) {
    model.deleteCustomPreOrderItem(timeStamp);
    _allowNextButton();
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
