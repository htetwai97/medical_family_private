// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/instock_order_specification_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/data/vo_models/item_detail_vo.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/item_detail_new_version_page.dart';
import 'package:medical_family_app/pages/pre_order_specification_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/user_info_for_preorder_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class InStockOrderSpecificationPage extends StatelessWidget {
  ItemDetailVO? item;
  InStockOrderSpecificationPage({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InStockOrderSpecificationPageBloc(item!),
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
            "Item Preorder Specification",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<InStockOrderSpecificationPageBloc, bool>(
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
                        TitleAndSeeMoreView(
                          title: item?.itemName,
                          titleSize: FONT_LARGE - 2,
                          titleColor: APP_THEME_COLOR,
                        ),
                        SizedBox(height: scaleWidth(context) / 15),
                        TitleAndSeeMoreView(
                          title: "Gender",
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              ItemPropertyListView(
                            onTap: (index) {
                              bloc.onTapGender(index);
                            },
                            properties: bloc.genders ?? [],
                            isSelectedSomething: bloc.isSelectedGender,
                            warning: "This Item is not available",
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
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              ItemPropertyListView(
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
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              ItemPropertyListView(
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
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              ItemPropertyListView(
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
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              QuantityPriceAddButtonRowView(
                            autoFocusQuantity: bloc.focusQuantity,
                            autoFocusPrice: bloc.focusPrice,
                            isCustom: false,
                            predefinedText: bloc.price,
                            onChangedQuantity: (quantity) {
                              bloc.onChangeQuantity(quantity);
                            },
                            onChangedPrice: (price) {},
                            onSubmittedQuantity: (quantity) {
                              bloc.onSubmitQuantity(quantity);
                            },
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
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        TitleAndSeeMoreView(title: "Your preorder list"),
                        Consumer<InStockOrderSpecificationPageBloc>(
                          builder: (context, bloc, child) =>
                              PreOrderListBeforeCheckOutView(
                            onTapDelete: (index) {
                              bloc.onTapDeleteIcon(
                                  bloc.preOrderList?[index]?.itemName);
                            },
                            preOrderList: bloc.preOrderList,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Consumer<InStockOrderSpecificationPageBloc>(
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
                                        isCustom: false,
                                      ));
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
                child: SizedBox(
                  height: scaleWidth(context) * 1.5,
                  child: const Center(
                    child: CircularProgressIndicator(),
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

class ClickButtonFloatingActionView extends StatelessWidget {
  Function onTap;
  ClickButtonFloatingActionView({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: APP_THEME_COLOR,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          onTap();
        },
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
