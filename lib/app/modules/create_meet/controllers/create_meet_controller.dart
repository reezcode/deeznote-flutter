import 'package:deeznote/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class CreateMeetController extends GetxController {
  //TODO: Implement CreateMeetController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void createMeet(GlobalKey<FormBuilderState> form) async {
    Get.offAllNamed(Routes.HOME);
  }
}
