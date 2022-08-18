/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  AssetGenImage get icBack => const AssetGenImage('assets/icons/ic_back.png');
  AssetGenImage get icCancelledRequest =>
      const AssetGenImage('assets/icons/ic_cancelled_request.png');
  AssetGenImage get icDoneRequest =>
      const AssetGenImage('assets/icons/ic_done_request.png');
  AssetGenImage get icDoubleArrow =>
      const AssetGenImage('assets/icons/ic_double_arrow.png');
  AssetGenImage get icEditOutline =>
      const AssetGenImage('assets/icons/ic_edit_outline.png');
  AssetGenImage get icErrorLarge =>
      const AssetGenImage('assets/icons/ic_error_large.png');
  AssetGenImage get icErrorOutline =>
      const AssetGenImage('assets/icons/ic_error_outline.png');
  AssetGenImage get icFailedRequest =>
      const AssetGenImage('assets/icons/ic_failed_request.png');
  AssetGenImage get icFilter =>
      const AssetGenImage('assets/icons/ic_filter.png');
  SvgGenImage get icGoogle => const SvgGenImage('assets/icons/ic_google.svg');
  AssetGenImage get icGpsMapPin =>
      const AssetGenImage('assets/icons/ic_gps_map_pin.png');
  AssetGenImage get icInProgressRequest =>
      const AssetGenImage('assets/icons/ic_in_progress_request.png');
  AssetGenImage get icInputSuffix =>
      const AssetGenImage('assets/icons/ic_input_suffix.png');
  AssetGenImage get icLogout =>
      const AssetGenImage('assets/icons/ic_logout.png');
  AssetGenImage get icLogoutRedOutline =>
      const AssetGenImage('assets/icons/ic_logout_red_outline.png');
  AssetGenImage get icMaps => const AssetGenImage('assets/icons/ic_maps.png');
  AssetGenImage get icMediaCamera =>
      const AssetGenImage('assets/icons/ic_media_camera.png');
  AssetGenImage get icMediaGallery =>
      const AssetGenImage('assets/icons/ic_media_gallery.png');
  AssetGenImage get icMediaPhoto =>
      const AssetGenImage('assets/icons/ic_media_photo.png');
  AssetGenImage get icMediaVideo =>
      const AssetGenImage('assets/icons/ic_media_video.png');
  AssetGenImage get icMeetingMarker =>
      const AssetGenImage('assets/icons/ic_meeting_marker.png');
  AssetGenImage get icNewRequest =>
      const AssetGenImage('assets/icons/ic_new_request.png');
  AssetGenImage get icNotification =>
      const AssetGenImage('assets/icons/ic_notification.png');
  AssetGenImage get icNotificationItem =>
      const AssetGenImage('assets/icons/ic_notification_item.png');
  AssetGenImage get icProfileCircle =>
      const AssetGenImage('assets/icons/ic_profile_circle.png');
  AssetGenImage get icProfileInfo =>
      const AssetGenImage('assets/icons/ic_profile_info.png');
  AssetGenImage get icRequest =>
      const AssetGenImage('assets/icons/ic_request.png');
  AssetGenImage get icResult =>
      const AssetGenImage('assets/icons/ic_result.png');
  AssetGenImage get icSaleMarker =>
      const AssetGenImage('assets/icons/ic_sale_marker.png');
  AssetGenImage get icSearch =>
      const AssetGenImage('assets/icons/ic_search.png');
  AssetGenImage get icShare => const AssetGenImage('assets/icons/ic_share.png');
  AssetGenImage get icStarFilled =>
      const AssetGenImage('assets/icons/ic_star_filled.png');
  AssetGenImage get icStarOutlined =>
      const AssetGenImage('assets/icons/ic_star_outlined.png');
  AssetGenImage get icStatistic =>
      const AssetGenImage('assets/icons/ic_statistic.png');
  AssetGenImage get icUpload =>
      const AssetGenImage('assets/icons/ic_upload.png');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get imgHomeBackground =>
      const AssetGenImage('assets/images/img_home_background.png');
  AssetGenImage get imgLogoWhite =>
      const AssetGenImage('assets/images/img_logo_white.png');
  AssetGenImage get imgSplash =>
      const AssetGenImage('assets/images/img_splash.png');
  AssetGenImage get imgSplashLogo =>
      const AssetGenImage('assets/images/img_splash_logo.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
