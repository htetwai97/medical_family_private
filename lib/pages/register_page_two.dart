// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/register_page_two_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/pages/login_page.dart';
import 'package:medical_family_app/pages/register_page_one.dart';
import 'package:medical_family_app/utils/extensions/extention.dart';
import 'package:medical_family_app/utils/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class RegisterPageTwo extends StatelessWidget {
  String? name;
  String? contactNumber;
  String? shippingAddress;
  RegisterPageTwo({
    Key? key,
    required this.name,
    required this.shippingAddress,
    required this.contactNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterPageTwoBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Selector<RegisterPageTwoBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: scaleWidth(context) / 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: scaleWidth(context) / 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/intro_image_four.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: scaleWidth(context) / 12),
                      TitleForRegisterAndLoginView(
                        title: "Ready to sign up?..",
                        titleColor: Colors.black,
                      ),
                      SizedBox(height: scaleWidth(context) / 8),
                      Consumer<RegisterPageTwoBloc>(
                        builder: (context, bloc, child) => CommonTextFieldView(
                          labelText: USER_NAME,
                          onChanged: (text) {
                            bloc.onUserNameChange(text);
                          },
                        ),
                      ),
                      SizedBox(height: scaleWidth(context) / 10),
                      Consumer<RegisterPageTwoBloc>(
                        builder: (context, bloc, child) => CommonTextFieldView(
                          labelText: EMAIL,
                          onChanged: (text) {
                            bloc.onEmailChange(text);
                          },
                        ),
                      ),
                      SizedBox(height: scaleWidth(context) / 10),
                      Consumer<RegisterPageTwoBloc>(
                        builder: (context, bloc, child) => CommonTextFieldView(
                          labelText: PASSWORD,
                          secure: true,
                          onChanged: (text) {
                            bloc.onPasswordChange(text);
                          },
                        ),
                      ),
                      SizedBox(height: scaleWidth(context) / 8),
                      Consumer<RegisterPageTwoBloc>(
                        builder: (context, bloc, child) =>
                            ButtonForRegisterAndLogin(
                          buttonColor: (bloc.isUnlockRegisterButton)
                              ? APP_THEME_COLOR
                              : Colors.black12,
                          text: "Register",
                          onTap: () {
                            if (bloc.isUnlockRegisterButton) {
                              bloc
                                  .onTapRegisterButton(
                                      name, contactNumber, shippingAddress)
                                  .then(
                                    (value) => navigateToScreen(
                                      context,
                                      const LoginPage(),
                                    ),
                                  )
                                  .catchError((error) {
                                showSnackBarWithMessage(
                                    context, error.toString(), false);
                              });
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
                Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black12,
                    padding: EdgeInsets.symmetric(vertical: scaleWidth(context)/1.3),
                    child: const Center(
                      child: LoadingView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
