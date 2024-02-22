import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';

import '../../../data/models/form_model.dart';

class UniversalController extends GetxController with RsValidationMixin {
  // Password Visibility
  RxBool isPasswordVisible = true.obs;
  RxBool isPasswordVisible2 = true.obs;
  RxBool isValid = false.obs;
  final loginFormKey = GlobalKey<FormBuilderState>();

  // Halting Condition
  RxBool isHalt = false.obs;

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

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordVisibility2() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleHalt() {
    isHalt.value = !isHalt.value;
  }

  void formKeyChecker(GlobalKey<FormBuilderState> formKey) {
    isValid.value = formKey.currentState?.validate(
            focusOnInvalid: false, autoScrollWhenFocusOnInvalid: true) ??
        false;
  }

  bool checkValidForm(List<RsFormModel> form) => isValidRsForm(form);
}
