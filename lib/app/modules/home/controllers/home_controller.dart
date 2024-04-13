import 'package:deeznote/app/data/models/state_model.dart';
import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/domain/impl/meet_impl.dart';
import 'package:deeznote/app/modules/home/views/sections/home_section.dart';
import 'package:deeznote/app/modules/home/views/sections/meetings_section.dart';
import 'package:deeznote/app/modules/home/views/sections/notif_section.dart';
import 'package:deeznote/app/modules/home/views/sections/profile_section.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:deeznote/common/utils/core.dart';
import 'package:deeznote/common/widgets/custom/custom_blank.dart';
import 'package:deeznote/common/widgets/custom/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils/format_date.dart';
import '../../../../common/widgets/prebuilt/rs_custom_v_card.dart';

class HomeController extends GetxController {
  late var arguments;
  ValueNotifier<double> counter = ValueNotifier<double>(5);
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<Color> appBarColor = RsColorScheme.primary.obs;
  RxInt selectedIndex = 0.obs;
  Rx<String> titleMeet = "This Month Meetings".obs;
  RxInt selectedTab = 0.obs;
  PageController pageController = PageController();
  RexEvent homeEvent = RexEvent.init();
  RexEvent meetListEvent = RexEvent.init();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    arguments = Get.arguments;
    getDashboardData();
    getMeetList();
    titleMeet.value = "This Month Meetings";
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<Map<String, dynamic>> meetTab = [
    {'idx': 0, 'icon': Icons.calendar_today, 'title': 'Upcoming Meetings'},
    {'idx': 1, 'icon': Icons.watch_later_outlined, 'title': 'Ongoing Meetings'},
    {'idx': 2, 'icon': Icons.done_all_rounded, 'title': 'Finished Meetings'}
  ];

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

  void togglePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  void toggleTab(int index) {
    selectedTab.value = index;
    when(index, {0: () {}, 1: () {}, 2: () {}});
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateTime endDate = selectedDay.add(const Duration(days: 1));
    String formattedEndDate = formatter.format(endDate.toUtc());
    String formattedDate = formatter.format(selectedDay.toUtc());
    getMeetList(startDate: formattedDate, endDate: formattedEndDate);
    titleMeet.value = DateFormat("EEEE, dd MMMM yyyy").format(selectedDay);
  }

  void createMeet() {
    Get.toNamed(Routes.CREATE_MEET, arguments: {'type': FormAction.create});
  }

  void getDashboardData() async {
    await flow(homeEvent, (emit) async {
      emit(RsEvent.loading());
      final res = await MeetRepository()
          .dashboard(sort: 'desc', sortBy: 'meetDate', page: 1, limit: 5);
      if (res.isNotEmpty) {
        counter.value = res['meetUnfinished'].toDouble();
        emit(RsEvent.success(res));
      } else {
        emit(RsEvent.error("Failed to fetch the data"));
      }
    });
  }

  void showMeet() {
    RsDialog.show(children: [
      Text(
        "Today Meetings",
        style: RsTextStyle.semiBold.copyWith(fontSize: 16.sp),
      ),
      12.gH,
      homeEvent.value.data['todayMeet'].isNotEmpty
          ? Column(
              children: homeEvent.value.data['todayMeet']
                  .map<Widget>((e) => RsCardV1(
                      statusCode: e['status_code'],
                      rawDate: e['meetDate'],
                      dayLeft: differenceInDays(e['meetDate'], DateTime.now()),
                      id: e['idMeet'],
                      title: e['meetTitle'],
                      date: formatDateTime(e['meetDate'], false),
                      time: formatTime(e['meetDate']),
                      client: e['customerName']))
                  .toList())
          : const EmptyMeetings(),
    ]);
  }

  // Meeting List Section
  void getMeetList({
    String? sort,
    String? sortBy,
    int? page,
    int? limit,
    String? search,
    String? startDate,
    String? endDate,
  }) {
    flow(meetListEvent, (emit) async {
      emit(RsEvent.loading());
      final res = await MeetRepository().list(
        sort: sort ?? 'desc',
        sortBy: sortBy ?? 'meetDate',
        page: page ?? 1,
        limit: limit ?? 10,
        search: search,
        startDate: startDate,
        endDate: endDate,
      );
      if (res.isNotEmpty) {
        res.insert(0, {});
        emit(RsEvent.success(res));
        refresh();
      } else {
        emit(RsEvent.error("Error"));
      }
    });
  }

  // Profile Section
  void logOut() {
    'token'.remove();
    'user_detail'.remove();
    Get.offAllNamed(Routes.AUTH);
  }
}
