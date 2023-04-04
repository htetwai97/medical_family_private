// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/user_info_for_pre_order_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:medical_family_app/pages/my_order_page.dart';
import 'package:medical_family_app/pages/user_info_for_stock_order_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/register_page_one.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class UserInfoForPreOrderPage extends StatelessWidget {
  bool isCustom;
  UserInfoForPreOrderPage({
    Key? key,
    required this.isCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserInfoForPreOrderBloc(isCustom),
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
            "Verify User info for preorder",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<UserInfoForPreOrderBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              Visibility(
                visible: !isLoading,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleWidth(context) / 10,
                      vertical: scaleWidth(context) / 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            predefinedText: bloc.name,
                            labelText: "Name",
                            onChanged: (name) {
                              bloc.onNameChange(name);
                            },
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            predefinedText: bloc.phone,
                            labelText: "Phone",
                            onChanged: (text) {
                              bloc.onContactNumberChange(text);
                            },
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            predefinedText: bloc.address,
                            labelText: "Address",
                            onChanged: (text) {
                              bloc.onShippingAddressChange(text);
                            },
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            predefinedText: bloc.orderDate,
                            labelText: "OrderDate",
                            onChanged: (text) {},
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) => ChooseDropDownView(
                            onChange: (paymentType) {
                              bloc.onChoosePaymentType(paymentType ?? "");
                            },
                            hint: "Select Payment type",
                            items: const ["Fully prepaid", "Partially prepaid"],
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) => ChooseDropDownView(
                            onChange: (paymentChannel) {
                              bloc.onChoosePaymentChannel(paymentChannel ?? "");
                            },
                            hint: "Select Payment channel",
                            items: const ["mobile banking", "internet banking"],
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<UserInfoForPreOrderBloc>(
                          builder: (context, bloc, child) => Visibility(
                            visible: bloc.paymentChannel == "mobile banking",
                            child: BankOrPaidInfoView(
                              mainAxisAlignment: MainAxisAlignment.center,
                              fontSize: FONT_LARGE - 6,
                              onChooseBankOrPaid: (value) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      if (value == 1) {
                                        return BankInfoShowDialog();
                                      } else {
                                        return PaidInfoShowDialog(
                                          onTapCancel: () {
                                            bloc.onTapCancelFile();
                                          },
                                          fileData: (bloc.file != null)
                                              ? "One file chosen"
                                              : "",
                                          onTapSave: () {
                                            Navigator.pop(context);
                                            bloc.onTapSaveFile();
                                          },
                                          onChangeAmount: (amount) {
                                            bloc.onChangePayAmount(amount);
                                          },
                                          onChangeRemark: (remark) {
                                            bloc.onChangePaymentRemark(remark);
                                          },
                                          onTapChooseFile: () async {
                                            var result = await FilePicker
                                                .platform
                                                .pickFiles(
                                              type: FileType.image,
                                              allowMultiple: false,
                                            );
                                            var platFormFile =
                                                result?.files.first;
                                            if (platFormFile != null) {
                                              bloc.onChosenFile(
                                                File(platFormFile.path ?? ""),
                                              );
                                            }
                                          },
                                        );
                                      }
                                    });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Align(
                          alignment: Alignment.center,
                          child: Consumer<UserInfoForPreOrderBloc>(
                            builder: (context, bloc, child) => CommonAppButton(
                              buttonColor: (bloc.isUnlockConfirmButton)
                                  ? APP_THEME_COLOR
                                  : Colors.grey,
                              text: "Confirm",
                              textFont: FONT_LARGE - 4,
                              onTap: () {
                                if (bloc.isUnlockConfirmButton) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Visibility(
                                          visible: bloc.isApiCalling == false,
                                          child: ConfirmOrNotShowDialogView(
                                            notification: "Pre order Confirm?",
                                            onTapOK: () {
                                              bloc.onTapOk().then((value) {
                                                if (bloc.orderSuccess) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyOrderPage()),
                                                      (route) => false);
                                                } else {
                                                  showSnackBarWithMessage(
                                                      context,
                                                      "Order process failed,try again later!",
                                                      false);
                                                }
                                              });
                                            },
                                          ),
                                        );
                                      });
                                }
                              },
                            ),
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
              Consumer<UserInfoForPreOrderBloc>(
                builder: (context, bloc, child) => Visibility(
                  visible: bloc.isApiCalling,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
