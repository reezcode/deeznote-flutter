import 'package:get/get.dart';
import 'package:deeznote/app/domain/di/controllers/universal_controller.dart';
import 'package:deeznote/app/domain/di/controllers/upload_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    /// Implement dependency that needed to init from begining
    Get.put<UniversalController>(UniversalController(), permanent: true);
    Get.lazyPut<UploadController>(() => UploadController(), fenix: true);
  }
}
