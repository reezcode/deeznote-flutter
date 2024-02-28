import 'package:get/get.dart';

import '../controllers/detail_meet_controller.dart';

class DetailMeetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMeetController>(
      () => DetailMeetController(),
    );
  }
}
