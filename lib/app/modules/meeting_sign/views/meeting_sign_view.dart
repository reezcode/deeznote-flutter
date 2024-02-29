import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/meeting_sign_controller.dart';

class MeetingSignView extends GetView<MeetingSignController> {
  const MeetingSignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
        useSafeArea: false,
        bgColor: RsColorScheme.primary,
        appbar: AppBar(
          shadowColor: Colors.transparent,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            "Meeting Sign",
            style:
                RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
          ),
          backgroundColor: RsColorScheme.primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please Sign Here",
                style: RsTextStyle.bold
                    .copyWith(fontSize: 21.sp, color: Colors.white),
              ),
              32.gH,
              SizedBox(
                height: 300,
                width: 300,
                child: SfSignaturePad(
                  key: controller.signaturePadKey,
                  backgroundColor: Colors.white,
                ),
              ),
              32.gH,
              RsButton(
                width: RsScreen.w * 0.65.w,
                buttonColor: RsColorScheme.secondary,
                radius: 10.r,
                onTap: controller.submitSign,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: RsColorScheme.text,
                    ),
                    8.gW,
                    Text(
                      "Submit",
                      style: RsTextStyle.bold
                          .copyWith(color: RsColorScheme.text, fontSize: 16.sp),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
