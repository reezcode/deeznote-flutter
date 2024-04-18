import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/domain/impl/user_impl.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  //TODO: Implement UpdatePasswordController
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

  void onUpdate(GlobalKey<FormBuilderState> form) async {
    final formData = form.currentState!.value;
    final res = await UserRepository()
        .changePassword(id: 'user_detail'.load()['id'], data: {
      "oldPassword": formData['old_password'],
      "newPassword": formData['new_password'],
    });
    if (res) {
      Get.back();
      RsToast.show("Success", "Password updated successfully");
    } else {
      RsToast.show("Error", "Cant update password, please try again.");
    }
  }
}
