import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/extensions/widget.dart';
import 'package:deeznote/common/utils/format_date.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/browser.dart';
import '../../../../common/utils/screen.dart';
import '../controllers/detail_meet_controller.dart';

class DetailMeetView extends GetView<DetailMeetController> {
  const DetailMeetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => RsScaffold(
          useSafeArea: false,
          appbar: AppBar(
            shadowColor: Colors.transparent,
            centerTitle: false,
            titleSpacing: 0,
            title: Text(
              "Meeting Detail",
              style: RsTextStyle.bold
                  .copyWith(color: Colors.white, fontSize: 18.sp),
            ),
            backgroundColor: RsColorScheme.primary,
          ),
          bgColor: RsColorScheme.primary,
          body: WillPopScope(
            onWillPop: () async {
              Get.back();
              Get.back();
              return true;
            },
            child: ListView(
              children: [
                Container(
                    width: RsScreen.w * 0.75.w,
                    height: RsScreen.w * 0.4.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.meetData['meetTitle'] ?? "-",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: RsTextStyle.extraBold.copyWith(
                                fontSize: 18.sp, color: Colors.white)),
                        Text(
                          controller.meetData['customerName'] ?? '-',
                          style: RsTextStyle.semiBold
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                        Text(
                          formatDateTime(
                              controller.meetData['meetDate'] ??
                                  DateTime.now().toString(),
                              true),
                          style: RsTextStyle.medium
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                        8.gH,
                        RsButton(
                            width: RsScreen.w * 0.4.w,
                            buttonColor: RsColorScheme.secondary,
                            radius: 10.r,
                            onTap: controller.startMeet,
                            isDisabled: !(controller.isCanStartMeet.value &&
                                !controller.isNotulensiExist.value),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Start Meeting",
                                  style: RsTextStyle.bold
                                      .copyWith(fontSize: 14.sp),
                                ),
                                4.gW,
                                Icon(Icons.video_call_rounded, size: 24.w)
                              ],
                            ))
                      ],
                    ).loader(controller.isLoading.value)),
                RsBottomSheet(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Meet Details",
                        style: RsTextStyle.bold.copyWith(
                            color: RsColorScheme.text, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                      8.gH,
                      ...controller.meetDetail
                          .map((e) => RsCardListDetail(
                                icon: e['icon'],
                                title: e['title'],
                                type: e['type'],
                                description: e['description'],
                                onTap: () {
                                  openBrowser(Uri.parse(
                                      e['url'] ?? 'http://google.com'));
                                },
                              ))
                          .toList(),
                      16.gH,
                      ...controller.buttonDetail
                          .map((e) => RsCardSettingMenu(
                              icon: e['icon'],
                              title: e['title'],
                              isEnabled: e['isEnabled'],
                              description: e['description'],
                              onTap: e['onTap']))
                          .toList(),
                      Visibility(
                        visible: controller.isSigned.value &&
                            controller.statusCode.value == 1,
                        child: RsButton(
                            width: RsScreen.w,
                            radius: 10.r,
                            splashColor: RsColorScheme.secondary,
                            onTap: controller.finishMeet,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Finish Meet",
                                  style: RsTextStyle.bold.copyWith(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                                4.gW,
                                Icon(
                                  Icons.check,
                                  size: 21.w,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Visibility(
                              visible: controller.statusCode.value == 0,
                              child: RsButton(
                                  width: RsScreen.w,
                                  radius: 10.r,
                                  splashColor: RsColorScheme.secondary,
                                  onTap: controller.editMeet,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Edit Meet",
                                        style: RsTextStyle.bold.copyWith(
                                            fontSize: 14.sp,
                                            color: Colors.white),
                                      ),
                                      4.gW,
                                      Icon(
                                        Icons.edit,
                                        size: 21.w,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Visibility(
                              visible: controller.statusCode.value != 1,
                              child: RsButton(
                                  width: RsScreen.w,
                                  radius: 10.r,
                                  buttonColor: RsColorScheme.danger,
                                  splashColor: RsColorScheme.secondary,
                                  onTap: controller.deleteMeet,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Delete Meet",
                                        style: RsTextStyle.bold.copyWith(
                                            fontSize: 14.sp,
                                            color: Colors.white),
                                      ),
                                      4.gW,
                                      Icon(
                                        Icons.delete_forever,
                                        size: 21.w,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )
                    ].loader(loading: controller.isLoading.value, count: 6))
              ],
            ),
          ),
        ));
  }
}
