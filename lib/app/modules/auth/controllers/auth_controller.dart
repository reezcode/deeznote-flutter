import 'package:deeznote/app/data/sources/network/api/interceptor.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

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

  void authLogin(GlobalKey<FormBuilderState> form) async {
    EasyLoading.show();
    try {
      Get.offAllNamed(Routes.HOME,
          arguments: {"email": form.currentState?.value['email']});
    } catch (e) {
      RsInterceptor.show(e);
    }
    EasyLoading.dismiss();
  }
}
