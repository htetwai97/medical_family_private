import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/scale/font_sizes.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            size: FONT_LARGE,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Available Preorder Brands",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: FONT_LARGE,
          ),
        ),
      ),
    );
  }
}
