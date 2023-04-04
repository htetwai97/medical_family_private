// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/login_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/pages/bottom_navigation_page.dart';
import 'package:medical_family_app/pages/register_page_one.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginPageBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
            child: Selector<LoginPageBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: scaleWidth(context) / 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: scaleWidth(context) / 6),
                      width: scaleWidth(context),
                      child: Image.asset(
                        "assets/images/family_logo_image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: scaleWidth(context) / 10),
                    TitleForRegisterAndLoginView(
                      title: "Welcome to Medical Family!",
                      titleColor: Colors.black54,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: scaleWidth(context) / 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: scaleWidth(context) / 7),
                          Consumer<LoginPageBloc>(
                            builder: (context, bloc, child) =>
                                CommonTextFieldView(
                              labelText: USER_NAME,
                              onChanged: (text) {
                                bloc.onUserNameChange(text);
                              },
                            ),
                          ),
                          SizedBox(height: scaleWidth(context) / 8),
                          Consumer<LoginPageBloc>(
                            builder: (context, bloc, child) =>
                                CommonTextFieldView(
                              secure: true,
                              labelText: PASSWORD,
                              onChanged: (text) {
                                bloc.onPasswordChange(text);
                              },
                            ),
                          ),
                          SizedBox(height: scaleWidth(context) / 10),
                          Consumer<LoginPageBloc>(
                            builder: (context, bloc, child) =>
                                AgreeTermsAndCondition(
                              onCheck: (isChecked) {
                                bloc.onCheckTermAndCondition(isChecked);
                              },
                            ),
                          ),
                          SizedBox(height: scaleWidth(context) / 20),
                          Consumer<LoginPageBloc>(
                            builder: (context, bloc, child) =>
                                ButtonForRegisterAndLogin(
                              buttonColor: (bloc.isUnlockLoginButton)
                                  ? APP_THEME_COLOR
                                  : Colors.black12,
                              text: "Login",
                              onTap: () {
                                if (bloc.isUnlockLoginButton) {
                                  bloc
                                      .onTapLoginButton()
                                      .then(
                                        (value) => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomNavigationPage(),
                                          ),
                                        ),
                                      )
                                      .catchError(
                                        (error) => showSnackBarWithMessage(
                                            context,
                                            "user name or password wrong,try again!",
                                            false),
                                      );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: scaleWidth(context) / 10),
                          RemindTextViewToSignIn(
                            question: "Don't have an account? ",
                            instruction: "Register.",
                            onTapButton: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPageOne(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  // padding:
                  //     EdgeInsets.symmetric(vertical: scaleWidth(context) / 1.3),
                  child: const Center(
                    child: LoadingView(),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class AgreeTermsAndCondition extends StatefulWidget {
  Function(bool) onCheck;
  AgreeTermsAndCondition({
    super.key,
    required this.onCheck,
  });

  @override
  State<AgreeTermsAndCondition> createState() => _AgreeTermsAndConditionState();
}

class _AgreeTermsAndConditionState extends State<AgreeTermsAndCondition> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (e) {
            setState(() {
              value = e ?? false;
              widget.onCheck(e ?? false);
            });
          },
        ),
        SizedBox(
          width: scaleWidth(context) / 40,
        ),
        const Text(
          "Agree the terms and conditions.",
          style: TextStyle(
            color: APP_THEME_COLOR,
            fontWeight: FontWeight.w500,
            fontSize: FONT_MEDIUM,
          ),
        )
      ],
    );
  }
}
