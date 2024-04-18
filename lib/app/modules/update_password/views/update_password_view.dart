import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:deeznote/config/form_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      body: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(30.w),
            margin: EdgeInsets.all(20.w),
            height: RsScreen.h * 0.55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r), color: Colors.white),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Password",
                      style: RsTextStyle.bold
                          .copyWith(fontSize: 21.sp, color: RsColorScheme.text),
                    ),
                    24.gH,
                    RsFormContainer(
                      action: FormAction.update,
                      config: FormConfig().updatePasswordForm,
                      buttonText: "Update",
                      icon: Icons.save_rounded,
                      onUpdate: controller.onUpdate,
                    )
                  ],
                ),
              ),
            ),
          )),
      useSafeArea: true,
      bgColor: RsColorScheme.primary,
    );
  }
}
