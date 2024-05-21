import 'dart:io';

import 'package:deeznote/app/data/sources/local/local_storage.dart';
import 'package:deeznote/app/data/sources/network/api/rs_core_api.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_photo_view.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:deeznote/config/endpoints_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadController extends GetxController {
  var imgrUrl = {}.obs;
  RxBool isUploading = false.obs;
  RxString fileName = "".obs;
  Rx<File> file = File("").obs;
  RxList<Widget> photoList = <Widget>[].obs;
  List<String> photoSourceList = [];
  List<dynamic> mappedPhoto = [];
  RxList listFile = [].obs;

  String getImgUrl() {
    return imgrUrl['preview'];
  }

  void pickFiles({
    FileType? fileType,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType ?? FileType.custom,
      allowedExtensions:
          allowedExtensions ?? ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File fileNew = File(result.files.single.path!);
      file.value = fileNew;
      fileName.value = result.files.single.name;

      try {
        isUploading.value = true;
        final res = await RsAPI.instance.upload(
            endpoint: Endpoint.upload,
            file: fileNew,
            token: 'Bearer ${'token'.load()}');
        if (res.data != null) {
          isUploading.value = false;
          listFile.add(res.data.first['idFileContainer']);
          RsToast.show("Success", "File uploaded successfully 🎉");
        } else {
          RsToast.show("Error", "Response data empty");
        }
      } catch (e) {
        RsToast.show("Error", "$e");
      }
    }
  }

  Future<String> uploadImage({
    File? result,
  }) async {
    if (result != null) {
      try {
        isUploading.value = true;
        final res = await RsAPI.instance.upload(
            endpoint: Endpoint.upload,
            file: result,
            token: 'Bearer ${'token'.load()}');
        if (res.data != null) {
          isUploading.value = false;
          RsToast.show("Success", "File uploaded successfully 🎉");
          return res.data.first['fileLink'];
        } else {
          RsToast.show("Error", "Response data empty");
          return "";
        }
      } catch (e) {
        RsToast.show("Error", "$e");
        return "";
      }
    }
    return "";
  }

  Future<void> getPhoto() async {
    final ImagePicker picker = ImagePicker();
    void upFile(XFile? imagePicked) async {
      File imageFile = File(imagePicked!.path);
      try {
        isUploading.value = true;
        // final data = {};
        final res = await RsAPI.instance.upload(
            endpoint: Endpoint.upload,
            file: imageFile,
            token: 'Bearer ${'token'.load()}');
        if (res.data != null) {
          isUploading.value = false;
          mappedPhoto.add(res.data.first);
          int lastIndex = mappedPhoto.length - 1;
          photoSourceList.add(imagePicked.path);
          photoList.add(
            RsPhotoView(
              imgSrc: FileImage(File(imagePicked.path)),
              child: Container(
                width: 98.w,
                height: 98.w,
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  color: RsColorScheme.primary,
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: FileImage(File(imagePicked.path)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        removePhoto(lastIndex);
                      },
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        margin: EdgeInsets.all(4.w),
                        child: Image.asset('assets/icons/ic_delete.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          RsToast.show("Error", "Failed to upload file 😪");
        }
      } catch (e) {
        RsToast.show("Error", "There was an error 😪");
      }
    }

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
                        upFile(imagePicked);
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
                        upFile(imagePicked);
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

  void removePhoto(int index) {
    photoList.removeAt(index);
    mappedPhoto.removeAt(index);
    photoSourceList.removeAt(index);
  }
}
