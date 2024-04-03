import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/prebuilt/rs_photo_view.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/meeting_photo_controller.dart';

class MeetingPhotoView extends GetView<MeetingPhotoController> {
  const MeetingPhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => RsScaffold(
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
              child: controller.photoList.isNotEmpty
                  ? Wrap(
                      children: controller.photoList
                          .map(
                            (e) => RsPhotoView(
                              imgSrc: NetworkImage(e['fileLink']),
                              child: Container(
                                width: 98.w,
                                height: 98.w,
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  color: RsColorScheme.primary,
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: NetworkImage(e['fileLink']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible:
                                          controller.args['status_code'] == 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.removePhoto(
                                              e['idFileContainer']);
                                        },
                                        child: Container(
                                          width: 24.w,
                                          height: 24.w,
                                          margin: EdgeInsets.all(4.w),
                                          child: Image.asset(
                                              'assets/icons/ic_delete.png'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Center(
                      child: Text(
                        "No photo available",
                        style: RsTextStyle.bold.copyWith(fontSize: 14.sp),
                      ),
                    ),
            ),
            Visibility(
              visible: controller.args['status_code'] == 1,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RsButton(
                          radius: 10.r,
                          width: RsScreen.w * 0.4,
                          buttonColor: RsColorScheme.primaryLight,
                          margin: EdgeInsets.only(bottom: 32.h),
                          onTap: controller.choosePhoto,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Choose File",
                                style: RsTextStyle.bold.copyWith(
                                    fontSize: 13.sp,
                                    color: RsColorScheme.primary),
                              ),
                              4.gW,
                              Icon(
                                Icons.photo,
                                size: 21.w,
                                color: RsColorScheme.primary,
                              )
                            ],
                          )),
                      8.gW,
                      RsButton(
                          radius: 10.r,
                          width: RsScreen.w * 0.4,
                          margin: EdgeInsets.only(bottom: 32.h),
                          onTap: controller.submitPhoto,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Save Changes",
                                style: RsTextStyle.bold.copyWith(
                                    fontSize: 13.sp, color: Colors.white),
                              ),
                              4.gW,
                              Icon(
                                Icons.save_rounded,
                                size: 21.w,
                                color: Colors.white,
                              )
                            ],
                          ))
                    ],
                  )),
            )
          ],
        )));
  }
}
