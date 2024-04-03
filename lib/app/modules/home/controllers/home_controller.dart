// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/domain/impl/meet_impl.dart';
import 'package:deeznote/app/modules/home/views/sections/home_section.dart';
import 'package:deeznote/app/modules/home/views/sections/meetings_section.dart';
import 'package:deeznote/app/modules/home/views/sections/notif_section.dart';
import 'package:deeznote/app/modules/home/views/sections/profile_section.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/utils/format_date.dart';
import '../../../../common/utils/screen.dart';
import '../../../../common/widgets/prebuilt/rs_custom_v_card.dart';

class HomeController extends GetxController {
  late var arguments;
  ValueNotifier<double> counter = ValueNotifier<double>(5);
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<Color> appBarColor = RsColorScheme.primary.obs;
  RxList meetingList = [].obs;
  RxMap dashboardData = {}.obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    arguments = Get.arguments;
    getDashboardData();
    getMeetList();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void togglePage(int index) {
    selectedIndex.value = index;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
  }

  void createMeet() {
    Get.toNamed(Routes.CREATE_MEET);
  }

  void logOut() {
    'token'.remove();
    'user_detail'.remove();
    Get.offAllNamed(Routes.AUTH);
  }

  void getMeetList({
    String? sort,
    String? sortBy,
    int? page,
    int? limit,
    String? search,
    String? startDate,
    String? endDate,
  }) async {
    meetingList.value = await MeetRepository().list(
      sort: sort ?? 'desc',
      sortBy: sortBy ?? 'meetDate',
      page: page ?? 1,
      limit: limit ?? 10,
      search: search,
      startDate: startDate,
      endDate: endDate,
    );
    refresh();
  }

  void getDashboardData() async {
    dashboardData.value = await MeetRepository()
        .dashboard(sort: 'desc', sortBy: 'meetDate', page: 1, limit: 5);
    counter.value = dashboardData['meetUnfinished'].toDouble();
  }

  void showMeet() {
    Get.dialog(
      barrierDismissible: true,
      useSafeArea: true,
      Center(
        child: Container(
          width: RsScreen.w * 0.9,
          height: RsScreen.h * 0.5,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: ListView(
            children: [
              Text(
                "Today Meetings",
                style: RsTextStyle.semiBold.copyWith(fontSize: 16.sp),
              ),
              12.gH,
              dashboardData['todayMeet'].isNotEmpty
                  ? Column(
                      children: dashboardData['todayMeet']
                          .map<Widget>((e) => RsCardV1(
                              dayLeft: differenceInDays(
                                  e['meetDate'], DateTime.now()),
                              id: e['idMeet'],
                              title: e['meetTitle'],
                              date: formatDateTime(e['meetDate'], false),
                              time: formatTime(e['meetDate']),
                              client: e['customerName']))
                          .toList())
                  : Center(
                      child: Container(
                      width: RsScreen.w * 0.8,
                      height: 70.w,
                      decoration: BoxDecoration(
                        color: RsColorScheme.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Center(
                        child: Text(
                          "Touch grass 🍃, \nthere is no meeting today",
                          textAlign: TextAlign.center,
                          style: RsTextStyle.regular
                              .copyWith(color: RsColorScheme.grey),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Map<int, Widget> get pages => {
        0: HomeSection(controller: this),
        1: MeetingSection(controller: this),
        2: NotifSection(controller: this),
        3: ProfileSection(controller: this),
      };

  Map<int, Widget?> get appBarTitle => {
        0: Text(
          "Hi ${'user_detail'.load()['name']}!",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 21.sp),
        ),
        1: Text(
          "Meeting List",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        2: Text(
          "Notifications",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        3: Text(
          "Profile",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
      };
}
