import 'package:deeznote/app/modules/home/views/sections/home_section.dart';
import 'package:deeznote/app/modules/home/views/sections/meetings_section.dart';
import 'package:deeznote/common/widgets/custom/custom_blank.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_v_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late var arguments;
  ValueNotifier<double> counter = ValueNotifier<double>(12);
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    arguments = Get.arguments;
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

  Widget pageView(HomeController controller) {
    switch (selectedIndex.value) {
      case 0:
        return HomeSection(controller: controller);
      case 1:
        return MeetingSection(controller: controller);
      default:
        return HomeSection(controller: controller);
    }
  }

  Widget upcomingMeetingWidget() {
    return (true)
        ? Column(
            children: [1, 2, 3, 4]
                .map((e) => RsCardV1(
                    dayLeft: e,
                    title: "Weekly Meeting $e KPBU",
                    date: "0$e Februari 2024",
                    time: "10.00-12.00 WIB",
                    client: "PT. Hutama Karya PBI"))
                .toList(),
          )
        : const DefaultBlank();
  }
}
