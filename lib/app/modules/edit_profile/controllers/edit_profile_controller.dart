import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/domain/impl/user_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../common/enums/form_type.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../../../data/models/form_model.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController
  RxList editProfileForm = [].obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initData() {
    final user = 'user_detail'.load();
    usernameController.text = user['username'];
    emailController.text = user['email'];
    telephoneController.text = user['phone'];

    editProfileForm.value = [
      RsFormModel(
        formType: FormType.text,
        name: "username",
        controller: usernameController,
        label: "Username",
        icon: Icons.person_2_rounded,
      ),
      RsFormModel(
        formType: FormType.text,
        name: "email",
        controller: emailController,
        label: "Email",
        icon: Icons.email_rounded,
      ),
      RsFormModel(
        formType: FormType.text,
        name: "phone",
        controller: telephoneController,
        label: "Telephone",
        icon: Icons.phone_android_rounded,
      ),
    ];
  }

  void onUpdate(GlobalKey<FormBuilderState> form) async {
    final formData = form.currentState!.value;
    final res =
        await UserRepository().update(id: 'user_detail'.load()['id'], data: {
      "username": formData['username'],
      "email": formData['email'],
      "phone": formData['phone'],
    });
    if (res.isNotEmpty) {
      Get.back();
      RsToast.show("Success", "Profile updated successfully");
    } else {
      RsToast.show("Error", "Cant update profile, please try again.");
    }
  }
}
