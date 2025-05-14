import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz_kitoblari/pages/sample_page.dart';
import '../controllers/get_controller.dart';
import 'onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    Future.delayed(const Duration(seconds: 3), () {
      if (GetStorage().read('token') != null) {
        Get.off(SamplePage());
      } else {
        Get.off(const OnboardingPage());
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/svgImages/logo.svg'),
            SizedBox(height: _getController.height.value * 0.03),
            SizedBox(
              width: _getController.width.value * 0.1,
              height: _getController.width.value * 0.05,
              child: SpinKitThreeBounce(
                color: Colors.amberAccent,
                size: _getController.width.value * 0.06,
                duration: const Duration(milliseconds: 700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
