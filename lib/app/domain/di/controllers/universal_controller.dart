import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';

import '../../../data/models/form_model.dart';
import '../../impl/staff_impl.dart';

class UniversalController extends GetxController with RsValidationMixin {
  // Password Visibility
  RxBool isPasswordVisible = true.obs;
  RxBool isPasswordVisible2 = true.obs;
  RxBool isValid = false.obs;
  RxList selectedData = [].obs;
  RxList staffData = [].obs;
  RxList staffDataInit = [].obs;
  RxString selectedStaff = "Choose Staff Here...".obs;
  RxString selectedStaffImage = "https://via.placeholder.com/150".obs;
  final loginFormKey = GlobalKey<FormBuilderState>();

  // Halting Condition
  RxBool isHalt = false.obs;

  @override
  void onInit() {
    // fillStaffData();
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
            focusOnInvalid: false, autoScrollWhenFocusOnInvalid: false) ??
        false;
  }

  void checkData(String id) {
    if (selectedData.contains(id)) {
      selectedData.remove(id);
    } else {
      selectedData.add(id);
    }

    if (selectedData.isEmpty) {
      selectedStaff.value = "Choose Staff Here...";
      selectedStaffImage.value = "https://via.placeholder.com/150";
    } else {
      String selectedNames = "";
      selectedNames = staffData.firstWhere(
          (element) => element["id"].toString() == selectedData.first)["name"];

      selectedStaff.value = selectedData.length == 1
          ? staffData.firstWhere((element) =>
              element["id"].toString() == selectedData.first)["name"]
          : "$selectedNames and ${selectedData.length - 1} others";

      selectedStaffImage.value = staffData.firstWhere((element) =>
          element["id"].toString() == selectedData.first)["profilePict"];
    }
  }

  /// WELL IMPLEMENTED WHEN USING QUERY API

  bool isSelected(String id) {
    return selectedData.contains(id);
  }

  bool checkValidForm(List<RsFormModel> form) => isValidRsForm(form);

  void searchStaffData(String s) async {
    staffData.value = await StaffRepository().list(search: s);
  }
}
