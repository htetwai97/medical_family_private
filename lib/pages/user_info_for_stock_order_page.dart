// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/user_info_for_stock_order_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/pages/my_cart_page.dart';
import 'package:medical_family_app/pages/my_order_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/register_page_one.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class UserInfoForStockOrderPage extends StatelessWidget {
  const UserInfoForStockOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserInfoForStockOrderPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: APP_THEME_COLOR,
          elevation: 5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
            "Delivery and payment information",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Selector<UserInfoForStockOrderPageBloc, bool>(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<UserInfoForStockOrderPageBloc>(
                            builder: (context, bloc, child) {
                          return CommonTextFieldView(
                            labelText: "Name",
                            onChanged: (text) {
                              bloc.onNameChange(text);
                            },
                            predefinedText: bloc.name,
                          );
                        }),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            labelText: "Phone",
                            onChanged: (text) {
                              bloc.onContactNumberChange(text);
                            },
                            predefinedText: bloc.phone,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            labelText: "Address",
                            onChanged: (text) {
                              bloc.onShippingAddressChange(text);
                            },
                            predefinedText: bloc.address,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) => ChooseDropDownView(
                            onChange: (township) {
                              bloc.onChooseTownship(township ?? "");
                            },
                            hint: "Select Township",
                            items: bloc.townshipList
                                    ?.map((e) => e?.township ?? "")
                                    .toList() ??
                                [],
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) => ChargesBoxView(
                            charges:
                                bloc.township?.charges?.toString() ?? "Charges",
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) => ChooseDropDownView(
                            onChange: (paymentType) {
                              bloc.onChoosePaymentType(paymentType ?? "");
                            },
                            hint: "Select Payment type",
                            items: const ["Fully prepaid"],
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 16),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) => ChooseDropDownView(
                            onChange: (paymentChannel) {
                              bloc.onChoosePaymentChannel(paymentChannel ?? "");
                            },
                            hint: "Select Payment channel",
                            items: const ["mobile banking", "internet banking"],
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) => Visibility(
                            visible: bloc.paymentChannel == "mobile banking",
                            child: BankOrPaidInfoView(
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
                                          onTapSave: () {
                                            bloc.onTapSaveFile().then((value) =>
                                                Navigator.pop(context));
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
                        SizedBox(height: scaleWidth(context) / 20),
                        Consumer<UserInfoForStockOrderPageBloc>(
                          builder: (context, bloc, child) =>
                              CommonTextFieldView(
                            labelText: "Remark",
                            onChanged: (text) {
                              bloc.onChangeRemark(text);
                            },
                            predefinedText: bloc.remark,
                          ),
                        ),
                        SizedBox(height: scaleWidth(context) / 10),
                        Align(
                          alignment: Alignment.center,
                          child: Consumer<UserInfoForStockOrderPageBloc>(
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
                                            notification:
                                                "Stock order Confirm?",
                                            onTapOK: () {
                                              bloc.onTapOKToCheckOut().then(
                                                  (value) => Navigator
                                                      .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MyOrderPage()),
                                                          (route) => false));
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
              Consumer<UserInfoForStockOrderPageBloc>(
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

class ChargesBoxView extends StatelessWidget {
  String charges;
  ChargesBoxView({
    super.key,
    required this.charges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 20),
      height: scaleWidth(context) / 7.8,
      width: scaleWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          charges,
          style: TextStyle(
            color: (charges == "Charges") ? APP_THEME_COLOR : Colors.black,
          ),
        ),
      ),
    );
  }
}

class PaidInfoShowDialog extends StatelessWidget {
  Function(String) onChangeAmount;
  Function(String) onChangeRemark;
  Function onTapSave;
  Function onTapChooseFile;
  Function onTapCancel;
  String fileData;
  bool isFullPage;
  PaidInfoShowDialog({
    Key? key,
    required this.onChangeRemark,
    required this.onChangeAmount,
    required this.onTapSave,
    required this.onTapChooseFile,
    required this.onTapCancel,
    this.fileData = "No chosen file.",
    this.isFullPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (isFullPage) ? Colors.white : Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 30,
            vertical: scaleWidth(context) / 25,
          ),
          height: scaleWidth(context) * 1.1,
          width: (isFullPage) ? scaleWidth(context) : scaleWidth(context) / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("User Paid Information"),
              SizedBox(height: scaleWidth(context) / 20),
              CommonAppButton(
                text: "Choose File",
                onTap: () {
                  onTapChooseFile();
                },
                buttonColor: Colors.black54,
                textColor: Colors.white,
                textFont: 12,
              ),
              SizedBox(height: scaleWidth(context) / 40),
              Text(fileData),
              SizedBox(height: scaleWidth(context) / 20),
              PaymentAmountAndRemarkView(
                hint: "pay amount",
                onChangeText: (amount) {
                  onChangeAmount(amount);
                },
              ),
              SizedBox(height: scaleWidth(context) / 20),
              PaymentAmountAndRemarkView(
                hint: "remark",
                onChangeText: (remark) {
                  onChangeRemark(remark);
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: scaleWidth(context) / 8),
                  child: Row(
                    children: [
                      Visibility(
                        visible: (!isFullPage),
                        child: CommonAppButton(
                          text: "Cancel",
                          onTap: () {
                            onTapCancel();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Spacer(),
                      CommonAppButton(
                        text: "Save",
                        onTap: () {
                          if (isFullPage) {
                            onTapSave();
                            showSnackBarWithMessage(
                              context,
                              "Payment saved",
                              true,
                            );
                          } else {
                            onTapSave();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentAmountAndRemarkView extends StatelessWidget {
  PaymentAmountAndRemarkView({
    super.key,
    required this.onChangeText,
    required this.hint,
  });

  Function(String p1) onChangeText;
  String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        onChangeText(text);
      },
      decoration: InputDecoration(
        isDense: false,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
      ),
    );
  }
}

class BankInfoShowDialog extends StatefulWidget {
  bool isFullPage;
  BankInfoShowDialog({super.key, this.isFullPage = false});

  @override
  State<BankInfoShowDialog> createState() => _BankInfoShowDialogState();
}

class _BankInfoShowDialogState extends State<BankInfoShowDialog> {
  List<String> logos = [
    "assets/images/KBZ-1.png",
    "assets/images/aya_bank.png",
    "assets/images/cb_pay_logo.jpg",
    "assets/images/kpay_logo.png",
    "assets/images/wave_pay.jpg",
  ];

  int bank = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: (widget.isFullPage) ? Colors.white : Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 30,
            vertical: scaleWidth(context) / 25,
          ),
          height: (widget.isFullPage)
              ? scaleWidth(context)
              : scaleWidth(context) * 1.1,
          width: (widget.isFullPage)
              ? scaleWidth(context)
              : scaleWidth(context) / 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        bank = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        logos[index],
                        fit: BoxFit.contain,
                        width: 70,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    width: scaleWidth(context) / 30,
                  ),
                  itemCount: logos.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.black12,
                height: 1,
              ),
              Text((bank == 0)
                  ? KBZ_TEXT_ONE
                  : (bank == 1)
                      ? AYA_TEXT_ONE
                      : (bank == 2)
                          ? CB_TEXT_ONE
                          : (bank == 3)
                              ? KPAY_TEXT_ONE
                              : WAVE_TEXT_ONE),
              const SizedBox(height: 10),
              Text((bank == 0)
                  ? KBZ_TEXT_TWO
                  : (bank == 1)
                      ? AYA_TEXT_TWO
                      : (bank == 2)
                          ? CB_TEXT_TWO
                          : (bank == 3)
                              ? KPAY_TEXT_TWO
                              : WAVE_TEXT_TWO),
              const SizedBox(height: 10),
              Text((bank == 0)
                  ? KBZ_TEXT_THREE
                  : (bank == 1)
                      ? AYA_TEXT_THREE
                      : (bank == 2)
                          ? CB_TEXT_THREE
                          : (bank == 3)
                              ? KPAY_TEXT_THREE
                              : WAVE_TEXT_THREE),
              const SizedBox(height: 10),
              Visibility(
                visible: bank != 0 && bank != 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/qr_dummy.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: (!widget.isFullPage),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CommonAppButton(
                    textFont: FONT_MEDIUM - 4,
                    text: "Ok",
                    onTap: () {
                      Navigator.pop(context);
                    },
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

class BankOrPaidInfoView extends StatefulWidget {
  Function(int? value) onChooseBankOrPaid;
  double fontSize;
  MainAxisAlignment mainAxisAlignment;
  BankOrPaidInfoView({
    Key? key,
    required this.onChooseBankOrPaid,
    this.fontSize = 16,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  State<BankOrPaidInfoView> createState() => _BankOrPaidInfoViewState();
}

class _BankOrPaidInfoViewState extends State<BankOrPaidInfoView> {
  int? valueOne = 1;
  int? valueTwo = 2;
  int? groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: [
            Radio(
              value: valueOne,
              groupValue: groupValue,
              onChanged: (clickValue) {
                setState(() {
                  groupValue = clickValue;
                  widget.onChooseBankOrPaid(groupValue);
                });
              },
            ),
            Text(
              "Bank info",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: widget.fontSize,
              ),
            ),
            const SizedBox(width: 6),
            Radio(
              value: valueTwo,
              groupValue: groupValue,
              onChanged: (clickValue) {
                setState(() {
                  groupValue = clickValue;
                  widget.onChooseBankOrPaid(groupValue);
                });
              },
            ),
            Text(
              "Paid info",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: widget.fontSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ChooseDropDownView extends StatefulWidget {
  String hint;
  List<String> items;
  Function(String?) onChange;
  ChooseDropDownView({
    Key? key,
    required this.hint,
    this.items = const ['Item 1', 'Item 2', 'Item 3'],
    required this.onChange,
  }) : super(key: key);

  @override
  State<ChooseDropDownView> createState() => _ChooseDropDownViewState();
}

class _ChooseDropDownViewState extends State<ChooseDropDownView> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scaleWidth(context) / 40,
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
      child: DropdownButton(
        focusColor: Colors.white,
        dropdownColor: Colors.white,
        value: selectedItem,
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        hint: Text(
          widget.hint,
          style: const TextStyle(
            color: APP_THEME_COLOR,
            fontSize: FONT_MEDIUM,
            fontWeight: FontWeight.w400,
          ),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: FONT_MEDIUM,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (newValue) {
          setState(() {
            selectedItem = newValue;
            widget.onChange(newValue);
          });
        },
      ),
    );
  }
}
