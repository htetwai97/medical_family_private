import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medical_family_app/constants/colors/colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: LoadingIndicator(
            indicatorType: Indicator.ballBeat,
            colors: [Colors.black],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
