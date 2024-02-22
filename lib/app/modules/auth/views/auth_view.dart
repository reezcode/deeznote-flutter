import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/config/form_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/screen.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: RsScreen.w * 0.75.w,
              height: RsScreen.w * 0.7.w,
              margin: EdgeInsets.only(bottom: 300.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icons/ic_logo.png',
                    width: 120.w,
                  ),
                  10.gH,
                  Text(
                    "Effortless Meeting Minutes: Capture, Collaborate, Conquer",
                    style: RsTextStyle.medium,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: RsBottomSheet(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: RsTextStyle.extraBold
                          .copyWith(color: RsColorScheme.text, fontSize: 24.sp),
                      textAlign: TextAlign.center,
                    ),
                    18.gH,
                    RsFormContainer(
                        action: FormAction.read,
                        config: FormConfig().loginForm,
                        icon: Icons.arrow_right_rounded,
                        onRead: controller.authLogin,
                        buttonText: "Login"),
                    18.gH,
                    Center(
                      child: Text(
                        "Forgot your password?",
                        style: RsTextStyle.medium.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    38.gH,
                  ]))
        ],
      ),
      useSafeArea: false,
      bgImg: 'assets/images/img_bg_auth.png',
    );
  }
}
