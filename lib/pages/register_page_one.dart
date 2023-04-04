// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/register_page_one_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/pages/login_page.dart';
import 'package:medical_family_app/pages/register_page_two.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:provider/provider.dart';

class RegisterPageOne extends StatelessWidget {
  const RegisterPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterPageOneBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: scaleWidth(context) / 8),
                  child: Image.asset(
                    "assets/images/intro_image_one.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: scaleWidth(context) / 12),
                TitleForRegisterAndLoginView(
                  title: "Hello!  Sign up to get started..",
                  titleColor: Colors.black,
                ),
                SizedBox(height: scaleWidth(context) / 8),
                Consumer<RegisterPageOneBloc>(
                  builder: (context, bloc, child) => CommonTextFieldView(
                    labelText: NAME,
                    onChanged: (text) {
                      bloc.onNameChange(text);
                    },
                  ),
                ),
                SizedBox(height: scaleWidth(context) / 10),
                Consumer<RegisterPageOneBloc>(
                  builder: (context, bloc, child) => CommonTextFieldView(
                    labelText: CONTACT_NUMBER,
                    onChanged: (text) {
                      bloc.onContactNumberChange(text);
                    },
                  ),
                ),
                SizedBox(height: scaleWidth(context) / 10),
                Consumer<RegisterPageOneBloc>(
                  builder: (context, bloc, child) => CommonTextFieldView(
                    labelText: SHIPPING_ADDRESS,
                    onChanged: (text) {
                      bloc.onShippingAddressChange(text);
                    },
                  ),
                ),
                SizedBox(height: scaleWidth(context) / 6),
                Consumer<RegisterPageOneBloc>(
                  builder: (context, bloc, child) => ButtonForRegisterAndLogin(
                    buttonColor: (bloc.isUnlockNextButton)
                        ? APP_THEME_COLOR
                        : Colors.black12,
                    text: "Next",
                    onTap: () {
                      if (bloc.isUnlockNextButton) {
                        navigateToScreen(
                          context,
                          RegisterPageTwo(
                            name: bloc.name,
                            contactNumber: bloc.contactNumber,
                            shippingAddress: bloc.shippingAddress,
                          ),
                        );
                        //);
                      }
                    },
                  ),
                ),
                SizedBox(height: scaleWidth(context) / 15),
                RemindTextViewToSignIn(
                  question: "Do you have an account? ",
                  instruction: "Sign in.",
                  onTapButton: () {
                    navigateToScreen(context, const LoginPage());
                  },
                ),
                SizedBox(height: scaleWidth(context) / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RemindTextViewToSignIn extends StatelessWidget {
  String question;
  String instruction;
  Function onTapButton;
  RemindTextViewToSignIn({
    super.key,
    required this.instruction,
    required this.question,
    required this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 10),
      child: Row(
        children: [
          Text(question),
          GestureDetector(
            onTap: () {
              onTapButton();
            },
            child: Text(
              instruction,
              style: const TextStyle(
                color: APP_THEME_COLOR,
                decoration: TextDecoration.underline,
                decorationColor: APP_THEME_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonForRegisterAndLogin extends StatelessWidget {
  String text;
  Function onTap;
  Color buttonColor;
  ButtonForRegisterAndLogin({
    super.key,
    required this.text,
    required this.onTap,
    this.buttonColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(buttonColor),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 10,
          ),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: FONT_LARGE - 4,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class TitleForRegisterAndLoginView extends StatelessWidget {
  String title;
  Color titleColor;
  TitleForRegisterAndLoginView({
    super.key,
    required this.title,
    this.titleColor = APP_THEME_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: titleColor,
        fontSize: FONT_LARGE,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CommonTextFieldView extends StatefulWidget {
  String labelText;
  String? predefinedText;
  Function(String) onChanged;
  bool secure;

  CommonTextFieldView({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.secure = false,
    this.predefinedText,
  });

  @override
  State<CommonTextFieldView> createState() => _CommonTextFieldViewState();
}

class _CommonTextFieldViewState extends State<CommonTextFieldView> {
  var myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      myController.text = widget.predefinedText ?? "";
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
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
      child: TextFormField(
        controller: myController,
        obscureText: widget.secure,
        onChanged: (text) {
          widget.onChanged(text);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: scaleWidth(context) / 30,
            vertical: scaleWidth(context) / 40,
          ),
          isDense: true,
          isCollapsed: false,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: APP_THEME_COLOR,
            fontWeight: FontWeight.w400,
            fontSize: FONT_MEDIUM,
          ),
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
