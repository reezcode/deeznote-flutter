// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_use_of_protected_member
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'package:deeznote/common/extensions/gaps.dart';

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

class RsUploadFile extends StatefulWidget {
  final bool? isMulti;
  final String? label;
  final String? name;
  final String? hint;
  final IconData? icon;
  final FileType? fileType;
  final List<String>? allowedExtensions;
  const RsUploadFile({
    Key? key,
    this.isMulti,
    this.label,
    this.name,
    this.hint,
    this.icon,
    this.fileType,
    this.allowedExtensions,
  }) : super(key: key);

  @override
  State<RsUploadFile> createState() => _RsUploadFileState();
}

class _RsUploadFileState extends State<RsUploadFile> {
  UploadController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: EdgeInsets.only(bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.label != null)
                ? Column(
                    children: [
                      Text(
                        widget.label ?? "",
                        style: RsTextStyle.semiBold,
                      ),
                      12.gH,
                    ],
                  )
                : const SizedBox(),
            GestureDetector(
              onTap: () {
                controller.pickFiles(
                    fileType: widget.fileType,
                    allowedExtensions: widget.allowedExtensions);
              },
              child: Container(
                width: RsScreen.w,
                height: 60.w,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                    border: Border.all(color: RsColorScheme.grey),
                    borderRadius: BorderRadius.circular(15.w)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.icon ?? Icons.upload_rounded,
                        color: RsColorScheme.grey),
                    12.gW,
                    Text(
                      controller.fileName.value.isNotEmpty
                          ? controller.fileName.value
                          : widget.hint ?? "Upload file here",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: RsTextStyle.regular.copyWith(
                          fontSize: 14.sp,
                          color: RsColorScheme.text.withOpacity(0.7)),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

class RsUploadMulti extends StatefulWidget {
  const RsUploadMulti({super.key});

  @override
  State<RsUploadMulti> createState() => _RsUploadMultiState();
}

class _RsUploadMultiState extends State<RsUploadMulti> {
  UploadController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Documentation Photo',
          style: RsTextStyle.semiBold.copyWith(
            color: RsColorScheme.text,
          ),
        ),
        16.gH,
        Wrap(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            runSpacing: 16.w,
            spacing: 16.w,
            children: [
              Obx(
                () => controller.isUploading.value == true
                    ? Container(
                        width: 98.w,
                        height: 98.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffBCC4CF),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: RsColorScheme.primary,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await controller.getPhoto();
                        },
                        child: Container(
                          width: 98.w,
                          height: 98.w,
                          decoration: BoxDecoration(
                            color: const Color(0xffBCC4CF),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 36.w,
                              height: 36.w,
                              child: Image.asset(
                                  'assets/icons/ic_camera_fill.png'),
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                width: RsScreen.w - 32.w - 98.w - 16.w,
                height: 98.w,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Obx(
                      () => Row(
                        children: controller.photoList.value,
                      ),
                    ),
                  ],
                ),
              ),
            ])
      ],
    );
  }
}
