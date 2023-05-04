// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/pre_order_specification_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/design_object_vo.dart';
import 'package:medical_family_app/data/vo_models/item_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/item_detail_new_version_page.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:medical_family_app/pages/order_detail_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/user_info_for_preorder_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class PreOrderSpecificationPage extends StatelessWidget {
  PreOrderVO? brand;
  List<DesignObjectVO?>? designList;
  List<ItemVO?>? itemDemos;
  PreOrderSpecificationPage({
    Key? key,
    required this.designList,
    required this.itemDemos,
    required this.brand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PreOrderSpecificationPageBloc(designList, itemDemos),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: APP_THEME_COLOR,
          elevation: 5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: FONT_XLARGE,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Brand Preorder specification",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<PreOrderSpecificationPageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: scaleWidth(context) / 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: scaleWidth(context) / 18),
                        BrandAndPriceRangeForSpecifiedView(
                          brand: brand?.id == 1
                              ? "Family Uniform"
                              : brand?.id == 2
                                  ? "Branded"
                                  : "Eco Family",
                          priceRange: "Price Range : ${brand?.priceRange}",
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                        const OtherSectionToChooseItemView(),
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<PreOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) => Visibility(
                            visible: bloc.isChecked == false,
                            child: const OriginalChooseSectionView(),
                          ),
                        ),
                        Consumer<PreOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) => Visibility(
                            visible: bloc.isChecked,
                            child: PickFileForCustomDesignView(
                              autoFocusDescription: (bloc.autoFocusDescription),
                              fileName: bloc.file?.path.split("/").last,
                              onTapChooseFile: () async {
                                var result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                  allowMultiple: false,
                                );
                                var platFormFile = result?.files.first;
                                if (platFormFile != null) {
                                  bloc.onChosenFile(
                                      File(platFormFile.path ?? ""));
                                }
                              },
                              onChangeDescription: (description) {
                                bloc.onChangeDescription(description);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<PreOrderSpecificationPageBloc>(
                            builder: (context, bloc, child) {
                          return QuantityPriceAddButtonRowView(
                            autoFocusPrice: bloc.autoFocusPrice,
                            autoFocusQuantity: bloc.autoFocusQuantity,
                            isCustom: bloc.isChecked,
                            predefinedText: bloc.price,
                            onChangedQuantity: (quantity) {
                              bloc.onChangeQuantity(quantity);
                            },
                            onChangedPrice: (price) {
                              bloc.onChangePrice(price);
                            },
                            onSubmittedQuantity: (quantity) {},
                            onTapAdd: () {
                              if (bloc.isCompleteData) {
                                showSnackBarWithMessage(
                                    context, "One order Added", true);
                                bloc.onTapAddButton();
                              } else {
                                showSnackBarWithMessage(
                                    context, "Choosing is not complete", false);
                              }
                            },
                          );
                        }),
                        SizedBox(
                          height: scaleWidth(context) / 10,
                          child: Center(
                            child: Container(
                              height: 0.5,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        TitleAndSeeMoreView(title: "Your preorder list"),
                        Consumer<PreOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              (bloc.isChecked == false)
                                  ? PreOrderListBeforeCheckOutView(
                                      onTapDelete: (index) {
                                        bloc.onTapDeleteIcon(bloc
                                                .preOrderList?[index]
                                                ?.itemName ??
                                            "");
                                      },
                                      preOrderList: bloc.preOrderList,
                                    )
                                  : CustomItemListView(
                                      onTapDelete: (index) {
                                        bloc.onTapDeleteIconCustom(bloc
                                                .customPreOrderList?[index]
                                                ?.timeStamp ??
                                            "");
                                      },
                                      customList: bloc.customPreOrderList,
                                    ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Consumer<PreOrderSpecificationPageBloc>(
                            builder: (context, bloc, child) => CommonAppButton(
                              buttonColor: (bloc.isAllowNextButton)
                                  ? APP_THEME_COLOR
                                  : Colors.grey,
                              text: "Next",
                              textFont: FONT_LARGE - 4,
                              onTap: () {
                                if (bloc.isAllowNextButton) {
                                  navigateToScreen(
                                      context,
                                      UserInfoForPreOrderPage(
                                          isCustom: bloc.isChecked));
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Consumer<PreOrderSpecificationPageBloc>(
                builder: (context, bloc, child) => Visibility(
                  visible: bloc.isApiLoad,
                  child: Container(
                    color: Colors.black12,
                    child: const Center(
                      child: LoadingView(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOrderItemDetailView extends StatelessWidget {
  CustomPreOrderItemVO? customPreOrderItem;
  Function onTapDelete;
  CustomOrderItemDetailView({
    Key? key,
    required this.customPreOrderItem,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                spreadRadius: 5,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: scaleWidth(context) / 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: scaleWidth(context) / 3,
                    width: scaleWidth(context) / 3,
                    child: FadeInImage(
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, obj, st) {
                        return errorImage();
                      },
                      placeholder: const AssetImage(
                          "assets/images/place_holder_asset.jpg"),
                      image: MemoryImage(customPreOrderItem!.attach!),
                    ),
                  ),
                  SizedBox(width: scaleWidth(context) / 10),
                  CartTextTwoColumnView(
                    name: "",
                    id: "Description - ${customPreOrderItem?.description}",
                    color: "Quantity - ${customPreOrderItem?.quantity}",
                    fabric: "Price - ${customPreOrderItem?.price}",
                    size: "Total - ${customPreOrderItem?.totalAmount}",
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapDelete();
          },
          child: const RemoveIconView(),
        ),
      ],
    );
  }
}

class OriginalChooseSectionView extends StatelessWidget {
  const OriginalChooseSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndSeeMoreView(
          title: "Design",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => ItemPropertyListView(
            onTap: (index) {
              bloc.onTapDesign(index);
            },
            properties: bloc.designs ?? [],
            isSelectedSomething: bloc.isSelectedDesign,
            warning: "This item is not Available",
            selectedIndex: bloc.selectedDesignIndex,
            onTapProperty: (design) {
              bloc.onChooseDesign(design);
            },
          ),
        ),
        SizedBox(height: scaleWidth(context) / 20),
        const DesignImageView(),
        TitleAndSeeMoreView(
          title: "Gender",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => ItemPropertyListView(
            onTap: (index) {
              bloc.onTapGender(index);
            },
            properties: bloc.genders ?? [],
            isSelectedSomething: bloc.isSelectedGender,
            warning: "Design is required to choose",
            selectedIndex: bloc.selectedGenderIndex,
            onTapProperty: (gender) {
              bloc.onChooseGender(gender);
            },
          ),
        ),
        SizedBox(height: scaleWidth(context) / 20),
        TitleAndSeeMoreView(
          title: "Fabric",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => ItemPropertyListView(
            onTap: (index) {
              bloc.onTapFabric(index);
            },
            properties: bloc.fabrics ?? [],
            isSelectedSomething: bloc.isSelectedFabric,
            warning: "Gender is required to choose",
            selectedIndex: bloc.selectedFabricIndex,
            onTapProperty: (fabric) {
              bloc.onChooseFabric(fabric);
            },
          ),
        ),
        SizedBox(height: scaleWidth(context) / 20),
        TitleAndSeeMoreView(
          title: "Color",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => Visibility(
            visible: bloc.showFirstColor,
            child: ItemPropertyListView(
              onTap: (index) {
                bloc.onTapFirstColor(index);
              },
              isVisibleCircle: false,
              properties: bloc.firstColors ?? [],
              isSelectedSomething: bloc.isSelectedFirstColor,
              warning: "Fabric is required to choose",
              selectedIndex: bloc.selectedFirstColorIndex,
              onTapProperty: (firstColor) {
                bloc.onChooseFirstColor(firstColor);
              },
            ),
          ),
        ),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => Visibility(
            visible: bloc.showFirstColor,
            child: SizedBox(height: scaleWidth(context) / 20),
          ),
        ),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => ItemPropertyListView(
            onTap: (index) {
              bloc.onTapColor(index);
            },
            isVisibleCircle: true,
            properties: bloc.colors ?? [],
            isSelectedSomething: bloc.isSelectedColor,
            warning: "Fabric is required to choose",
            selectedIndex: bloc.selectedColorIndex,
            onTapProperty: (color) {
              bloc.onChooseColor(color);
            },
          ),
        ),
        SizedBox(height: scaleWidth(context) / 20),
        TitleAndSeeMoreView(
          title: "Size",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Consumer<PreOrderSpecificationPageBloc>(
          builder: (context, bloc, child) => ItemPropertyListView(
            onTap: (index) {
              bloc.onTapSize(index);
            },
            properties: bloc.sizes ?? [],
            isSelectedSomething: bloc.isSelectedSize,
            warning: "Color is required to choose",
            selectedIndex: bloc.selectedSizeIndex,
            onTapProperty: (size) {
              bloc.onChooseSize(size);
            },
          ),
        ),
      ],
    );
  }
}

class DesignImageView extends StatelessWidget {
  const DesignImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreOrderSpecificationPageBloc>(
      builder: (context, bloc, child) => Align(
        alignment: Alignment.center,
        child: Visibility(
          visible: bloc.photoUrl != null,
          child: Container(
            margin: EdgeInsets.only(bottom: scaleWidth(context) / 20),
            height: scaleWidth(context) / 2.8,
            width: scaleWidth(context) / 2.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, obj, st) {
                    return errorImage();
                  },
                  placeholder:
                      const AssetImage("assets/images/place_holder_asset.jpg"),
                  image: NetworkImage("$ITEM_IMAGE_BASE_URL${bloc.photoUrl}")),
            ),
          ),
        ),
      ),
    );
  }
}

class OtherSectionToChooseItemView extends StatelessWidget {
  const OtherSectionToChooseItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreOrderSpecificationPageBloc>(
      builder: (context, bloc, child) => Row(
        children: [
          const Text(
            "Choose item that you want",
            style: TextStyle(
              color: Colors.black,
              fontSize: FONT_LARGE - 4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Checkbox(
            activeColor: APP_THEME_COLOR,
            value: bloc.isChecked,
            onChanged: (value) {
              bloc.onChecked(value ?? false);
            },
          ),
        ],
      ),
    );
  }
}

class PickFileForCustomDesignView extends StatelessWidget {
  Function onTapChooseFile;
  String? fileName;
  Function(String) onChangeDescription;
  bool autoFocusDescription;
  PickFileForCustomDesignView({
    super.key,
    required this.onTapChooseFile,
    required this.fileName,
    required this.onChangeDescription,
    required this.autoFocusDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "If you already know what you want,let us know with your file",
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Row(
          children: [
            CommonAppButton(
              text: "Choose File",
              onTap: () {
                onTapChooseFile();
              },
              buttonColor: Colors.black54,
              textColor: Colors.white,
              textFont: 12,
            ),
            SizedBox(
              width: scaleWidth(context) / 20,
            ),
            Text(fileName ?? "No chosen file"),
          ],
        ),
        SizedBox(height: scaleWidth(context) / 20),
        QuantityAndPriceTextFieldView(
          isAutoFocus: autoFocusDescription,
          onChanged: (description) {
            onChangeDescription(description);
          },
          onSubmitted: (text) {},
          hintText: "Description",
          width: 1.5,
          isDense: false,
        ),
      ],
    );
  }
}

class PreOrderListBeforeCheckOutView extends StatelessWidget {
  List<PreOrderItemVO?>? preOrderList;
  Function(int) onTapDelete;
  PreOrderListBeforeCheckOutView({
    super.key,
    this.preOrderList,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: scaleWidth(context) / 20),
      itemBuilder: (context, index) => Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: scaleWidth(context) / 30,
              vertical: scaleWidth(context) / 30,
            ),
            child: Column(
              children: [
                DetailVoucherRowView(
                  value: preOrderList?[index]?.itemName ?? "",
                  title: "Item name",
                ),
                DetailVoucherRowView(
                  value: preOrderList?[index]?.quantity ?? "",
                  title: "Quantity",
                  // rowColor: const Color.fromRGBO(245, 245, 245, 1),
                ),
                DetailVoucherRowView(
                  value: preOrderList?[index]?.price ?? "",
                  title: "Price",
                ),
                DetailVoucherRowView(
                  value: preOrderList?[index]?.total ?? "",
                  title: "Total",
                  // rowColor: const Color.fromRGBO(245, 245, 245, 1),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapDelete(index);
            },
            child: const RemoveIconView(),
          ),
        ],
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: scaleWidth(context) / 20,
      ),
      itemCount: preOrderList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
    );
  }
}

class CustomItemListView extends StatelessWidget {
  List<CustomPreOrderItemVO?>? customList;
  Function(int) onTapDelete;
  CustomItemListView({
    Key? key,
    required this.customList,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: scaleWidth(context) / 20),
      itemBuilder: (context, index) => CustomOrderItemDetailView(
          customPreOrderItem: customList?[index],
          onTapDelete: () {
            onTapDelete(index);
          }),
      separatorBuilder: (context, index) => SizedBox(
        height: scaleWidth(context) / 20,
      ),
      itemCount: customList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
    );
  }
}

class QuantityPriceAddButtonRowView extends StatelessWidget {
  Function(String?) onChangedQuantity;
  Function(String?) onChangedPrice;
  Function(String?) onSubmittedQuantity;
  Function onTapAdd;
  String? predefinedText;
  bool isCustom;
  bool autoFocusQuantity;
  bool autoFocusPrice;
  QuantityPriceAddButtonRowView({
    super.key,
    required this.onChangedQuantity,
    required this.onChangedPrice,
    required this.onTapAdd,
    this.predefinedText,
    required this.isCustom,
    required this.autoFocusPrice,
    required this.autoFocusQuantity,
    required this.onSubmittedQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QuantityAndPriceTextFieldView(
          isAutoFocus: autoFocusQuantity,
          hintText: "Quantity",
          onChanged: (quantity) {
            onChangedQuantity(quantity);
          },
          onSubmitted: (quantity) {
            onSubmittedQuantity(quantity);
          },
        ),
        const Spacer(),
        (isCustom)
            ? QuantityAndPriceTextFieldView(
                isAutoFocus: autoFocusPrice,
                hintText: "Price",
                onChanged: (price) {
                  onChangedPrice(price);
                },
                onSubmitted: (text) {},
              )
            : Container(
                height: scaleWidth(context) / 12,
                width: scaleWidth(context) / 4,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    predefinedText ?? "Price",
                    style: TextStyle(
                      color: (predefinedText != null)
                          ? Colors.black
                          : Colors.black38,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
        const Spacer(),
        CommonAppButton(
          text: "Add",
          onTap: () {
            onTapAdd();
          },
        ),
      ],
    );
  }
}

class QuantityAndPriceTextFieldView extends StatefulWidget {
  Function(String) onChanged;
  Function(String) onSubmitted;
  double width;
  String hintText;
  bool isDense;
  String? predefinedText;
  bool readOnly;
  bool isAutoFocus;
  QuantityAndPriceTextFieldView({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.width = 4,
    this.isDense = true,
    this.predefinedText,
    this.readOnly = false,
    required this.isAutoFocus,
    required this.onSubmitted,
  });

  @override
  State<QuantityAndPriceTextFieldView> createState() =>
      _QuantityAndPriceTextFieldViewState();
}

class _QuantityAndPriceTextFieldViewState
    extends State<QuantityAndPriceTextFieldView> {
  var myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      myController.text = widget.predefinedText ?? "";
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scaleWidth(context) / widget.width,
      color: Colors.white,
      child: TextField(
        autofocus: widget.isAutoFocus,
        readOnly: widget.readOnly,
        controller: myController,
        onChanged: (text) {
          widget.onChanged(text);
        },
        onSubmitted: (text) {
          setState(() {
            widget.onSubmitted(text);
          });
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          isDense: widget.isDense,
          contentPadding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 40,
            vertical: scaleWidth(context) / 60,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: FONT_MEDIUM,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class BrandAndPriceRangeForSpecifiedView extends StatelessWidget {
  String brand;
  String priceRange;
  BrandAndPriceRangeForSpecifiedView({
    super.key,
    required this.brand,
    required this.priceRange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          brand,
          style: const TextStyle(
            color: APP_THEME_COLOR,
            fontWeight: FontWeight.w500,
            fontSize: FONT_MEDIUM + 1,
          ),
        ),
        const Spacer(),
        Text(
          priceRange,
          style: const TextStyle(
            color: APP_THEME_COLOR,
            fontWeight: FontWeight.w500,
            fontSize: FONT_MEDIUM + 1,
          ),
        ),
      ],
    );
  }
}
