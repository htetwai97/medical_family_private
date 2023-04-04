import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/pages/user_info_for_stock_order_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontSize: FONT_LARGE - 2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 20,
            vertical: scaleWidth(context) / 20,
          ),
          child: Column(
            children: [
              BankInfoShowDialog(
                isFullPage: true,
              ),
              PaidInfoShowDialog(
                onTapCancel: () {},
                isFullPage: true,
                onTapSave: () {},
                onTapChooseFile: () {},
                onChangeRemark: (remark) {},
                onChangeAmount: (amount) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
