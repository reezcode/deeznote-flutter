import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  var imgrUrl = {}.obs;
  RxString fileName = "".obs;
  Rx<File> file = File("").obs;

  String getImgUrl() {
    return imgrUrl['preview'];
  }

  void pickFiles({
    FileType? fileType,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType ?? FileType.custom,
      allowedExtensions:
          allowedExtensions ?? ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File fileNew = File(result.files.single.path!);
      file.value = fileNew;
      fileName.value = result.files.single.name;

      /// UPLOAD TO API HERE
    }
  }
}
