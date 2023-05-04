// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/texts/texts.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model.dart';
import 'package:medical_family_app/data/repo_model/medical_world_repo_model_impl.dart';
import 'package:medical_family_app/data/vo_models/design_object_vo.dart';
import 'package:medical_family_app/pages/bottom_navigation_page.dart';
import 'package:medical_family_app/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// app state
  bool? isLogin;

  /// repo model
  MedicalWorldRepoModel model = MedicalWorldRepoModelImpl();

  @override
  void initState() {
    super.initState();

    model.isPreferenceExists(USER_ID).then((value) {
      setState(() {
        isLogin = value;
      });

      model.getDesign("1").then((value) {
        setState(() {
          designListOne = value;
        });

        model.getDesign("2").then((value) {
          setState(() {
            designListTwo = value;
          });

          model.getDesign("3").then((value) {
            setState(() {
              designListThree = value;
            });

            if (isLogin == true) {
              if (designListOne != null &&
                  designListOne!.isNotEmpty &&
                  designListTwo != null &&
                  designListTwo!.isNotEmpty &&
                  designListThree != null &&
                  designListThree!.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavigationPage(),
                  ),
                );
              }
            } else {
              if (designListOne != null &&
                  designListOne!.isNotEmpty &&
                  designListTwo != null &&
                  designListTwo!.isNotEmpty &&
                  designListThree != null &&
                  designListThree!.isNotEmpty) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            }
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/family_logo_image.png'),
      ),
    );
  }
}
