import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/meeting_photo_controller.dart';

class MeetingPhotoView extends GetView<MeetingPhotoController> {
  const MeetingPhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
        useSafeArea: false,
        bgColor: Colors.white,
        appbar: AppBar(
          shadowColor: Colors.transparent,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            "Meeting Documentation",
            style:
                RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
          ),
          backgroundColor: RsColorScheme.primary,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: RsUploadMulti(),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: RsButton(
                    radius: 10.r,
                    width: RsScreen.w * 0.8,
                    margin: EdgeInsets.only(bottom: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Save Changes",
                          style: RsTextStyle.bold
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                        4.gW,
                        Icon(
                          Icons.add_circle,
                          size: 21.w,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onTap: () {}))
          ],
        ));
  }
}
