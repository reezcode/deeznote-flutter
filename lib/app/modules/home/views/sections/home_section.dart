// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/core.dart';
import 'package:deeznote/common/utils/format_date.dart';
import 'package:deeznote/common/widgets/custom/custom_blank.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_error.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

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
    return observe(
      event: controller.homeEvent,
      loading: const HomeLoadingShimmer(),
      error: (msg) => RsHomeError(
        msg: msg,
        onError: controller.getDashboardData,
      ),
      success: (data) => ListView(
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
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: SimpleCircularProgressBar(
                        valueNotifier: controller.counter,
                        mergeMode: true,
                        animationDuration: 0,
                        maxValue: data['totalMeet'].toDouble(),
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
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1100),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Agenda",
                            style: RsTextStyle.bold
                                .copyWith(fontSize: 16.sp, color: Colors.white),
                          ),
                          8.gH,
                          Text(
                            DateFormat('EEEE, d MMMM yyyy')
                                .format(DateTime.now()),
                            style: RsTextStyle.medium
                                .copyWith(fontSize: 14.sp, color: Colors.white),
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
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          RsBottomSheet(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 950),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: Text(
                    "Schedule Meeting",
                    style: RsTextStyle.bold
                        .copyWith(color: RsColorScheme.text, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                8.gH,
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: RsButton(
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
                      )),
                ),
                32.gH,
                FadeInDown(
                    duration: const Duration(milliseconds: 1100),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: SizedBox(
                      width: RsScreen.w,
                      height: 45.w,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: controller.meetTab
                            .map((e) => RsTab(
                                onTap: controller.toggleTab,
                                currentIdx: controller.selectedTab.value,
                                e: e))
                            .toList(),
                      ),
                    )),
                16.gH,
                ...data['upcomingMeeting'].asMap().entries.map((entry) {
                  int index = entry.key;
                  dynamic e = entry.value;
                  return FadeInDown(
                    duration: Duration(milliseconds: 1100 + (index * 300)),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    child: RsCardV1(
                      statusCode: e['status_code'],
                      rawDate: e['meetDate'],
                      dayLeft: differenceInDays(e['meetDate'], DateTime.now()),
                      id: e['idMeet'],
                      title: e['meetTitle'],
                      date: formatDateTime(e['meetDate'], false),
                      time: formatTime(e['meetDate']),
                      client: e['customerName'],
                    ),
                  );
                }).toList(),
                Visibility(
                    visible: data['upcomingMeeting'].length == 1,
                    child: const CardBlank()),
                50.gH,
              ])
        ],
      ),
    );
  }
}
