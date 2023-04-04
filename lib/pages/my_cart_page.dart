// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/my_cart_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/pages/user_info_for_stock_order_page.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyCartPageBloc(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Consumer<MyCartPageBloc>(
          builder: (context, bloc, child) => CommonAppButton(
            buttonColor: Colors.black54,
            textColor: Colors.white,
            text: "See Summary",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CheckOutShowDialogView(
                      totalQuantity: bloc.totalQuantity.toString(),
                      subTotal: bloc.subTotal.toString(),
                      estimatedShipping: bloc.estimatedShipping.toString(),
                      discount: bloc.discount.toString(),
                      total: bloc.totalWithoutDiscount.toString(),
                      onTapCheckOut: () {
                        if (bloc.cartList?.isNotEmpty ?? false) {
                          navigateToScreen(
                              context, const UserInfoForStockOrderPage());
                        }
                      },
                    );
                  });
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: APP_THEME_COLOR,
          elevation: 5.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: FONT_XLARGE,
            ),
          ),
          title: const Text(
            "My Cart",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: FONT_LARGE - 4,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonAppButton(
                textColor: APP_THEME_COLOR,
                buttonColor: Colors.white,
                text: "Go Shopping",
                onTap: () {
                  navigateToScreen(
                      context,
                      ProductLineNewVersionPage(
                        comeFromHomePage: true,
                      ));
                },
              ),
            ),
          ],
        ),
        body: Consumer<MyCartPageBloc>(
          builder: (context, bloc, child) => ListView.separated(
            padding: EdgeInsets.only(
              top: scaleWidth(context) / 20,
              bottom: scaleWidth(context) / 5,
              left: scaleWidth(context) / 20,
              right: scaleWidth(context) / 20,
            ),
            itemBuilder: (context, index) => CartItemDetailView(
              cartItem: bloc.cartList?[index],
              onTapDelete: (cartItem) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmOrNotShowDialogView(
                        onTapOK: () {
                          bloc.onTapDeleteButton(cartItem);
                          Navigator.pop(context);
                        },
                      );
                    });
              },
              onTapQuantity: (quantity, cartItem) {
                bloc.onTapQuantityButton(quantity, cartItem);
              },
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: scaleWidth(context) / 16,
            ),
            itemCount: bloc.cartList?.length ?? 0,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ConfirmOrNotShowDialogView extends StatelessWidget {
  Function() onTapOK;
  String notification;
  ConfirmOrNotShowDialogView({
    super.key,
    required this.onTapOK,
    this.notification = "Remove this item from the cart.",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 60,
            vertical: scaleWidth(context) / 60,
          ),
          height: scaleWidth(context) / 4.0,
          width: scaleWidth(context) / 1.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                notification,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: FONT_MEDIUM,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: scaleWidth(context) / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonAppButton(
                    text: "Cancel",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: scaleWidth(context) / 8),
                  CommonAppButton(
                    text: "Ok",
                    onTap: () {
                      onTapOK();
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutShowDialogView extends StatelessWidget {
  Function onTapCheckOut;
  String totalQuantity;
  String subTotal;
  String estimatedShipping;
  String discount;
  String total;
  CheckOutShowDialogView({
    super.key,
    required this.onTapCheckOut,
    required this.discount,
    required this.estimatedShipping,
    required this.subTotal,
    required this.total,
    required this.totalQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 30,
            vertical: scaleWidth(context) / 30,
          ),
          height: scaleWidth(context) / 1.25,
          width: scaleWidth(context) / 1.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SummaryTextView(
                text: "Order Summary",
                fontSize: FONT_LARGE,
              ),
              SizedBox(height: scaleWidth(context) / 20),
              SummaryTextRowView(
                textOne: "Total quantity",
                textTwo: totalQuantity,
                fontSize: FONT_MEDIUM,
              ),
              SizedBox(height: scaleWidth(context) / 20),
              SummaryTextRowView(
                textOne: "Sub Total",
                textTwo: subTotal,
                fontSize: FONT_MEDIUM,
              ),
              SizedBox(height: scaleWidth(context) / 20),
              SummaryTextRowView(
                textOne: "Estimated Shipping",
                textTwo: estimatedShipping,
                fontSize: FONT_MEDIUM,
              ),
              SizedBox(height: scaleWidth(context) / 20),
              SummaryTextRowView(
                textOne: "Discount",
                textTwo: discount,
                fontSize: FONT_MEDIUM,
              ),
              SizedBox(height: scaleWidth(context) / 20),
              SummaryTextRowView(
                textOne: "Total",
                textTwo: total,
                fontSize: FONT_MEDIUM,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    CommonAppButton(
                      buttonColor: Colors.black87,
                      textColor: Colors.white,
                      text: "Cancel",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    CommonAppButton(
                      buttonColor: Colors.black87,
                      textColor: Colors.white,
                      text: "Check out",
                      onTap: () {
                        onTapCheckOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryTextRowView extends StatelessWidget {
  String textOne;
  String textTwo;
  double fontSize;
  SummaryTextRowView({
    super.key,
    required this.textOne,
    required this.textTwo,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SummaryTextView(
          text: textOne,
          fontSize: fontSize,
        ),
        const Spacer(),
        SummaryTextView(
          text: textTwo,
          fontSize: fontSize,
        ),
      ],
    );
  }
}

class SummaryTextView extends StatelessWidget {
  String text;
  double fontSize;
  SummaryTextView({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CartItemDetailView extends StatelessWidget {
  CartItemVO? cartItem;
  Function(CartItemVO?) onTapDelete;
  Function(int, CartItemVO?) onTapQuantity;
  CartItemDetailView({
    super.key,
    required this.cartItem,
    required this.onTapQuantity,
    required this.onTapDelete,
  });

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
          height: scaleWidth(context) / 2.1,
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
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, obj, st) {
                        return errorImage();
                      },
                      placeholder: const AssetImage(
                          "assets/images/place_holder_asset.jpg"),
                      image: NetworkImage(
                        "$ITEM_IMAGE_BASE_URL${cartItem?.itemImage}",
                      ),
                    ),
                  ),
                  SizedBox(width: scaleWidth(context) / 40),
                  const CartTextOneColumnView(),
                  CartTextTwoColumnView(
                    name: " - ${cartItem?.itemName}",
                    id: " - ${cartItem?.unitCode}",
                    color: " - ${cartItem?.color}",
                    fabric: " - ${cartItem?.fabric}",
                    size: " - ${cartItem?.size}",
                  ),
                ],
              ),
              SizedBox(height: scaleWidth(context) / 40),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth(context) / 25,
                ),
                child: CartQuantityControlView(
                  stockQuantity: cartItem?.stockQuantity ?? 1,
                  quantity: cartItem?.quantity ?? 1,
                  price: "${cartItem?.updatePrice}",
                  onTap: (quantity) {
                    onTapQuantity(quantity, cartItem);
                  },
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapDelete(cartItem);
          },
          child: const RemoveIconView(),
        ),
      ],
    );
  }
}

class RemoveIconView extends StatelessWidget {
  const RemoveIconView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scaleWidth(context) / 18,
      width: scaleWidth(context) / 18,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black54,
      ),
      child: const Center(
        child: Icon(
          Icons.remove,
          color: Colors.white,
          size: FONT_MEDIUM - 2,
        ),
      ),
    );
  }
}

class CartTextOneColumnView extends StatelessWidget {
  const CartTextOneColumnView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CartTextView(
          text: "Product",
          textColor: Colors.black87,
        ),
        SizedBox(height: scaleWidth(context) / 40),
        CartTextView(
          text: "ID",
          textColor: Colors.black87,
        ),
        SizedBox(height: scaleWidth(context) / 40),
        CartTextView(
          text: "Color",
          textColor: Colors.black87,
        ),
        SizedBox(height: scaleWidth(context) / 40),
        CartTextView(
          text: "Fabric",
          textColor: Colors.black87,
        ),
        SizedBox(height: scaleWidth(context) / 40),
        CartTextView(
          text: "Size",
          textColor: Colors.black87,
        ),
      ],
    );
  }
}

class CartTextTwoColumnView extends StatelessWidget {
  String name;
  String id;
  String color;
  String fabric;
  String size;
  double font;
  Color? lineColorOne;
  Color? lineColorTwo;
  double padding;
  CartTextTwoColumnView({
    Key? key,
    required this.name,
    required this.color,
    required this.fabric,
    required this.size,
    required this.id,
    this.font = FONT_LARGE - 8,
    this.padding = 0,
    this.lineColorOne = Colors.transparent,
    this.lineColorTwo = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CartTextView(
            text: name,
            fontSize: font,
            lineColor: lineColorOne,
            padding: padding,
          ),
          SizedBox(height: scaleWidth(context) / 40),
          CartTextView(
            text: id,
            fontSize: font,
            lineColor: lineColorTwo,
            padding: padding,
          ),
          SizedBox(height: scaleWidth(context) / 40),
          CartTextView(
            text: color,
            fontSize: font,
            lineColor: lineColorOne,
            padding: padding,
          ),
          SizedBox(height: scaleWidth(context) / 40),
          CartTextView(
            text: fabric,
            fontSize: font,
            lineColor: lineColorTwo,
            padding: padding,
          ),
          SizedBox(height: scaleWidth(context) / 40),
          CartTextView(
            text: size,
            fontSize: font,
          ),
        ],
      ),
    );
  }
}

class CartQuantityControlView extends StatefulWidget {
  int stockQuantity;
  int quantity;
  String price;
  Function(int) onTap;
  CartQuantityControlView({
    super.key,
    required this.quantity,
    required this.price,
    required this.onTap,
    required this.stockQuantity,
  });

  @override
  State<CartQuantityControlView> createState() =>
      _CartQuantityControlViewState();
}

class _CartQuantityControlViewState extends State<CartQuantityControlView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlusOrMinusCartItemView(
          icon: Icons.add,
          onTapQuantityControlButton: () {
            setState(() {
              if (widget.quantity < widget.stockQuantity) {
                widget.quantity++;
                widget.onTap(widget.quantity);
              }
            });
          },
        ),
        SizedBox(width: scaleWidth(context) / 30),
        Text(
          widget.quantity.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: FONT_LARGE - 4,
          ),
        ),
        SizedBox(width: scaleWidth(context) / 30),
        PlusOrMinusCartItemView(
          icon: Icons.remove,
          onTapQuantityControlButton: () {
            setState(() {
              if (widget.quantity > 1) {
                setState(() {
                  widget.quantity--;
                  widget.onTap(widget.quantity);
                });
              }
            });
          },
        ),
        const Spacer(),
        CartTextView(
          text: "Price - ${widget.price} MMK",
          textColor: Colors.black,
          fontSize: FONT_LARGE - 6,
        ),
      ],
    );
  }
}

class PlusOrMinusCartItemView extends StatelessWidget {
  Function onTapQuantityControlButton;
  IconData icon;
  PlusOrMinusCartItemView({
    super.key,
    required this.onTapQuantityControlButton,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapQuantityControlButton();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 0),
              )
            ]),
        child: Icon(
          icon,
          size: FONT_MEDIUM - 2,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CartTextView extends StatelessWidget {
  String text;
  Color textColor;
  double fontSize;
  Color? lineColor;
  double padding;
  CartTextView({
    super.key,
    required this.text,
    this.textColor = APP_THEME_COLOR,
    this.fontSize = FONT_LARGE - 8,
    this.lineColor = Colors.transparent,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lineColor,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      width: (lineColor != Colors.transparent) ? scaleWidth(context) : null,
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
        selectionColor: Colors.black12,
      ),
    );
  }
}
