import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/env_config.dart';
import 'app/routes/app_pages.dart';
import 'app/services/connectivity_service.dart';
import 'app/utils/translated_string.dart';
import 'main_utils.dart';

void main() async {
  await MainUtils().initServices(flavor: Flavor.STAGING);
  ///Run app
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      ///Set up for localization
      translations: TranslatedString(),
      locale: Get.deviceLocale, ///Get current locale on device
      fallbackLocale: const Locale('vi', 'VN'), /// Default is English
      ///
      debugShowCheckedModeBanner: true,
    ),
  );
}

Future<void> initServices() async {
  ///Connectivity service for checking internet connection
  await Get.putAsync<ConnectivityService>(() async => ConnectivityService());
  ///
}