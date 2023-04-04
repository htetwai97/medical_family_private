// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/pre_order_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/vo_models/pre_order_vo.dart';
import 'package:medical_family_app/pages/pre_order_specification_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/utils/dummy/pre_order_dummy_data.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class PreOrderPage extends StatelessWidget {
  PreOrderDummyData preOrderDummyData = PreOrderDummyData();

  PreOrderPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PreOrderBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: APP_THEME_COLOR,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Pre Order",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: FONT_LARGE,
            ),
          ),
        ),
        body: Selector<PreOrderBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleWidth(context) / 20,
                      vertical: scaleWidth(context) / 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PreOrderTextView(
                          text: "Available Preorder Brands",
                          fontSize: FONT_LARGE - 4,
                          textColor: Colors.black87,
                        ),
                        SizedBox(height: scaleWidth(context) / 40),
                        PreOrderTextView(
                          text:
                              "If you want to make preorder,choose one of the following brands.",
                          fontSize: FONT_LARGE - 6,
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<PreOrderBloc>(
                          builder: (context, bloc, child) => ListView.separated(
                            itemBuilder: (context, index) =>
                                PreOrderBrandItemDetailView(
                              index: index,
                              preOrderDummyData: preOrderDummyData,
                              onTapMakeOrder: (preOrderItem) {
                                navigateToScreen(
                                  context,
                                  PreOrderSpecificationPage(
                                    brand: preOrderItem,
                                    itemDemos: bloc.itemDemos,
                                    designList: (preOrderItem.id == 1)
                                        ? designListOne
                                        : (preOrderItem.id == 2)
                                            ? designListTwo
                                            : designListThree,
                                  ),
                                );
                              },
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: scaleWidth(context) / 20,
                            ),
                            itemCount:
                                preOrderDummyData.preOrderBrandList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreOrderBrandItemDetailView extends StatelessWidget {
  PreOrderBrandItemDetailView({
    super.key,
    required this.preOrderDummyData,
    required this.index,
    required this.onTapMakeOrder,
  });
  PreOrderDummyData preOrderDummyData;
  int index;
  Function(PreOrderVO) onTapMakeOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(context) / 30,
        vertical: scaleWidth(context) / 30,
      ),
      decoration: BoxDecoration(
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
      child: Column(
        children: [
          Container(
            height: scaleWidth(context) / 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                    preOrderDummyData.preOrderBrandList[index].url ?? ""),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  PreOrderTextView(
                    text: "Price Range",
                    fontSize: FONT_MEDIUM,
                  ),
                  SizedBox(height: scaleWidth(context) / 60),
                  PreOrderTextView(
                    text:
                        preOrderDummyData.preOrderBrandList[index].priceRange ??
                            "",
                    fontSize: FONT_MEDIUM,
                  ),
                ],
              ),
              const Spacer(),
              CommonAppButton(
                textColor: Colors.white,
                buttonColor: Colors.black54,
                text: "Make order",
                onTap: () {
                  onTapMakeOrder(preOrderDummyData.preOrderBrandList[index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreOrderTextView extends StatelessWidget {
  String text;
  double fontSize;
  Color textColor;
  PreOrderTextView({
    super.key,
    required this.text,
    required this.fontSize,
    this.textColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ),
    );
  }
}
