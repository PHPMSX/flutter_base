

import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../bases/base_controller.dart';


class SplashScreenController extends BaseController {

  late BuildContext context;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      _navigateToHome();

    });
  }

  @override
  void onReady() {
    super.onReady();
    print('aaaaaaaâ');
  }

  void _navigateToHome() async {
    Get.offAllNamed(Routes.HOME);
  }
}
