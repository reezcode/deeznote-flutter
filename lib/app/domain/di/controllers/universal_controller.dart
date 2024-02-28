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
  RxList selectedData = [].obs;
  RxList staffData = [].obs;
  RxString selectedStaff = "Choose Staff Here...".obs;
  RxString selectedStaffImage = "assets/images/img_photo_default.png".obs;
  final loginFormKey = GlobalKey<FormBuilderState>();

  // Halting Condition
  RxBool isHalt = false.obs;

  @override
  void onInit() {
    fillStaffData();
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

  void checkData(int id) {
    if (selectedData.contains(id)) {
      selectedData.remove(id);
    } else {
      selectedData.add(id);
    }

    if (selectedData.isEmpty) {
      selectedStaff.value = "Choose Staff Here...";
      selectedStaffImage.value = "assets/images/img_photo_default.png";
    } else {
      String selectedNames = "";
      selectedNames = staffData
          .firstWhere((element) => element["id"] == selectedData.first)["name"];

      selectedStaff.value = selectedData.length == 1
          ? staffData.firstWhere(
              (element) => element["id"] == selectedData.first)["name"]
          : "$selectedNames and ${selectedData.length - 1} others";

      selectedStaffImage.value = staffData.firstWhere(
          (element) => element["id"] == selectedData.first)["photo"];
    }
  }

  void fillStaffData() {
    staffData.value = [
      {
        "id": 1,
        "name": "Resma Adi N",
        "position": "Mobile Developer",
        "photo": "assets/images/img_profile_photo.png",
      },
      {
        "id": 2,
        "name": "Irwan F",
        "position": "Back-End Developer",
        "photo": "assets/images/img_profile_photo.png",
      },
    ];
  }

  /// WELL IMPLEMENTED WHEN USING QUERY API

  void searchStaffData(String query) {
    if (query.isEmpty) {
      fillStaffData();
    } else {
      staffData.value = staffData
          .where((e) => e["name"].toString().toLowerCase().contains(query))
          .toList();
    }
  }

  bool isSelected(int id) {
    return selectedData.contains(id);
  }

  bool checkValidForm(List<RsFormModel> form) => isValidRsForm(form);
}
