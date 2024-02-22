import 'package:get/get.dart';

class UploadController extends GetxController {
  var imgrUrl = {}.obs;

  String getImgUrl() {
    return imgrUrl['preview'];
  }
}
