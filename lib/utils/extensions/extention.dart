import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/colors/colors.dart';

extension NavigationUtility on Widget {
  void navigateToScreen(BuildContext context, Widget nextScreen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  void showSnackBarWithMessage(
      BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: (isSuccess == false)?Colors.black87:APP_THEME_COLOR,
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          style:
              TextStyle(color: (isSuccess == false) ? Colors.red : Colors.white),
        ),
      ),
    );
  }
}
