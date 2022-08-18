import 'package:flutter/material.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class BaseScreenView extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Future<bool>? onWillPop;

  const BaseScreenView({Key? key, required this.child, this.backgroundColor, this.onWillPop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollsToTop(
      onScrollsToTop: (_) async {},
      child: Scaffold(
        body: Container(
          color: backgroundColor ?? Colors.white,
          child: SafeArea(
            child: Container(
              color: backgroundColor ?? Colors.white,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> defaultOnWillPop() {
    return Future.value(true);
  }
}
