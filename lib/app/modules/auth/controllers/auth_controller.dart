import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/data/sources/network/api/rs_core_api.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:deeznote/config/endpoints_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../data/sources/network/api/interceptor.dart';

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
      final res = await RsAPI.instance.post(endpoint: Endpoint.login, data: {
        "identifier": form.currentState?.value['email'],
        "password": form.currentState?.value['password']
      });

      if (res.success) {
        res.data['token'].toString().save('token');
        res.data['user'].toString().save('name');
        Get.offAllNamed(Routes.HOME, arguments: {});
        EasyLoading.dismiss();
      }
    } catch (e) {
      RsInterceptor.show(e);

      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }
}
