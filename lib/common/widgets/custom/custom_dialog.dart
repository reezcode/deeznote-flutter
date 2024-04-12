import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/screen.dart';

class RsDialog {
  static void show({required List<Widget> children, double? height}) {
    Get.dialog(
      barrierDismissible: true,
      useSafeArea: true,
      Center(
        child: Container(
          width: RsScreen.w * 0.9,
          height: height ?? RsScreen.h * 0.5,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: ListView(
            children: children,
          ),
        ),
      ),
    );
  }
}
