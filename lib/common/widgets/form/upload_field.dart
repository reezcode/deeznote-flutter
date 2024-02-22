// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/data/sources/network/api/rs_core_api.dart';
import '../../../app/domain/di/controllers/upload_controller.dart';
import '../../../config/endpoints_config.dart';
import '../../styles/color_scheme.dart';
import '../../styles/rs_style_library.dart';
import '../../utils/screen.dart';
import '../custom/custom_snackbar.dart';

class RsProfileUpload extends StatefulWidget {
  final TextEditingController controller;
  const RsProfileUpload({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RsProfileUpload> createState() => _RsProfileUploadState();
}

class _RsProfileUploadState extends State<RsProfileUpload> {
  UploadController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            final ImagePicker picker = ImagePicker();
            void upFile(XFile? imagePicked) async {
              EasyLoading.show();
              File imageFile = File(imagePicked!.path);
              try {
                final res = await RsAPI.instance.upload(
                    endpoint: Endpoint.upload,
                    file: imageFile,
                    mediaType: MediaType.parse('image/jpeg'));
                if (res.success) {
                  EasyLoading.dismiss();
                  widget.controller.text = res.data!['preview'];
                  controller.imgrUrl.value = res.data!;
                } else {
                  EasyLoading.dismiss();
                  RsToast.show("Error", "Failed to upload image");
                }
              } catch (e) {
                EasyLoading.dismiss();
                RsToast.show("Error", e.toString());
              }
            }

            Get.dialog(
                barrierDismissible: false,
                Center(
                  child: Container(
                    width: RsScreen.w,
                    height: 130.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: RsColorScheme.background),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      Text(
                        "Pilih Sumber Gambar",
                        style: RsTextStyle.bold.copyWith(
                            fontSize: 14, color: RsColorScheme.primaryDark),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final XFile? imagePicked =
                                    await picker.pickImage(
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
                                        color: RsColorScheme.background,
                                        size: 30),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "Kamera",
                                      style: RsTextStyle.regular.copyWith(
                                          fontSize: 12,
                                          color: RsColorScheme.background),
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
                                final XFile? imagePicked =
                                    await picker.pickImage(
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
                                        color: RsColorScheme.background,
                                        size: 30),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "Galeri",
                                      style: RsTextStyle.regular.copyWith(
                                          fontSize: 12,
                                          color: RsColorScheme.background),
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
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100.w)),
              image: DecorationImage(
                image: NetworkImage(controller.getImgUrl()),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}

class RsUploadFile extends StatelessWidget {
  final bool isMulti;
  const RsUploadFile({
    Key? key,
    required this.isMulti,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
