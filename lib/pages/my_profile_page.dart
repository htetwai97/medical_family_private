// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/bloc/profile_page_bloc.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfilePageBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: APP_THEME_COLOR,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: FONT_XLARGE,
            ),
          ),
          title: const Text(
            "Account Information",
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_LARGE,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: scaleWidth(context) / 10),
              Image.asset(
                "assets/images/profile_image.png",
                height: scaleWidth(context) / 2,
                fit: BoxFit.contain,
              ),
              SizedBox(height: scaleWidth(context) / 4),
              const UserInfoCollectionView(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoCollectionView extends StatelessWidget {
  const UserInfoCollectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scaleWidth(context) / 10),
      child: Consumer<ProfilePageBloc>(
        builder: (context, bloc, child) => Column(
          children: [
            IconAndInfoView(
              icon: Icons.person,
              heading: "User name",
              info: bloc.userName,
            ),
            SizedBox(height: scaleWidth(context) / 10),
            IconAndInfoView(
              icon: Icons.email,
              heading: "Email",
              info: bloc.email,
            ),
            SizedBox(height: scaleWidth(context) / 10),
            IconAndInfoView(
              icon: Icons.phone,
              heading: "Phone",
              info: bloc.phone,
            ),
            SizedBox(height: scaleWidth(context) / 10),
            IconAndInfoView(
              icon: Icons.location_on,
              heading: "Address",
              info: bloc.address,
            ),
            SizedBox(height: scaleWidth(context) / 20),
          ],
        ),
      ),
    );
  }
}

class IconAndInfoView extends StatelessWidget {
  IconData icon;
  String heading;
  double infoFont;
  String info;
  double spacing;
  IconAndInfoView({
    super.key,
    required this.icon,
    required this.heading,
    required this.info,
    this.spacing = 0,
    this.infoFont = FONT_LARGE - 3,
  });

  @override
  Widget build(BuildContext context) {
    double useSpacing = scaleWidth(context) / 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: scaleWidth(context) / 14,
          width: scaleWidth(context) / 14,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 10,
                blurRadius: 10,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: FONT_XLARGE,
            color: APP_THEME_COLOR,
          ),
        ),
        SizedBox(width: (spacing == 0) ? useSpacing : spacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: FONT_MEDIUM,
                ),
              ),
              Text(
                info,
                style: TextStyle(
                  color: APP_THEME_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: infoFont,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
