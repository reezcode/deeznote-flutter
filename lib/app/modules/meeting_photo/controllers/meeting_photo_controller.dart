import 'dart:io';

import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/screen.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../../../../config/endpoints_config.dart';
import '../../../data/sources/network/api/rs_core_api.dart';
import '../../../domain/impl/notulensi_impl.dart';

class MeetingPhotoController extends GetxController {
  //TODO: Implement MeetingPhotoController

  final args = Get.arguments;
  RxList photoList = [].obs;
  RxBool isUploading = false.obs;
  RxList<dynamic> requestList = [].obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      final res = await NotulensiRepository().show(id: args['notulensiId']);
      if (res.isNotEmpty) {
        photoList.value = res['dokumentasi'];
        for (var i = 0; i < photoList.length; i++) {
          requestList.add(photoList[i]['idFileContainer']);
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void removePhoto(int index) {
    photoList.removeAt(index);
    requestList.removeAt(index);
  }

  List<String> convertRequestList() {
    List<String> result = [];
    for (var i = 0; i < requestList.length; i++) {
      result.add(requestList[i]);
    }
    return result;
  }

  void submitPhoto() async {
    EasyLoading.show();
    final res = await NotulensiRepository().update(
        meetIdMeet: args['meetId'],
        documents: convertRequestList(),
        id: args['notulensiId']);
    if (res.isNotEmpty) {
      RsToast.show("Success", "Meeting photo has been saved");
    } else {
      RsToast.show("Failed", "Failed to save meeting photo");
    }
    EasyLoading.dismiss();
  }

  void uploadFile(XFile? imagePicked) async {
    File imageFile = File(imagePicked!.path);
    try {
      isUploading.value = true;
      final res = await RsAPI.instance.upload(
          endpoint: Endpoint.upload,
          file: imageFile,
          token: 'Bearer ${'token'.load()}');
      if (res.data != null) {
        isUploading.value = false;
        photoList.add(res.data.first);
        requestList.add(res.data.first['idFileContainer']);
        RsToast.show("Success", "File uploaded successfully 🎉");
      } else {
        RsToast.show("Error", "Response data empty");
      }
    } catch (e) {
      RsToast.show("Error", "$e");
    }
  }

  void choosePhoto() {
    final ImagePicker picker = ImagePicker();
    Get.dialog(
        barrierDismissible: true,
        Center(
          child: Container(
            width: RsScreen.w,
            height: 130.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Text(
                "Choose Photo Source",
                style: RsTextStyle.bold,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? imagePicked = await picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 50,
                        );
                        uploadFile(imagePicked);
                        Get.back();
                      },
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        margin: EdgeInsets.only(top: 10.h),
                        decoration: BoxDecoration(
                          color: RsColorScheme.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt_rounded,
                                color: Colors.white, size: 30),
                            SizedBox(height: 5.h),
                            Text(
                              "Camera",
                              style: RsTextStyle.medium
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? imagePicked = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        uploadFile(imagePicked);
                        Get.back();
                      },
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        margin: EdgeInsets.only(top: 10.h),
                        decoration: BoxDecoration(
                          color: RsColorScheme.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.photo_rounded,
                                color: Colors.white, size: 30),
                            SizedBox(height: 5.h),
                            Text(
                              "Gallery",
                              style: RsTextStyle.medium
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
