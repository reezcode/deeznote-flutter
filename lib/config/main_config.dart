import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../app/domain/di/controllers/universal_controller.dart';
import '../common/styles/color_scheme.dart';

class MainConfig {
  /// DEFAULT VARIABLES
  static String baseURL = 'https://103.134.154.129/';
  static GetStorage storage = GetStorage();
  static String kDefaultNetworkImagePlaceholder =
      'https://via.placeholder.com/150';
  static String kDefaultAssetImagePlaceholder =
      'assets/images/img_bg_onboarding.png';
  static double kDefaultMargin = 20;
  static double kDefaultPadding = 20;
  static double kDefaultRadius = 10.0;
  static double kDefaultRounded = 100.0;

  /// UNIVERSAL CONTROLLER
  static UniversalController universalController = Get.find();

  /// ADDITIONAL CONFIGURATION
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ripple
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = RsColorScheme.primary
      ..backgroundColor = RsColorScheme.background
      ..indicatorColor = RsColorScheme.primary
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = RsColorScheme.text.withOpacity(0.5)
      ..userInteractions = true
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..dismissOnTap = false;
  }

  static CurrencyFormat idrSetting = const CurrencyFormat(
    symbol: 'Rp',
    symbolSide: SymbolSide.left,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );
}
