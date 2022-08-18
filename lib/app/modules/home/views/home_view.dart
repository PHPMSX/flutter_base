import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_base/app/data/storage/storage_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/custom_colors.dart';
import '../../../data/constants/custom_text_styles.dart';
import '../../../widgets/custom_animated_widgets.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        body: WillPopScope(
          onWillPop: onWillPop,
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: CustomColors.white_op_30),
                ),
                Positioned.fill(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _buildLogo(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 60),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: Column(
                                children: [
                                  Text(StorageManager().getBaseUrl()),
                                  const Text(
                                    'You have pushed the button this many times:',
                                  ),
                                  Obx(() => Text(
                                        '${controller.counter}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // Fluttertoast.showToast(msg: 'exit_warning'.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _buildLogo() {
    return CustomAnimatedWidgets().fadeSlideIn(
      position: 0,
      verticalOffset: -50,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Demo Base GETX'),
          ],
        ),
      ),
    );
  }
}
