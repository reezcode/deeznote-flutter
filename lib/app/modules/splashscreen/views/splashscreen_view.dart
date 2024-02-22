import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/utils/screen.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return RsScaffold(
      useSafeArea: true,
      body: Center(
        child: Container(
            width: RsScreen.w * 0.4,
            height: RsScreen.w * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/ic_logo.png'),
              ),
            )),
      ),
    );
  }
}
