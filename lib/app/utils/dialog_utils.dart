import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/constants/custom_colors.dart';
import '../data/constants/custom_text_styles.dart';
import '../gen/assets.gen.dart';

class DialogUtils {
  Widget errorDialog({required String errorMessage, VoidCallback? onTap}) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 0,
      backgroundColor: Colors.white,
      children: [
        Container(
          width: Get.width,
          child: Column(
            children: [
              _buildErrorIcon(),
              _buildErrorTitle(),
              Container(
                margin: const EdgeInsets.only(top: 12, left: 40, right: 40),
                child: Text(errorMessage,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.zeplin8().copyWith(color: CustomColors.grey_90)),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14, right: 14, top: 23, bottom: 17),
                decoration: BoxDecoration(
                    color: CustomColors.red_01, borderRadius: BorderRadius.circular(5.0)),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () {
                      onTap?.call();
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'ok_title'.tr.toUpperCase(),
                        style: CustomTextStyles.zeplin20()
                            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Container _buildErrorTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      child: Text(
        'notification_text'.tr,
        textAlign: TextAlign.center,
        style: CustomTextStyles.zeplin20().copyWith(
          color: CustomColors.grey_90,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container _buildErrorIcon() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Assets.icons.icErrorOutline.image(width: 50, height: 50),
    );
  }

  Widget confirmDialog(
      {required AssetGenImage icon,
      required String title,
      required String description,
      required String negativeTitle,
      required String positiveTitle,
      required VoidCallback onPositiveTap}) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(15),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: icon.image(
            width: 50,
            height: 50,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 13),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: CustomTextStyles.zeplin10().copyWith(
              color: CustomColors.grey_90,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 12,
            left: 50,
            right: 50,
          ),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: CustomTextStyles.zeplin8().copyWith(color: CustomColors.grey_90),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 30),
                decoration: BoxDecoration(
                  color: CustomColors.grey_142,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () => Get.back(),
                    child: Center(
                      child: Text(
                        negativeTitle,
                        style: CustomTextStyles.zeplin20().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 30),
                decoration: BoxDecoration(
                  color: CustomColors.red_01,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: onPositiveTap,
                    child: Center(
                      child: Text(
                        positiveTitle,
                        style: CustomTextStyles.zeplin20().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget mediaDialog({
    required String dialogTitle,
    required AssetGenImage firstIcon,
    required String firstTitle,
    required VoidCallback firstAction,
    required AssetGenImage secondIcon,
    required String secondTitle,
    required VoidCallback secondAction,
  }) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(25),
      children: [
        Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Text(
              dialogTitle,
              style: CustomTextStyles.zeplin8().copyWith(
                fontWeight: FontWeight.bold,
                color: CustomColors.grey_78,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: firstAction,
                      child: firstIcon.image(
                        width: 75,
                        height: 75,
                        color: CustomColors.blue_255,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    firstTitle,
                    style: CustomTextStyles.zeplin8().copyWith(color: CustomColors.grey_90),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: secondAction,
                      child: secondIcon.image(
                        width: 75,
                        height: 75,
                        color: CustomColors.blue_255,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    secondTitle,
                    style: CustomTextStyles.zeplin8().copyWith(color: CustomColors.grey_90),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget cupertinoDateTimePicker() {
    return Container(
      height: Get.height / 3,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'done_text'.tr,
              style: CustomTextStyles.zeplin8(),
            ),
          ),
          Container(
            height: Get.height / 3 - 50,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.dark,
              ),
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.dateAndTime,
                onDateTimeChanged: (picked) {},
                minimumYear: 2000,
                maximumYear: 2025,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoutDialog({required VoidCallback onLogoutClicked}) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(10))),
      elevation: 0,
      backgroundColor: Colors.white,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: Assets.icons.icLogoutRedOutline.image(
            width: 43,
            height: 43,
            color: CustomColors.blue_255
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 13),
          child: Text(
            'logout_text'.tr,
            textAlign: TextAlign.center,
            style: CustomTextStyles.zeplin20().copyWith(
              color: CustomColors.grey_90,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 12,
            left: 50,
            right: 50,
          ),
          child: Text('logout_confirm_text'.tr,
              textAlign: TextAlign.center,
              style: CustomTextStyles.zeplin8().copyWith(color: CustomColors.grey_90)),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 30),
                decoration: BoxDecoration(
                    color: CustomColors.grey_142,
                    borderRadius: BorderRadius.circular(5.0)),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () => Get.back(),
                    child: Center(
                      child: Text(
                        'exit_text'.tr,
                        style: CustomTextStyles.zeplin20().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 30),
                decoration: BoxDecoration(
                    color: CustomColors.red_01, borderRadius: BorderRadius.circular(5.0)),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: onLogoutClicked,
                    child: Center(
                      child: Text(
                        'logout_text'.tr,
                        style: CustomTextStyles.zeplin20().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
