import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../data/constants/custom_colors.dart';
import '../utils/custom_modal_configuration.dart';
import '../utils/logger/logger_service.dart';

class LoadingDialogService extends GetxService {
  final loadingOverlayVisible = false.obs;
  bool _modalVisible = false;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    LoggerService.log.i('onInit loading dialog service');
    ever(loadingOverlayVisible, (callback) {
      if (loadingOverlayVisible.isTrue) {
        _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
          if (_modalVisible) {
            Get.back();
          }
          _timer?.cancel();
        });
        _showLoadingOverlay();
      } else {
        if (_modalVisible) {
          Get.back();
          _timer?.cancel();
        }
      }
    });
  }

  void _showLoadingOverlay() {
    _modalVisible = true;
    showModal(
        context: Get.context!,
        configuration:
             const BlurFadeScaleTransitionConfiguration(
                barrierDismissible: false, blurSigma: 6.0, barrierColor: CustomColors.white_op_30),
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: WillPopScope(
              onWillPop: () async => false,
              child: const SizedBox(
                width: 175,
                height: 175,
                child:  SpinKitChasingDots(
                  color: CustomColors.red_01,
                  size: 100,
                ),
              ),
            ),
          );
        }).then((value) {
      _modalVisible = false;
    });
  }
}

class LoadingDialogUtils {
  void loadingOverlayVisible({required bool visible}) {
    if (visible) {
      Get.find<LoadingDialogService>().loadingOverlayVisible.value = true;
    } else {
      Get.find<LoadingDialogService>().loadingOverlayVisible.value = false;
    }
  }
}
