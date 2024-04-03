// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/utils/format_date.dart';
import 'package:deeznote/common/widgets/custom/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:deeznote/common/extensions/gaps.dart';

import '../../../../../common/styles/rs_style_library.dart';
import '../../../../../common/utils/screen.dart';
import '../../../../../common/widgets/prebuilt/rs_custom_v_card.dart';
import '../../../../../common/widgets/rs_turing.dart';

class HomeSection extends StatelessWidget {
  final HomeController controller;
  const HomeSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.dashboardData.isNotEmpty
        ? ListView(
            children: [
              Container(
                width: RsScreen.w * 0.75.w,
                height: RsScreen.w * 0.4.w,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleCircularProgressBar(
                          valueNotifier: controller.counter,
                          mergeMode: true,
                          animationDuration: 0,
                          maxValue:
                              controller.dashboardData['totalMeet'].toDouble(),
                          backColor: Colors.white,
                          progressColors: const [
                            RsColorScheme.secondary,
                            RsColorScheme.tertiary
                          ],
                          onGetText: (double value) {
                            return Text('${value.toInt()} \nMeet',
                                textAlign: TextAlign.center,
                                style: RsTextStyle.bold.copyWith(
                                    color: Colors.white, fontSize: 18.sp));
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Agenda",
                              style: RsTextStyle.bold.copyWith(
                                  fontSize: 16.sp, color: Colors.white),
                            ),
                            8.gH,
                            Text(
                              DateFormat('EEEE, d MMMM yyyy')
                                  .format(DateTime.now()),
                              style: RsTextStyle.medium.copyWith(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                            8.gH,
                            RsButton(
                                width: RsScreen.w * 0.4.w,
                                buttonColor: RsColorScheme.secondary,
                                radius: 10.r,
                                onTap: controller.showMeet,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "See Meetings",
                                      style: RsTextStyle.bold
                                          .copyWith(fontSize: 14.sp),
                                    ),
                                    4.gW,
                                    Icon(Icons.video_call_rounded, size: 24.w)
                                  ],
                                ))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              RsBottomSheet(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Schedule Meeting",
                      style: RsTextStyle.bold
                          .copyWith(color: RsColorScheme.text, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    8.gH,
                    RsButton(
                        width: RsScreen.w,
                        radius: 10.r,
                        splashColor: RsColorScheme.secondary,
                        onTap: controller.createMeet,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Create Meeting",
                              style: RsTextStyle.bold.copyWith(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                            4.gW,
                            Icon(
                              Icons.add_circle,
                              size: 21.w,
                              color: Colors.white,
                            )
                          ],
                        )),
                    16.gH,
                    Text(
                      "Upcoming Meeting",
                      style: RsTextStyle.bold
                          .copyWith(color: RsColorScheme.text, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    16.gH,
                    ...controller.dashboardData['upcomingMeeting']
                        .map((e) => RsCardV1(
                            dayLeft:
                                differenceInDays(e['meetDate'], DateTime.now()),
                            id: e['idMeet'],
                            title: e['meetTitle'],
                            date: formatDateTime(e['meetDate'], false),
                            time: formatTime(e['meetDate']),
                            client: e['customerName']))
                        .toList(),
                    38.gH,
                  ])
            ],
          )
        : const ListLongShimmer());
  }
}
