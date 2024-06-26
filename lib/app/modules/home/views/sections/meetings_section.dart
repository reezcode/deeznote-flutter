// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:deeznote/common/utils/core.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/custom/custom_shimmer.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../common/utils/format_date.dart';
import '../../../../../common/widgets/prebuilt/rs_custom_v_card.dart';

class MeetingSection extends StatefulWidget {
  final HomeController controller;
  const MeetingSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MeetingSection> createState() => _MeetingSectionState();
}

class _MeetingSectionState extends State<MeetingSection> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        width: RsScreen.w,
        height: RsScreen.h,
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ListView(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.w, horizontal: 16.w),
                      child: TableCalendar(
                          focusedDay: widget.controller.selectedDay.value,
                          firstDay: DateTime.utc(2021, 10, 4),
                          lastDay: DateTime.utc(2099, 10, 4),
                          availableGestures: AvailableGestures.all,
                          // calendarBuilders: CalendarBuilders(
                          //   selectedBuilder: (context, date, _) {
                          //     return Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         Container(
                          //           width: 30.w,
                          //           height: 30.w,
                          //           margin: EdgeInsets.all(4.w),
                          //           alignment: Alignment.center,
                          //           decoration: const BoxDecoration(
                          //             color: RsColorScheme.primary,
                          //             shape: BoxShape.circle,
                          //           ),
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               2.gH,
                          //               Text(
                          //                 '${date.day}',
                          //                 style: RsTextStyle.regular.copyWith(
                          //                   color: Colors.white,
                          //                 ),
                          //               ),
                          //               Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   children: [1, 2, 3]
                          //                       .map((e) => Container(
                          //                             width: 4.w,
                          //                             height: 4.w,
                          //                             margin: EdgeInsets.only(
                          //                                 bottom: 2.w,
                          //                                 left: 2.w),
                          //                             decoration:
                          //                                 const BoxDecoration(
                          //                               color: Colors.white,
                          //                               shape: BoxShape.circle,
                          //                             ),
                          //                           ))
                          //                       .toList())
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          //   defaultBuilder: (context, day, focusedDay) {
                          //     return Center(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.all(4.w),
                          //             alignment: Alignment.center,
                          //             child: Text(
                          //               '${day.day}',
                          //               style: RsTextStyle.regular.copyWith(
                          //                 color: RsColorScheme.text,
                          //               ),
                          //             ),
                          //           ),
                          //           Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: widget.controller
                          //                   .meetCount(date: day)
                          //                   .map((e) => Container(
                          //                         width: 4.w,
                          //                         height: 4.w,
                          //                         margin: EdgeInsets.only(
                          //                             bottom: 2.w, left: 2.w),
                          //                         decoration:
                          //                             const BoxDecoration(
                          //                           color:
                          //                               RsColorScheme.primary,
                          //                           shape: BoxShape.circle,
                          //                         ),
                          //                       ))
                          //                   .toList())
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),
                          onDaySelected: widget.controller.onDaySelected,
                          selectedDayPredicate: (day) => isSameDay(
                              day, widget.controller.selectedDay.value),
                          headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: RsTextStyle.semiBold.copyWith(
                                  color: RsColorScheme.text, fontSize: 18.sp)),
                          calendarStyle: CalendarStyle(
                            holidayTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.red,
                            ),
                            weekendTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.red,
                            ),
                            todayDecoration: const BoxDecoration(
                              color: RsColorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: RsColorScheme.primary.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.white,
                            ),
                            todayTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.white,
                            ),
                            defaultTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.black,
                            ),
                            outsideTextStyle: RsTextStyle.regular.copyWith(
                              color: Colors.grey,
                            ),
                            outsideDaysVisible: false,
                          )),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 9,
                            blurRadius: 15,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: observe(
                        event: widget.controller.meetListEvent,
                        loading: const ListLongShimmer(
                          count: 3,
                        ),
                        error: (msg) => RsEmptyData(
                          msg: msg,
                          light: false,
                        ),
                        success: (data) => ListView.builder(
                            controller: scrollController,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final meet = data[index];
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          width: 80.w,
                                          height: 10.w,
                                          margin: EdgeInsets.only(bottom: 16.h),
                                          decoration: BoxDecoration(
                                            color: RsColorScheme.grey
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                          )),
                                    ),
                                    Text(widget.controller.titleMeet.value,
                                        style: RsTextStyle.bold.copyWith(
                                            color: RsColorScheme.text,
                                            fontSize: 16.sp)),
                                    16.gH
                                  ],
                                );
                              }
                              if (index == data.length - 1) {
                                return 100.gH;
                              }
                              return RsCardV1(
                                  rawDate: meet['meetDate'],
                                  dayLeft: differenceInDays(
                                      meet['meetDate'], DateTime.now()),
                                  id: meet['idMeet'],
                                  statusCode: meet['status_code'],
                                  title: meet['meetTitle'],
                                  date: formatDateTime(meet['meetDate'], false),
                                  time: formatTime(meet['meetDate']),
                                  client: meet['customerName']);
                            }),
                      ));
                },
              )
            ],
          ),
        )));
  }
}
