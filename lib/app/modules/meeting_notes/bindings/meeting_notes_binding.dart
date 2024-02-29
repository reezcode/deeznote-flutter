import 'package:get/get.dart';

import '../controllers/meeting_notes_controller.dart';

class MeetingNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingNotesController>(
      () => MeetingNotesController(),
    );
  }
}
