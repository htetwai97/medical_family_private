// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/order_detail_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/vo_models/attach_vo.dart';
import 'package:medical_family_app/network/api_constants.dart';
import 'package:medical_family_app/network/responses/get_order_detail_and_invoice_response.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatelessWidget {
  String? orderId;
  OrderDetailPage({
    Key? key,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderDetailPageBloc(orderId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: APP_THEME_COLOR,
          elevation: 5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              //Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: FONT_XLARGE,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Order Detail",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 20),
            child: Consumer<OrderDetailPageBloc>(
              builder: (context, bloc, child) => Stack(
                children: [
                  Visibility(
                    visible: !bloc.isLoading,
                    child: Column(
                      children: [
                        DetailVoucherRowView(
                          title: VOUCHER_NO,
                          value: bloc.response?.order?.id?.toString() ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: CUSTOMER_NAME,
                          value: bloc.response?.order?.customerName ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: ORDER_PHONE,
                          value: bloc.response?.order?.customerPhone ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: ORDER_ADDRESS,
                          value: bloc.response?.order?.deliverAddress ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: ORDER_DATE,
                          value: bloc.response?.order?.orderDate ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: DELIVERY_FEE,
                          value:
                              bloc.response?.order?.deliveryFee?.toString() ??
                                  "-",
                        ),
                        DetailVoucherRowView(
                          title: ORDER_NO,
                          value: bloc.response?.order?.orderCode ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: TOTAL_QUANTITY,
                          value:
                              bloc.response?.order?.totalQuantity?.toString() ??
                                  "-",
                        ),
                        DetailVoucherRowView(
                          title: TOTAL_AMOUNT,
                          value:
                              bloc.response?.order?.totalAmount?.toString() ??
                                  "-",
                        ),
                        DetailVoucherRowView(
                          title: PAYMENT_TYPE,
                          value: bloc.response?.order?.paymentType ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: PAYMENT_CHANNEL,
                          value: bloc.response?.order?.paymentChannel ?? "-",
                        ),
                        DetailVoucherRowView(
                          title: ORDER_STATUS,
                          value: "received",
                        ),
                        SizedBox(
                          height: scaleWidth(context) / 10,
                          child: Center(
                            child: Container(
                              height: 0.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TitleAndSeeMoreView(title: "Your Order List"),
                        (bloc.response?.order?.attachFlag == 0)
                            ? OrderListView(
                                response: bloc.response,
                                // rowOneColor: Colors.black12,
                                // rowTwoColor: Colors.black26,
                                // rowThreeColor: Colors.black12,
                                // rowFourColor: Colors.black26,
                                // rowFiveColor: Colors.black12,
                                // rowSixColor: Colors.black26,
                              )
                            : AttachOrderItemListView(
                                response: bloc.response,
                              ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: bloc.isLoading,
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
        ),
      ),
    );
  }
}

class AttachOrderItemListView extends StatelessWidget {
  GetOrderDetailAndInVoiceResponse? response;
  Color? lineOneColor;
  Color? lineTwoColor;
  double padding;
  AttachOrderItemListView({
    Key? key,
    this.response,
    this.padding = 0,
    this.lineOneColor = Colors.transparent,
    this.lineTwoColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: scaleWidth(context) / 20),
      itemBuilder: (context, index) => OrderWithAttachItemView(
        index: index,
        attachVO: response?.attaches?[index],
        lineOneColor: lineOneColor,
        lineTwoColor: lineTwoColor,
        padding: padding,
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: scaleWidth(context) / 20,
      ),
      itemCount: response?.attaches?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class OrderWithAttachItemView extends StatelessWidget {
  int index;
  AttachVO? attachVO;
  Color? lineOneColor;
  Color? lineTwoColor;
  double padding;
  OrderWithAttachItemView({
    Key? key,
    this.attachVO,
    this.padding = 0,
    this.lineOneColor = Colors.transparent,
    this.lineTwoColor = Colors.transparent,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
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
              placeholder:
                  const AssetImage("assets/images/place_holder_asset.jpg"),
              image: NetworkImage(
                "$PREORDER_IMAGE_BASE_URL${attachVO?.itemPhoto}",
              ),
            ),
          ),
          SizedBox(width: scaleWidth(context) / 10),
          CartTextTwoColumnView(
            lineColorOne: lineOneColor,
            lineColorTwo: lineTwoColor,
            padding: padding,
            name: "No - ${index + 1}",
            id: "Quantity - ${attachVO?.quantity}",
            color: "Price - ${attachVO?.price}",
            fabric: "Description - ${attachVO?.description}",
            size: "",
          ),
        ],
      ),
    );
  }
}

class OrderListView extends StatelessWidget {
  Color? rowOneColor;
  Color? rowTwoColor;
  Color? rowThreeColor;
  Color? rowFourColor;
  Color? rowFiveColor;
  Color? rowSixColor;
  GetOrderDetailAndInVoiceResponse? response;
  OrderListView({
    super.key,
    this.rowOneColor = Colors.white,
    this.rowTwoColor = Colors.white,
    this.rowThreeColor = Colors.white,
    this.rowFourColor = Colors.white,
    this.rowFiveColor = Colors.white,
    this.rowSixColor = Colors.white,
    this.response,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: scaleWidth(context) / 20),
      itemBuilder: (context, index) => OrderDetailItemView(
        size:
            response?.units?[index]?.countingUnitInStockOrder?.size?.sizeName ??
                "",
        color: response
                ?.units?[index]?.countingUnitInStockOrder?.colour?.colourName ??
            "",
        quantity: response?.units?[index]?.quantity?.toString() ?? "",
        price: response?.units?[index]?.price?.toString() ?? "",
        itemName:
            response?.units?[index]?.countingUnitInStockOrder?.unitCode ?? "",
        no: "${index + 1}",
        rowFiveColor: rowFiveColor,
        rowFourColor: rowFourColor,
        rowOneColor: rowOneColor,
        rowSixColor: rowSixColor,
        rowThreeColor: rowThreeColor,
        rowTwoColor: rowTwoColor,
      ),
      separatorBuilder: (context, index) =>
          SizedBox(height: scaleWidth(context) / 20),
      itemCount: response?.units?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class OrderDetailItemView extends StatelessWidget {
  String no;
  String itemName;
  String color;
  String size;
  String quantity;
  String price;
  Color? rowOneColor;
  Color? rowTwoColor;
  Color? rowThreeColor;
  Color? rowFourColor;
  Color? rowFiveColor;
  Color? rowSixColor;
  OrderDetailItemView({
    super.key,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
    required this.itemName,
    required this.no,
    this.rowOneColor = Colors.white,
    this.rowTwoColor = Colors.white,
    this.rowThreeColor = Colors.white,
    this.rowFourColor = Colors.white,
    this.rowFiveColor = Colors.white,
    this.rowSixColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(context) / 30,
        vertical: scaleWidth(context) / 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          DetailVoucherRowView(
            rowColor: rowOneColor,
            value: no,
            title: "NO",
            valueColor: APP_THEME_COLOR,
          ),
          DetailVoucherRowView(
            rowColor: rowTwoColor,
            value: itemName,
            title: "Item Name",
            valueColor: APP_THEME_COLOR,
          ),
          DetailVoucherRowView(
            rowColor: rowThreeColor,
            value: color,
            title: "Color",
            valueColor: APP_THEME_COLOR,
          ),
          DetailVoucherRowView(
            rowColor: rowFourColor,
            value: size,
            title: "Size",
            valueColor: APP_THEME_COLOR,
          ),
          DetailVoucherRowView(
            rowColor: rowFiveColor,
            value: quantity,
            title: "Qty",
            valueColor: APP_THEME_COLOR,
          ),
          DetailVoucherRowView(
            rowColor: rowSixColor,
            value: price,
            title: "Price",
            valueColor: APP_THEME_COLOR,
          ),
        ],
      ),
    );
  }
}

class DetailVoucherRowView extends StatelessWidget {
  String title;
  String value;
  Color? valueColor;
  Color? rowColor;
  double? titleFont;
  double? valueFont;
  DetailVoucherRowView({
    super.key,
    required this.value,
    required this.title,
    this.valueColor = Colors.black,
    this.rowColor = Colors.white,
    this.titleFont = FONT_LARGE - 6,
    this.valueFont = FONT_LARGE - 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: rowColor,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: titleFont,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: scaleWidth(context) / 10,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: valueFont,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
