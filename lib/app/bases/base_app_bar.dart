import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widgets/custom_animated_widgets.dart';

class BaseAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPress;
  final Widget? rightAction;

  const BaseAppBar({Key? key, required this.title, required this.onBackPress, this.rightAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedWidgets().fadeSlideIn(
      position: 0,
      horizontalOffset: -50,
      durationInMillisecond: 200,
      child: Container(
        width: Get.width,
        constraints: const BoxConstraints(
          minHeight: 50
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildTitle(),
            _buildBackIcon(),
            Positioned(
              right: 15,
              child: rightAction ?? const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Positioned _buildBackIcon() {
    return Positioned(
      left: 15,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
            borderRadius: BorderRadius.circular(35 / 2),
            onTap: onBackPress,
            // child: Assets.icons.icBack.image(width: 35, height: 35)
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
      child: Text(
        title,
        // '9s8df yus9d8uf 9sd8f us9d8 fusd98 fusd98f us9df8usd9f8usd89',
        textAlign: TextAlign.center,
        // style: CustomTextStyles.zeplin24().copyWith(
        //   color: CustomColors.grey_90,
        //   fontWeight: FontWeight.bold,
        // )
        // ,
      ),
    );
  }
}
