import 'package:get/get.dart';

import '../controllers/meeting_photo_controller.dart';

class MeetingPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingPhotoController>(
      () => MeetingPhotoController(),
    );
  }
}
