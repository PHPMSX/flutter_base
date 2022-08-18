import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/loading_dialog_service.dart';
import '../utils/custom_modal_configuration.dart';
import '../utils/dialog_utils.dart';


class BaseController extends GetxController with StateMixin {
  @override
  void onInit() {
    super.onInit();
    ever(isLoading, (_) {
      if (isLoading.isTrue) {
        LoadingDialogUtils().loadingOverlayVisible(visible: true);
      } else {
        LoadingDialogUtils().loadingOverlayVisible(visible: false);
      }
    });
  }

  final isLoading = false.obs;
  bool isErrorShowing = false;

  void showErrorMessage({required String errorMessage, VoidCallback? onTap}) {
    if (isErrorShowing) return;
    isErrorShowing = true;
    showModal(
        context: Get.context!,
        configuration:
            const BlurFadeScaleTransitionConfiguration(barrierDismissible: true, blurSigma: 6.0),
        builder: (context) {
          return DialogUtils().errorDialog(errorMessage: errorMessage, onTap: onTap);
        }).then((value) {
      isErrorShowing = false;
    });
  }
}
