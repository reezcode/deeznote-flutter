// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/modules/home/views/sections/home_section.dart';
import 'package:deeznote/app/modules/home/views/sections/meetings_section.dart';
import 'package:deeznote/app/modules/home/views/sections/notif_section.dart';
import 'package:deeznote/app/modules/home/views/sections/profile_section.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:deeznote/common/widgets/custom/custom_blank.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_v_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late var arguments;
  ValueNotifier<double> counter = ValueNotifier<double>(12);
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<Color> appBarColor = RsColorScheme.primary.obs;
  RxList meetingList = [].obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
    meetingList.value = [
      {
        "dayLeft": 1,
        "title": "Weekly Meeting 1 KPBU",
        "date": "01 Februari 2024",
        "time": "10.00-12.00 WIB",
        "client": "PT. Hutama Karya PBI"
      },
      {
        "dayLeft": 2,
        "title": "Weekly Meeting 2 KPBU",
        "date": "02 Februari 2024",
        "time": "10.00-12.00 WIB",
        "client": "PT. Hutama Karya PBI"
      },
      {
        "dayLeft": 3,
        "title": "Weekly Meeting 3 KPBU",
        "date": "03 Februari 2024",
        "time": "10.00-12.00 WIB",
        "client": "PT. Hutama Karya PBI"
      }
    ];
    super.onInit();
  }

  @override
  void onReady() {
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
    Get.offAllNamed(Routes.AUTH);
  }

  void startMeet() {}

  Map<int, Widget> get pages => {
        0: HomeSection(controller: this),
        1: MeetingSection(controller: this),
        2: NotifSection(controller: this),
        3: ProfileSection(controller: this),
      };

  Map<int, Widget?> get appBarTitle => {
        0: Text(
          "Hi ${'name'.load()}!",
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

  Widget upcomingMeetingWidget() {
    return (1 == 1)
        ? const Column(
            children: [
              RsCardV1(
                  dayLeft: 1,
                  title: "Weekly Meeting 1 KPBU",
                  date: "01 Februari 2024",
                  time: "10.00-12.00 WIB",
                  client: "PT. Hutama Karya PBI"),
              CardBlank()
            ],
          )
        : const DefaultBlank();
  }
}
