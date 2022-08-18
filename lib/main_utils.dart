import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'app/config/env_config.dart';
import 'app/data/constants/constants.dart';
import 'app/data/storage/storage_manager.dart';
import 'app/services/connectivity_service.dart';
import 'app/services/core/constants/remote_constant.dart';
import 'app/services/core/core_service.dart';
import 'app/services/core/storage/core_storage_manager.dart';
import 'app/services/loading_dialog_service.dart';
import 'main_app.dart';


class MainUtils {
  Future<void> initServices({required Flavor flavor}) async {
    WidgetsFlutterBinding.ensureInitialized();

    ///Initiate Get Storage
    await StorageManager().initGetStorage();
    await CoreStorageManager().initGetStorage();

    ///Set base url
    final environment = EnvConfig(flavor);
    AppConstants.currentFlavor = flavor;
    final storedBaseUrl = StorageManager().getBaseUrl();
    if (storedBaseUrl.startsWith('http://')) {
      CoreRemoteConstants.baseUrl = storedBaseUrl;
    } else {
      CoreRemoteConstants.baseUrl = environment.baseUrl;
      StorageManager().setBaseUrl(CoreRemoteConstants.baseUrl);
    }

    ///
    await initServicesAsync();

    ///
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      MainApp(),
    );
  }

  Future<void> initCoreService() async {
    CoreRemoteConstants.baseUrl = StorageManager().getBaseUrl();
    ///Core service for RESTful api
    final coreService = await Get.putAsync<CoreService>(() async => CoreService());
    coreService.setUpHeader({
      CoreRemoteConstants.acceptPlatformHeaderKey: Platform.isIOS ? 'ios' : 'android',
      CoreRemoteConstants.acceptLanguageHeaderKey: 'vi',
    });
    coreService.setBaseURL();

    ///Set token if logged in
    if (StorageManager().getIsLoggedIn()) {
      coreService.setUpHeader({
        CoreRemoteConstants.accessTokenHeaderKey: CoreStorageManager().getToken(),
      });
    }

    ///
    // coreService.handleUnauthorizedError = () async {
    //   HomeController homeController = Get.put(HomeController());
    //   await homeController.stopLocationListener();
    //   Get.offAllNamed(Routes.LOGIN);
    // };
  }

  Future<void> initServicesAsync() async {
    initCoreService();

    ///Connectivity service for checking internet connection
    await Get.putAsync<ConnectivityService>(() async => ConnectivityService());

    ///
    ///Loading dialog service
    await Get.putAsync<LoadingDialogService>(() async => LoadingDialogService());
  }
}
