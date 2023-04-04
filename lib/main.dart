// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medical_family_app/data/vo_models/cart_item_vo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_family_app/data/vo_models/custom_pre_order_item_vo.dart';
import 'package:medical_family_app/data/vo_models/pre_order_item_vo.dart';
import 'package:medical_family_app/pages/splash_screen_page.dart';
import 'package:medical_family_app/persistence/hive/hive_constants.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemVOAdapter());
  Hive.registerAdapter(PreOrderItemVOAdapter());
  Hive.registerAdapter(CustomPreOrderItemVOAdapter());
  await Hive.openBox<CartItemVO>(BOX_NAME_CART_ITEM_VO);
  await Hive.openBox<PreOrderItemVO>(BOX_NAME_PRE_ORDER_ITEM_VO);
  await Hive.openBox<CustomPreOrderItemVO>(BOX_NAME_CUSTOM_PRE_ORDER_ITEM_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
