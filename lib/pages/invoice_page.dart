// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/invoice_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/pages/order_detail_page.dart';
import 'package:provider/provider.dart';

class InvoicePage extends StatelessWidget {
  String? orderId;
  InvoicePage({
    Key? key,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InvoicePageBloc(orderId),
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
            "Invoice",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<InvoicePageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const LogoAndCompanyNameView(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: scaleWidth(context) / 40),
                        child: const Text(SHOP_ADDRESS),
                      ),
                      SizedBox(height: scaleWidth(context) / 20),
                      const Text(
                        "Profoma E Invoice",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FONT_LARGE - 4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: scaleWidth(context) / 20),
                        child: Consumer<InvoicePageBloc>(
                          builder: (context, bloc, child) => (bloc
                                      .response?.order?.attachFlag ==
                                  0)
                              ? OrderListView(
                                  // rowOneColor: Colors.black12,
                                  // rowTwoColor:
                                  //     const Color.fromRGBO(0, 174, 239, 0.3),
                                  // rowThreeColor: Colors.black12,
                                  // rowFourColor:
                                  //     const Color.fromRGBO(0, 174, 239, 0.3),
                                  // rowFiveColor: Colors.black12,
                                  // rowSixColor:
                                  //     const Color.fromRGBO(0, 174, 239, 0.3),
                                  response: bloc.response,
                                )
                              : AttachOrderItemListView(
                                  // lineOneColor: Colors.black12,
                                  // lineTwoColor:
                                  //     const Color.fromRGBO(0, 174, 239, 0.3),
                                  padding: 2,
                                  response: bloc.response,
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: scaleWidth(context) / 20,
                          right: scaleWidth(context) / 20,
                          bottom: scaleWidth(context) / 20,
                        ),
                        child: Consumer<InvoicePageBloc>(
                          builder: (context, bloc, child) => Column(
                            children: [
                              DetailVoucherRowView(
                                value: bloc.response?.order?.totalAmount
                                        ?.toString() ??
                                    "error",
                                title: "Total Amount",
                              ),
                              DetailVoucherRowView(
                                value: bloc.response?.order?.customerName ??
                                    "error",
                                title: "Customer name",
                              ),
                              DetailVoucherRowView(
                                value: bloc.response?.order?.customerPhone ??
                                    "error",
                                title: "Customer phone",
                              ),
                              DetailVoucherRowView(
                                value: bloc.response?.order?.deliverAddress ??
                                    "error",
                                title: "Customer address",
                              ),
                            ],
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class LogoAndCompanyNameView extends StatelessWidget {
  const LogoAndCompanyNameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/viber_image_2023-03-10_09-12-35-265.png",
          height: scaleWidth(context) / 3,
          width: scaleWidth(context) / 3,
          fit: BoxFit.contain,
        ),
        const Text(
          "Medical World Co.Ltd",
          style: TextStyle(
            color: Color.fromRGBO(0, 174, 239, 1),
            fontWeight: FontWeight.w500,
            fontSize: FONT_LARGE,
          ),
        ),
      ],
    );
  }
}
