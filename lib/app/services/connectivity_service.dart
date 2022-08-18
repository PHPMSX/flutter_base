import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/constants/custom_colors.dart';
import '../utils/logger/logger_service.dart';


class ConnectivityService extends GetxService {
  bool isShowingDialog = false;

  @override
  void onInit() async {
    super.onInit();
    var result = await Connectivity().checkConnectivity();
    ///Checking connectivity result from Connectivity
    ///If has no connection
    if (result == ConnectivityResult.none) {
      isShowingDialog = true;
      _showDialog();
    }

    ///Init onConnectivityChanged listener
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        ///No internet
        isShowingDialog = true;
        LoggerService.log.i('No connection');
        _showDialog();
      } else {
        LoggerService.log.i('Connected...');
        if (isShowingDialog) {
          ///If dialog/screen is showing => pop back
          LoggerService.log.i('Handle back to current screen');
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Get.back();
          });
          isShowingDialog = false;
        }
      }
    });
  }

  void _showDialog() {
    Get.snackbar('no_internet'.tr, '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: const LinearGradient(
            colors: [CustomColors.grey_112, CustomColors.red_01]),
        backgroundColor: Colors.black.withOpacity(0.75),
        margin: const EdgeInsets.only(bottom: 60),
        colorText: Colors.white,
        isDismissible: true,
        icon: const Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        snackStyle: SnackStyle.FLOATING,
        snackbarStatus: (status) {
          if (status == SnackbarStatus.OPEN) {
            isShowingDialog = true;
          }
          if (status == SnackbarStatus.CLOSED) {
            isShowingDialog = false;
          }
        },
        duration: const Duration(hours: 1) ///Set long duration
    );
  }
}
