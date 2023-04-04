// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/my_order_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/pages/bottom_navigation_page.dart';
import 'package:medical_family_app/pages/invoice_page.dart';
import 'package:medical_family_app/pages/payment_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/order_detail_page.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class MyOrderPage extends StatelessWidget {
  bool isComingFromHome;
  MyOrderPage({
    Key? key,
    this.isComingFromHome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyOrderPageBloc>(
      create: (context) => MyOrderPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: APP_THEME_COLOR,
          leading: IconButton(
            onPressed: () {
              if (isComingFromHome) {
                Navigator.pop(context);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigationPage()),
                    (route) => false);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: FONT_XLARGE,
            ),
          ),
          title: const Text(
            "My orders",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<MyOrderPageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: scaleWidth(context) / 20,
                          left: scaleWidth(context) / 20,
                          right: scaleWidth(context) / 20,
                          bottom: scaleWidth(context) / 20,
                        ),
                        child: const InStockOrPreOrderChipView(),
                      ),
                      Consumer<MyOrderPageBloc>(
                        builder: (context, bloc, child) => ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: scaleWidth(context) / 20,
                            vertical: scaleWidth(context) / 20,
                          ),
                          itemBuilder: (context, index) => OrderItemDetailView(
                            boucherNo:
                                bloc.orderList?[index]?.orderCode?.toString() ??
                                    "",
                            date: bloc.orderList?[index]?.orderDate ?? "",
                            onTapDetail: () {
                              navigateToScreen(
                                  context,
                                  OrderDetailPage(
                                      orderId: bloc.orderList?[index]?.id
                                          ?.toString()));
                            },
                            onTapInvoice: () {
                              navigateToScreen(
                                  context,
                                  InvoicePage(
                                      orderId: bloc.orderList?[index]?.id
                                          ?.toString()));
                            },
                            onTapPayment: () {
                              navigateToScreen(context, const PaymentPage());
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: scaleWidth(context) / 20,
                          ),
                          itemCount: bloc.orderList?.length ?? 0,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ],
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
              Consumer<MyOrderPageBloc>(
                builder: (context, bloc, child) => Visibility(
                  visible: bloc.forceLoading,
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.symmetric(
                        vertical: scaleWidth(context) / 1.3),
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

class OrderItemDetailView extends StatelessWidget {
  Function onTapDetail;
  Function onTapInvoice;
  Function onTapPayment;
  String boucherNo;
  String date;
  OrderItemDetailView({
    super.key,
    required this.onTapPayment,
    required this.onTapInvoice,
    required this.onTapDetail,
    required this.date,
    required this.boucherNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(context) / 20,
        vertical: scaleWidth(context) / 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
      height: scaleWidth(context) / 3,
      width: scaleWidth(context) / 1.1,
      child: Column(
        children: [
          BoucherNoDateView(
            boucherNo: boucherNo,
            date: date,
          ),
          const Spacer(),
          ThreeButtonView(
            onTapDetail: () {
              onTapDetail();
            },
            onTapInvoice: () {
              onTapInvoice();
            },
            onTapPayment: () {
              onTapPayment();
            },
          ),
        ],
      ),
    );
  }
}

class ThreeButtonView extends StatelessWidget {
  Function onTapDetail;
  Function onTapInvoice;
  Function onTapPayment;
  ThreeButtonView({
    Key? key,
    required this.onTapDetail,
    required this.onTapInvoice,
    required this.onTapPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonAppButton(
          buttonColor: Colors.black,
          text: "Detail",
          onTap: () {
            onTapDetail();
          },
        ),
        const Spacer(),
        CommonAppButton(
          buttonColor: const Color.fromRGBO(0, 128, 128, 1),
          text: "Invoice",
          onTap: () {
            onTapInvoice();
          },
        ),
        const Spacer(),
        CommonAppButton(
          buttonColor: const Color.fromRGBO(2, 127, 157, 1),
          text: "Payment",
          onTap: () {
            onTapPayment();
          },
        ),
      ],
    );
  }
}

class BoucherNoDateView extends StatelessWidget {
  String boucherNo;
  String date;

  BoucherNoDateView({
    super.key,
    required this.boucherNo,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          boucherNo,
          style: const TextStyle(
            fontSize: FONT_LARGE - 6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          date,
          style: const TextStyle(
            fontSize: FONT_LARGE - 6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 40,
            vertical: scaleWidth(context) / 60,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(70, 46, 144, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "received",
            style: TextStyle(
              fontSize: FONT_LARGE - 8,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class InStockOrPreOrderChipView extends StatelessWidget {
  const InStockOrPreOrderChipView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderPageBloc>(
      builder: (context, bloc, child) => Container(
        width: scaleWidth(context) / 1.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black12,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                bloc.onChooseOrder(0);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth(context) / 30,
                  vertical: scaleWidth(context) / 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: (bloc.isChooseInStock)
                      ? APP_THEME_COLOR
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Instock order",
                    style: TextStyle(
                      color:
                          (bloc.isChooseInStock) ? Colors.white : Colors.black,
                      fontSize: FONT_LARGE - 6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                bloc.onChooseOrder(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: scaleWidth(context) / 30,
                  vertical: scaleWidth(context) / 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: (bloc.isChoosePreorder)
                      ? APP_THEME_COLOR
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Pre order",
                    style: TextStyle(
                      color:
                          (bloc.isChoosePreorder) ? Colors.white : Colors.black,
                      fontSize: FONT_LARGE - 6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
