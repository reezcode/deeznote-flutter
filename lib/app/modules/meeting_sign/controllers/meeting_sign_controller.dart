import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class MeetingSignController extends GetxController {
  //TODO: Implement MeetingSignController

  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
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

  void submitSign() async {
    // ui.Image image = await signaturePadKey.currentState!.toImage();
  }
}
