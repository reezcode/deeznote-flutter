import 'package:deeznote/app/domain/impl/user_impl.dart';
import 'package:flutter/material.dart';
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

  void authLogin(GlobalKey<FormBuilderState> form) {
    Map<String, dynamic> data = {
      "email": form.currentState!.fields['email']!.value,
      "password": form.currentState!.fields['password']!.value,
    };
    UserRepository().login(data: data, callback: (p1) {});
  }
}
