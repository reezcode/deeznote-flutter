import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => RsScaffold(
          body: controller.pages[controller.selectedIndex]!,
          appbar: AppBar(
            shadowColor: Colors.transparent,
            centerTitle: controller.selectedIndex.value == 3 ? true : false,
            title: Padding(
                padding: EdgeInsets.only(
                    left: controller.selectedIndex.value == 3 ? 0 : 12.w),
                child: controller.appBarTitle[controller.selectedIndex.value]),
            backgroundColor: RsColorScheme.primary,
          ),
          useSafeArea: false,
          bgColor: RsColorScheme.primary,
          withNavbar: true,
          onTap: controller.togglePage,
        ));
  }
}
