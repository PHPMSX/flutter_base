import 'package:flutter/material.dart';

import 'base_shimmer.dart';

class WidgetUtils {
  Widget baseShimmerCircularAvatar({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: BaseShimmer(
          width: size,
          height: size,
        ),
      ),
    );
  }
}
