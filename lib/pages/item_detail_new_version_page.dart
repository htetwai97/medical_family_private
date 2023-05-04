// ignore_for_file: must_be_immutable

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/item_detail_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/instock_order_specification_page.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class ItemDetailNewVersionPage extends StatelessWidget {
  String? itemId;
  ItemDetailNewVersionPage({Key? key, this.itemId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemDetailPageBloc(itemId ?? ""),
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
            "Item Detail",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Consumer<ItemDetailPageBloc>(
              builder: (context, bloc, child) => CartIconToNavigateCartPageView(
                iconColor: Colors.white,
                cartCount: bloc.cartList?.length.toString(),
              ),
            ),
          ],
        ),
        body: Selector<ItemDetailPageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BannerSectionForItemDetailView(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scaleWidth(context) / 14,
                          vertical: scaleWidth(context) / 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  NameAndInStockSectionView(
                                itemName: bloc.response?.item?.itemName,
                                stockCount: bloc
                                    .selectedCountingUnit?.currentQuantity
                                    ?.toString(),
                              ),
                            ),
                            SizedBox(height: scaleWidth(context) / 10),
                            TitleAndSeeMoreView(
                              title: "Gender",
                            ),
                            SizedBox(height: scaleWidth(context) / 20),
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  ItemPropertyListView(
                                onTap: (index) {
                                  bloc.onTapGender(index);
                                },
                                properties: bloc.genderList ?? [],
                                isSelectedSomething: bloc.isSelectedGender,
                                warning: "This item is not Available",
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
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  ItemPropertyListView(
                                onTap: (index) {
                                  bloc.onTapFabric(index);
                                },
                                selectedIndex: bloc.selectedFabricIndex,
                                properties: bloc.fabricList ?? [],
                                isSelectedSomething: bloc.isSelectedFabric,
                                warning: "Please choose the gender!",
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
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  ItemPropertyListView(
                                onTap: (index) {
                                  bloc.onTapColor(index);
                                },
                                isVisibleCircle: true,
                                selectedIndex: bloc.selectedColorIndex,
                                properties: bloc.colorList ?? [],
                                isSelectedSomething: bloc.isSelectedColor,
                                warning: "Please choose the fabric!",
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
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  ItemPropertyListView(
                                onTap: (index) {
                                  bloc.onTapSize(index);
                                },
                                selectedIndex: bloc.selectedSizeIndex,
                                properties: bloc.sizeList ?? [],
                                isSelectedSomething: bloc.isSelectedSize,
                                warning: "Please choose the Color!",
                                onTapProperty: (size) {
                                  bloc.onChooseSize(size);
                                },
                              ),
                            ),
                            SizedBox(height: scaleWidth(context) / 20),
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) =>
                                  (bloc.valueOfStock == 1)
                                      ? PriceAndAddToCartButtonView(
                                          price: bloc.selectedCountingUnit
                                              ?.purchasePrice
                                              ?.toString(),
                                          onTapAddToCart: () {
                                            if (bloc.isCompleteData == false) {
                                              showSnackBarWithMessage(
                                                  context,
                                                  "Choosing item detail is not complete.",
                                                  false);
                                            } else {
                                              if (bloc.isAddToCartAllowed ==
                                                  false) {
                                                showSnackBarWithMessage(
                                                    context,
                                                    "This item is out of stock.",
                                                    false);
                                              } else {
                                                bloc
                                                    .onTapAddToCart()
                                                    .then((value) =>
                                                        showSnackBarWithMessage(
                                                            context,
                                                            "One item added to Cart",
                                                            true))
                                                    .catchError((e) =>
                                                        showSnackBarWithMessage(
                                                            context,
                                                            "Add to Cart Fail by $e",
                                                            false));
                                              }
                                            }
                                          },
                                        )
                                      : const Text(
                                          "Instock mode not supported for this item.",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                            ),
                            SizedBox(
                              height: scaleWidth(context) / 10,
                              child: Center(
                                child: Container(
                                  color: Colors.black54,
                                  height: 0.4,
                                ),
                              ),
                            ),
                            Consumer<ItemDetailPageBloc>(
                              builder: (context, bloc, child) => Visibility(
                                visible: bloc.valueOfPreOrder == 1,
                                child: OrderTabSectionView(
                                  onTap: () {
                                    navigateToScreen(
                                        context,
                                        InStockOrderSpecificationPage(
                                            item: bloc.response?.item));
                                  },
                                ),
                              ),
                            ),
                            TitleAndSeeMoreView(title: "Related Items"),
                            SizedBox(height: scaleWidth(context) / 20),
                            const RelatedItemListView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartIconToNavigateCartPageView extends StatelessWidget {
  Color iconColor;
  String? cartCount;
  CartIconToNavigateCartPageView({
    super.key,
    this.iconColor = Colors.black,
    this.cartCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(context) / 30,
        vertical: scaleWidth(context) / 40,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 40),
            child: IconButton(
              onPressed: () {
                navigateToScreen(context, const MyCartPage());
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: FONT_XLARGE,
                color: iconColor,
              ),
            ),
          ),
          Container(
            height: scaleWidth(context) / 16,
            width: scaleWidth(context) / 16,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                cartCount ?? "0",
                style: const TextStyle(
                  color: APP_THEME_COLOR,
                  fontSize: FONT_SMALL + 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RelatedItemListView extends StatelessWidget {
  const RelatedItemListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemDetailPageBloc>(
      builder: (context, bloc, child) => SizedBox(
        height: scaleWidth(context) / 2.1,
        child: ListView.separated(
          itemBuilder: (context, index) => ItemDetailView(
            itemName: bloc.relatedItemList?[index]?.itemName ?? "",
            itemImage:
                "$ITEM_IMAGE_BASE_URL${bloc.relatedItemList?[index]?.photoPath}",
            onTap: () {
              navigateToScreen(
                context,
                ItemDetailNewVersionPage(
                  itemId: "${bloc.relatedItemList?[index]?.id}",
                ),
              );
            },
          ),
          separatorBuilder: (context, index) =>
              SizedBox(width: scaleWidth(context) / 20),
          itemCount: bloc.relatedItemList?.length ?? 1,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}

class OrderTabSectionView extends StatelessWidget {
  Function onTap;
  OrderTabSectionView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: const [
            Text("Minimum Order Quantity : "),
            Spacer(),
            Text("30"),
          ],
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Row(
          children: const [
            Text("Available Color : "),
            Spacer(),
            Text("green"),
          ],
        ),
        SizedBox(height: scaleWidth(context) / 20),
        Row(
          children: const [
            Text("Lead Time : "),
            Spacer(),
            Text("2 weeks"),
          ],
        ),
        SizedBox(height: scaleWidth(context) / 20),
        CommonAppButton(
          buttonColor: Colors.black87,
          text: "Make Order",
          onTap: () {
            onTap();
          },
        ),
        SizedBox(
          height: scaleWidth(context) / 10,
          child: Center(
            child: Container(
              color: Colors.black54,
              height: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}

class PriceAndAddToCartButtonView extends StatelessWidget {
  String? price;
  Function onTapAddToCart;
  PriceAndAddToCartButtonView({
    super.key,
    required this.price,
    required this.onTapAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Price - ${price ?? "calculating"} MMK",
          style: const TextStyle(
            color: Colors.black,
            fontSize: FONT_LARGE - 5,
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
        CommonAppButton(
          buttonColor: Colors.black87,
          text: "Add to Cart",
          onTap: () {
            onTapAddToCart();
          },
        ),
      ],
    );
  }
}

class ItemPropertyListView extends StatefulWidget {
  List<dynamic> properties;
  Function(String?) onTapProperty;
  Function(int) onTap;
  bool isSelectedSomething;
  int selectedIndex;
  String warning;
  bool isVisibleCircle;
  ItemPropertyListView({
    super.key,
    required this.properties,
    required this.onTapProperty,
    required this.isSelectedSomething,
    required this.onTap,
    this.warning = "",
    this.selectedIndex = -1,
    this.isVisibleCircle = false,
  });

  @override
  State<ItemPropertyListView> createState() => _ItemPropertyListViewState();
}

class _ItemPropertyListViewState extends State<ItemPropertyListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.isVisibleCircle)
          ? scaleWidth(context) / 5
          : scaleWidth(context) / 8,
      child: (widget.properties.length != 0 && widget.properties.isNotEmpty)
          ? ListView.separated(
              itemBuilder: (context, index) => SelectableItemDetailView(
                isVisibleCircle: widget.isVisibleCircle,
                isSelectedFromBloc: widget.isSelectedSomething,
                itemName: widget.properties[index],
                isSelected: (widget.selectedIndex == index),
                onTap: (itemName) {
                  setState(() {
                    widget.onTapProperty(itemName);
                    widget.onTap(index);
                  });
                },
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: scaleWidth(context) / 30),
              itemCount: widget.properties.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
            )
          : Center(
              child: Text(
                widget.warning,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: FONT_MEDIUM,
                ),
              ),
            ),
    );
  }
}

class SelectableItemDetailView extends StatelessWidget {
  String itemName;
  Function(String?) onTap;
  bool isSelected;
  bool isSelectedFromBloc;
  String displayName = "";
  bool isVisibleCircle;
  Color? color;
  SelectableItemDetailView({
    super.key,
    required this.itemName,
    required this.onTap,
    this.isSelected = false,
    this.isSelectedFromBloc = false,
    this.isVisibleCircle = false,
  });

  void _nameModifier() {
    if (itemName == "f") {
      displayName = "Female";
    } else if (itemName == "m") {
      displayName = "Male";
    } else if (itemName == "un") {
      displayName = "Uni Sex";
    } else {
      displayName = itemName;
    }
  }

  void _colorModifier() {
    if (itemName == "ar7" || itemName == "4925ar7") {
      color = const Color(0xff9C9679);
    } else if (itemName == "ar16" || itemName == "4925ar16") {
      color = const Color(0xffC79FDC);
    } else if (itemName == "ar18" || itemName == "4925ar18") {
      color = const Color(0xff63A298);
    } else if (itemName == "ar20" || itemName == "4925ar20") {
      color = const Color(0xff264075);
    } else if (itemName == "ar21" || itemName == "4925ar21") {
      color = const Color(0xff000000);
    } else if (itemName == "ar26" || itemName == "4925ar26") {
      color = const Color(0xffBD8091);
    } else if (itemName == "ar32" || itemName == "4925ar32") {
      color = const Color(0xff002D03);
    } else if (itemName == "ar36" || itemName == "4925ar36") {
      color = const Color(0xffC7004C);
    } else if (itemName == "ar43" || itemName == "4925ar43") {
      color = const Color(0xffF3E124);
    } else if (itemName == "ar44" || itemName == "4925ar44") {
      //color = const Color(0xff008694);
      color = const Color.fromRGBO(22, 115, 148, 1);
    } else if (itemName == "ar48" || itemName == "4925ar48") {
      color = const Color(0xff8F803A);
    } else if (itemName == "ar57" || itemName == "4925ar57") {
      color = const Color(0xff490012);
    } else if (itemName == "ar64" || itemName == "4925ar64") {
      color = const Color(0xff00A23B);
    } else if (itemName == "ar66" || itemName == "4925ar66") {
      color = const Color(0xff2A1733);
    } else if (itemName == "ar67" || itemName == "4925ar67") {
      color = const Color(0xffDA99CC);
    } else if (itemName == "ar70" || itemName == "4925ar70") {
      color = const Color(0xffBAA54D);
    } else if (itemName == "ar75" || itemName == "4925ar75") {
      color = const Color(0xff704289);
    } else if (itemName == "ar77" || itemName == "4925ar77") {
      color = const Color(0xff0E6833);
    } else if (itemName == "ar79" || itemName == "4925ar79") {
      color = const Color(0xffAC4B62);
    } else if (itemName == "ar81" || itemName == "4925ar81") {
      color = const Color(0xff70691E);
    } else if (itemName == "ar82" || itemName == "4925ar82") {
      color = const Color(0xff4D6DAD);
    } else if (itemName == "ar88" || itemName == "4925ar88") {
      color = const Color(0xff0FB782);
    } else if (itemName == "ar90" || itemName == "4925ar90") {
      color = const Color(0xff7F7E73);
    } else if (itemName == "ar96" || itemName == "4925ar96") {
      color = const Color(0xff003C55);
    } else if (itemName == "ar98" || itemName == "4925ar98") {
      color = const Color(0xff026D80);
    } else if (itemName == "ar101" || itemName == "4925ar101") {
      //color = const Color(0xff00A7B6);
      color = const Color.fromRGBO(60, 145, 172, 1);
    } else if (itemName == "ar106" || itemName == "4925ar106") {
      color = const Color(0xff4C4C4C);
    } else if (itemName == "ar89" || itemName == "4925ar89") {
      color = const Color.fromRGBO(20, 22, 34, 1);
    } else if (itemName == "4925ar23") {
      color = const Color.fromRGBO(26, 34, 81, 1);
    } else if (itemName == "ar23") {
      color = const Color.fromRGBO(151, 160, 117, 1);
    } else if (itemName == "ar8") {
      color = const Color.fromRGBO(127, 131, 132, 1);
    } else {
      color = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    _nameModifier();
    _colorModifier();
    return GestureDetector(
      onTap: () {
        onTap(itemName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Visibility(
            visible: isVisibleCircle,
            child: Container(
              width: scaleWidth(context) / 17,
              height: scaleWidth(context) / 17,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
          Visibility(
            visible: isVisibleCircle,
            child: const Spacer(),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: scaleWidth(context) / 100,
              vertical: scaleWidth(context) / 30,
            ),
            decoration: BoxDecoration(
              color: (isSelected && isSelectedFromBloc)
                  ? APP_THEME_COLOR
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Center(
              child: Text(
                displayName,
                style: TextStyle(
                  color: (isSelected && isSelectedFromBloc)
                      ? Colors.white
                      : Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: FONT_MEDIUM - 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NameAndInStockSectionView extends StatelessWidget {
  String? itemName;
  String? stockCount;
  NameAndInStockSectionView({
    super.key,
    required this.itemName,
    required this.stockCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          itemName ?? ".....",
          style: const TextStyle(
            color: APP_THEME_COLOR,
            fontSize: FONT_LARGE - 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          "${stockCount ?? "..!"} PCS stock",
          style: const TextStyle(
            color: Colors.black,
            fontSize: FONT_LARGE - 4,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

class BannerSectionForItemDetailView extends StatefulWidget {
  const BannerSectionForItemDetailView({
    super.key,
  });

  @override
  State<BannerSectionForItemDetailView> createState() =>
      _BannerSectionForItemDetailViewState();
}

class _BannerSectionForItemDetailViewState
    extends State<BannerSectionForItemDetailView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: scaleWidth(context) / 1.1,
          child: Stack(
            children: [
              Positioned.fill(
                child: Consumer<ItemDetailPageBloc>(
                  builder: (context, bloc, child) => PageView(
                    onPageChanged: (pageNum) {
                      setState(() {
                        _position = pageNum.toDouble();
                      });
                    },
                    children: [
                      PageViewItemForItemDetailView(
                        url:
                            "$ITEM_IMAGE_BASE_URL${bloc.response?.item?.photoPath}",
                      ),
                      PageViewItemForItemDetailView(
                        url:
                            "$ITEM_IMAGE_BASE_URL${bloc.response?.item?.photoPath?.replaceAll("front", "left")}",
                      ),
                      PageViewItemForItemDetailView(
                        url:
                            "$ITEM_IMAGE_BASE_URL${bloc.response?.item?.photoPath?.replaceAll("front", "right")}",
                      ),
                      PageViewItemForItemDetailView(
                        url:
                            "$ITEM_IMAGE_BASE_URL${bloc.response?.item?.photoPath?.replaceAll("front", "body")}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: scaleWidth(context) / 30,
        ),
        DotsIndicator(
          dotsCount: 4,
          position: _position,
          decorator: const DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: APP_THEME_COLOR,
          ),
        ),
      ],
    );
  }
}

class PageViewItemForItemDetailView extends StatelessWidget {
  String url;
  PageViewItemForItemDetailView({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      imageErrorBuilder: (context, obj, st) {
        return errorImage();
      },
      placeholder: const AssetImage('assets/images/place_holder_asset.jpg'),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );
  }
}
