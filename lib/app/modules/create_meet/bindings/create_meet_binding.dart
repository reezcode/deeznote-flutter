import 'package:get/get.dart';

import '../controllers/create_meet_controller.dart';

class CreateMeetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMeetController>(
      () => CreateMeetController(),
    );
  }
}
