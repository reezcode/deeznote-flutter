import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return RsScaffold(
      body: Obx(() => controller.pageView(controller)),
      useSafeArea: false,
      bgColor: RsColorScheme.primary,
      withNavbar: true,
      onTap: controller.togglePage,
    );
  }
}
