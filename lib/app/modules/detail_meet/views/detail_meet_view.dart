import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/screen.dart';
import '../controllers/detail_meet_controller.dart';

class DetailMeetView extends GetView<DetailMeetController> {
  const DetailMeetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      useSafeArea: false,
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Meeting Detail",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        backgroundColor: RsColorScheme.primary,
      ),
      bgColor: RsColorScheme.primary,
      body: ListView(
        children: [
          Container(
            width: RsScreen.w * 0.75.w,
            height: RsScreen.w * 0.4.w,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Kick-Off Meeting KPBU",
                    style: RsTextStyle.extraBold
                        .copyWith(fontSize: 18.sp, color: Colors.white)),
                Text(
                  "PT. Hutama Karya PBI",
                  style: RsTextStyle.semiBold
                      .copyWith(fontSize: 14.sp, color: Colors.white),
                ),
                Text(
                  "22 January 2024",
                  style: RsTextStyle.medium
                      .copyWith(fontSize: 14.sp, color: Colors.white),
                ),
                8.gH,
                RsButton(
                    width: RsScreen.w * 0.4.w,
                    buttonColor: RsColorScheme.secondary,
                    radius: 10.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Start Meeting",
                          style: RsTextStyle.bold.copyWith(fontSize: 14.sp),
                        ),
                        4.gW,
                        Icon(Icons.video_call_rounded, size: 24.w)
                      ],
                    ),
                    onTap: () {})
              ],
            ),
          ),
          RsBottomSheet(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Meet Details",
                  style: RsTextStyle.bold
                      .copyWith(color: RsColorScheme.text, fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
                8.gH,
                ...controller.meetDetail
                    .map((e) => RsCardListDetail(
                          icon: e['icon'],
                          title: e['title'],
                          description: e['description'],
                          onTap: () {},
                        ))
                    .toList(),
                16.gH,
                ...controller.buttonDetail
                    .map((e) => RsCardSettingMenu(
                        icon: e['icon'],
                        title: e['title'],
                        description: e['description'],
                        onTap: e['onTap']))
                    .toList(),
                16.gH,
                RsButton(
                    width: RsScreen.w,
                    radius: 10.r,
                    splashColor: RsColorScheme.secondary,
                    onTap: controller.editMeet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edit Meet",
                          style: RsTextStyle.bold
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                        4.gW,
                        Icon(
                          Icons.edit,
                          size: 21.w,
                          color: Colors.white,
                        )
                      ],
                    )),
                16.gH,
                RsButton(
                    width: RsScreen.w,
                    radius: 10.r,
                    buttonColor: Colors.red,
                    splashColor: RsColorScheme.secondary,
                    onTap: controller.deleteMeet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Delete Meet",
                          style: RsTextStyle.bold
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                        4.gW,
                        Icon(
                          Icons.delete_forever,
                          size: 21.w,
                          color: Colors.white,
                        )
                      ],
                    )),
                16.gH,
              ])
        ],
      ),
    );
  }
}
