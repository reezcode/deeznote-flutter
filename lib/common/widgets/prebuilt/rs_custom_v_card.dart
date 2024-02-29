// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:deeznote/common/extensions/gaps.dart';
import 'package:get/get.dart';

import '../../styles/rs_style_library.dart';
import '../../utils/screen.dart';
import '../rs_turing.dart';

class RsCardV1 extends StatelessWidget {
  final int dayLeft;
  final String title;
  final String date;
  final String time;
  final String client;
  const RsCardV1({
    Key? key,
    required this.dayLeft,
    required this.title,
    required this.date,
    required this.time,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_MEET);
      },
      child: RsCard(
          width: RsScreen.w,
          height: 120.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          margin: EdgeInsets.only(bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Chip(
                      backgroundColor: (dayLeft == 0)
                          ? Colors.red
                          : (dayLeft == 1)
                              ? RsColorScheme.tertiary
                              : RsColorScheme.primary,
                      label: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.white,
                            size: 14.w,
                          ),
                          4.gW,
                          Text(
                            (dayLeft == 0)
                                ? "Today"
                                : (dayLeft == 1)
                                    ? "Tomorrow"
                                    : "$dayLeft day left",
                            style: RsTextStyle.semiBold
                                .copyWith(fontSize: 12.sp, color: Colors.white),
                          )
                        ],
                      ))
                ],
              ),
              Text(
                title,
                style: RsTextStyle.bold.copyWith(fontSize: 14.sp),
              ),
              8.gH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time_filled_rounded,
                    color: RsColorScheme.text,
                    size: 14.w,
                  ),
                  4.gW,
                  Text(
                    date,
                    style: RsTextStyle.medium
                        .copyWith(fontSize: 12.sp, color: RsColorScheme.text),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: RsTextStyle.medium
                        .copyWith(fontSize: 12.sp, color: RsColorScheme.text),
                  )
                ],
              ),
              8.gH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_city_rounded,
                    color: RsColorScheme.text,
                    size: 14.w,
                  ),
                  4.gW,
                  Text(
                    client,
                    style: RsTextStyle.medium
                        .copyWith(fontSize: 12.sp, color: RsColorScheme.text),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
