// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/product_line_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/item_detail_new_version_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class ProductLineNewVersionPage extends StatelessWidget {
  bool comeFromHomePage;
  String? searchItem;
  ProductLineNewVersionPage({
    Key? key,
    this.comeFromHomePage = false,
    this.searchItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductLinePageBloc(searchItem),
      child: Consumer<ProductLinePageBloc>(builder: (context, bloc, child) {
        var tabs = bloc.brandList
            ?.map((e) => tabForBrandList(e?.categoryName ?? ""))
            .toList();
        var brands = bloc.brandList?.map((e) => e?.id ?? 0).toList();
        List<dynamic>? subList =
            bloc.subcategoryList?.map((e) => e?.name).toList();
        List<dynamic>? products = ["All"];
        products.addAll(subList ?? []);

        List<int?>? productIdList = [-1];
        List<int?>? originalIdList =
            bloc.subcategoryList?.map((e) => e?.id).toList();
        productIdList.addAll(originalIdList ?? []);

        return DefaultTabController(
          length: bloc.brandList?.length ?? 0,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: APP_THEME_COLOR,
              elevation: 5,
              leading: Visibility(
                visible: comeFromHomePage,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: FONT_XLARGE,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                "Product Line",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FONT_LARGE - 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleWidth(context) / 30,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: scaleWidth(context) / 30),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: scaleWidth(context) / 40),
                          child: TitleAndSeeMoreView(
                            title: "Brands",
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 60),
                        TabListForBrandList(
                          tabs: tabs,
                          categoryIds: brands ?? [],
                          onTab: (categoryId) {
                            bloc.onTapCategory(categoryId.toString());
                          },
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 1),
                                spreadRadius: 10,
                                blurRadius: 10,
                                blurStyle: BlurStyle.outer,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scaleWidth(context) / 40),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleWidth(context) / 40,
                                ),
                                child: TitleAndSeeMoreView(
                                  title: "Products",
                                  //textDecoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(height: scaleWidth(context) / 20),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleWidth(context) / 40,
                                ),
                                child: ItemPropertyListView(
                                  properties: products,
                                  onTapProperty: (product) {},
                                  onTap: (index) {
                                    bloc.onTapSubCategory(
                                        "${productIdList[index] ?? 0}", index);
                                  },
                                  isSelectedSomething: true,
                                  selectedIndex: bloc.selectedProductIndex,
                                ),
                              ),
                              SizedBox(height: scaleWidth(context) / 16),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleWidth(context) / 40,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Items",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: FONT_LARGE - 5,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: scaleWidth(context) / 10,
                                      width: scaleWidth(context) / 2.3,
                                      child: SearchTextFieldView(
                                        hintText: bloc.hintText ?? SEARCH_TEXT,
                                        readOnly: false,
                                        onSearchDone: (text) {
                                          bloc.onSearchItem(text);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: scaleWidth(context) / 20),
                              (bloc.isLoading)
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: scaleWidth(context) / 2.5),
                                      child: const LoadingView(),
                                    )
                                  : const ItemListGridView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ItemListGridView extends StatelessWidget {
  const ItemListGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductLinePageBloc>(
      builder: (context, bloc, child) => GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bloc.itemList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: scaleWidth(context) / 1.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ItemDetailView(
            height: scaleWidth(context) / 2.5,
            width: scaleWidth(context) / 2.5,
            itemName: bloc.itemList?[index]?.itemName ?? "error",
            itemImage:
                "$ITEM_IMAGE_BASE_URL${bloc.itemList?[index]?.photoPath ?? ""}",
            onTap: () {
              navigateToScreen(
                  context,
                  ItemDetailNewVersionPage(
                    itemId: bloc.itemList?[index]?.id?.toString(),
                  ));
            },
          );
        },
      ),
    );
  }
}

class CommonAppButton extends StatelessWidget {
  String text;
  Function onTap;
  Color buttonColor;
  Color textColor;
  double textFont;
  CommonAppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.buttonColor = APP_THEME_COLOR,
    this.textColor = Colors.white,
    this.textFont = FONT_LARGE - 6,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: textFont,
        ),
      ),
    );
  }
}

class TabListForBrandList extends StatelessWidget {
  TabListForBrandList({
    super.key,
    required this.tabs,
    required this.onTab,
    required this.categoryIds,
  });

  List<Widget>? tabs;
  Function(int categoryId) onTab;
  List<int> categoryIds;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (tabIndex) {
        onTab(categoryIds[tabIndex]);
      },
      isScrollable: true,
      indicatorWeight: 3,
      labelStyle: const TextStyle(
        fontSize: FONT_LARGE - 6,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: FONT_LARGE - 8,
      ),
      labelColor: APP_THEME_COLOR,
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: tabs ?? [],
    );
  }
}

Widget tabForBrandList(String text) {
  return Tab(text: text);
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.search,
            color: Colors.black54,
            size: FONT_LARGE,
          ),
          Text(
            "Search",
            style: TextStyle(
              color: Colors.black54,
              fontSize: FONT_LARGE - 4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
