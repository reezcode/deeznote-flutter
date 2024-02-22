import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../styles/color_scheme.dart';
import '../../utils/screen.dart';

class RsToast {
  final String title;
  final String message;

  const RsToast({
    required this.title,
    required this.message,
  });

  static show(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      maxWidth: RsScreen.w - 48.w,
      margin: EdgeInsets.only(top: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
      backgroundColor: Colors.white.withOpacity(0.7),
      borderWidth: 1.w,
      borderColor: RsColorScheme.primary.withOpacity(0.1),
      colorText: RsColorScheme.text,
      icon: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Image.asset('assets/icons/ic_logo_square.png'),
      ),
    );
  }
}
