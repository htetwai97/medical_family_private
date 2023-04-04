import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';
import 'package:medical_family_app/constants/scale/scale_dimension.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/my_profile_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';
import 'package:medical_family_app/pages/register_page_one.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Contact Us",
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: scaleWidth(context) / 20,
                vertical: scaleWidth(context) / 20,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: scaleWidth(context) / 40,
                vertical: scaleWidth(context) / 20,
              ),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer,
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  IconAndInfoView(
                    infoFont: FONT_LARGE - 4,
                    spacing: scaleWidth(context) / 10,
                    icon: Icons.phone,
                    heading: "",
                    info:
                        "+95 9 44 88 33 457 ,\n+ 95 9 44 88 33 467 ,\n09 777005863, \n09 777005864",
                  ),
                  SizedBox(height: scaleWidth(context) / 20),
                  IconAndInfoView(
                    infoFont: FONT_LARGE - 4,
                    spacing: scaleWidth(context) / 10,
                    icon: Icons.location_on,
                    heading: "",
                    info:
                        "No.28, \nHlaing Yadanar Mon 3rd Street,\nHlaing Yadanar Mon Avenue,\nHlaing Township, Yangon",
                  ),
                  SizedBox(height: scaleWidth(context) / 20),
                  IconAndInfoView(
                    infoFont: FONT_LARGE - 4,
                    spacing: scaleWidth(context) / 10,
                    icon: Icons.email,
                    heading: "",
                    info: "information.medicalworld\n@gmail.com",
                  ),
                  SizedBox(height: scaleWidth(context) / 10),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: scaleWidth(context) / 10,
                vertical: scaleWidth(context) / 20,
              ),
              child: CommonTextFieldView(
                labelText: "Name",
                onChanged: (name) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: scaleWidth(context) / 10,
                vertical: scaleWidth(context) / 20,
              ),
              child: CommonTextFieldView(
                labelText: "Email",
                onChanged: (email) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: scaleWidth(context) / 10,
                vertical: scaleWidth(context) / 20,
              ),
              child: SizedBox(
                height: scaleWidth(context) / 2,
                child: SearchTextFieldView(
                  isDense: false,
                  isMessageSection: true,
                  maxLines: 14,
                  onSearchDone: (message) {},
                  hintText: "Send us a message",
                ),
              ),
            ),
            SizedBox(height: scaleWidth(context) / 20),
            CommonAppButton(
              textFont: FONT_LARGE,

              text: "Submit",
              onTap: () {},
            ),
            SizedBox(height: scaleWidth(context) / 20),
          ],
        ),
      ),
    );
  }
}
