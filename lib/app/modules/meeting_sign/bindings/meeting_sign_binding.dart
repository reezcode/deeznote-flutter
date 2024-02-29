import 'package:get/get.dart';

import '../controllers/meeting_sign_controller.dart';

class MeetingSignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingSignController>(
      () => MeetingSignController(),
    );
  }
}
