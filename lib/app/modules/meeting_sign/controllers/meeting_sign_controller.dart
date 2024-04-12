import 'dart:io';
import 'dart:ui' as ui;

import 'package:deeznote/app/domain/di/controllers/upload_controller.dart';
import 'package:deeznote/app/domain/impl/notulensi_impl.dart';
import 'package:deeznote/app/modules/detail_meet/controllers/detail_meet_controller.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/screen.dart';
import '../../../../common/widgets/rs_turing.dart';

class MeetingSignController extends GetxController {
  //TODO: Implement MeetingSignController

  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();
  UploadController uploadController = Get.find<UploadController>();
  DetailMeetController detailMeetController = Get.find<DetailMeetController>();
  RxString signPerson = 'PIC'.obs;
  RxString picSign = ''.obs;
  RxString customerSign = ''.obs;
  final args = Get.arguments;
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
    if (signPerson.value == "PIC") {
      await EasyLoading.show();
      ui.Image image = await signaturePadKey.currentState!.toImage();
      File file = await FileHelper().saveImageToFile(image);
      final res = await uploadController.uploadImage(result: file);
      picSign.value = res;
      signaturePadKey.currentState!.clear();
      signPerson.value = "Customer";
      EasyLoading.dismiss();
    } else {
      Get.dialog(
        barrierDismissible: true,
        useSafeArea: true,
        Center(
          child: Container(
            width: 300.w,
            height: 270,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Confirmation",
                    style: RsTextStyle.extraBold.copyWith(fontSize: 16.sp)),
                16.gH,
                const Divider(
                  color: RsColorScheme.grey,
                ),
                4.gH,
                Icon(
                  Icons.help_rounded,
                  color: RsColorScheme.primary,
                  size: 50.w,
                ),
                4.gH,
                Text(
                  "Are you sure to submit this sign? After this, you can't change the sign anymore.",
                  textAlign: TextAlign.center,
                  style: RsTextStyle.regular
                      .copyWith(fontSize: 12.sp, color: RsColorScheme.text),
                ),
                16.gH,
                RsButton(
                    width: RsScreen.w,
                    radius: 10.r,
                    buttonColor: RsColorScheme.primary,
                    splashColor: RsColorScheme.secondary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Submit",
                          style: RsTextStyle.bold.copyWith(color: Colors.white),
                        ),
                        8.gW,
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18.w,
                        ),
                      ],
                    ),
                    onTap: () async {
                      await EasyLoading.show();
                      ui.Image image =
                          await signaturePadKey.currentState!.toImage();
                      File file = await FileHelper().saveImageToFile(image);
                      final res =
                          await uploadController.uploadImage(result: file);
                      customerSign.value = res;
                      NotulensiRepository()
                          .update(
                              meetIdMeet: args['meetId'],
                              id: args['notulensiId'],
                              notulensiSignCust: customerSign.value,
                              notulensiSignPIC: picSign.value)
                          .then((value) {
                        if (value.isNotEmpty) {
                          EasyLoading.dismiss();
                          RsToast.show("Success", "Sign has been saved");
                          Get.back();
                          Get.back();
                          detailMeetController.getDetailMeet();
                        } else {
                          EasyLoading.dismiss();
                          RsToast.show("Failed", "Failed to save sign");
                        }
                      });
                    }),
                8.gH,
              ],
            ),
          ),
        ),
      );
    }
  }
}
