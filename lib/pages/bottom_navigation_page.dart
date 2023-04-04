import 'package:flutter/material.dart';
import 'package:medical_family_app/constants/colors/colors.dart';
import 'package:medical_family_app/pages/home_page.dart';
import 'package:medical_family_app/pages/pre_order_page.dart';
import 'package:medical_family_app/pages/product_line_new_version_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
  });

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentIndex = 0;

  late List<Widget> screens = [
    HomePage(),
    ProductLineNewVersionPage(),
    PreOrderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        selectedItemColor: APP_THEME_COLOR,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white10,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.bar_chart_outlined,
            ),
            label: "Product Line",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.auto_awesome_motion,
            ),
            label: "Pre Order",
          ),
        ],
      ),
    );
  }
}
