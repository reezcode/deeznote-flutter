import 'package:deeznote/app/domain/impl/notulensi_impl.dart';
import 'package:deeznote/app/routes/app_pages.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/core.dart';
import 'package:deeznote/common/utils/date.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/utils/screen.dart';
import '../../../domain/impl/meet_impl.dart';

class DetailMeetController extends GetxController {
  //TODO: Implement DetailMeetController
  RxList meetDetail = [].obs;
  RxList buttonDetail = [].obs;
  RxBool isLoading = true.obs;
  RxBool isCanStartMeet = false.obs;
  RxBool isNotulensiExist = false.obs;
  RxBool isSigned = true.obs;
  RxInt statusCode = 0.obs;
  final args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    getDetailMeet();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxMap meetData = {}.obs;

  void getDetailMeet() async {
    isLoading.value = true;
    meetData.value = await MeetRepository().show(id: args['id']);
    statusCode.value = meetData['status_code'];
    isCanStartMeet.value = DateHelper().isGreater(
        DateTime.now(), DateHelper().stringToDate(meetData['meetDate']));
    isNotulensiExist.value = meetData['notulensi'].isNotEmpty;
    if (meetData['notulensi'].isNotEmpty) {
      final res = await NotulensiRepository()
          .show(id: meetData['notulensi'].first['idNotulensi']);
      if (res.isNotEmpty) {
        isSigned.value = res['notulensiSignPIC'].isNotEmpty &&
            res['notulensiSignCust'].isNotEmpty;
      }
    }
    initData();
    isLoading.value = false;
  }

  void startMeet() async {
    if (isCanStartMeet.value && !isNotulensiExist.value) {
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
                Text("Start this meeting",
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
                  "Are you sure want to start this meeting?",
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
                          "Start Now!",
                          style: RsTextStyle.bold.copyWith(color: Colors.white),
                        ),
                        8.gW,
                        Icon(
                          Icons.video_call_rounded,
                          color: Colors.white,
                          size: 18.w,
                        ),
                      ],
                    ),
                    onTap: () async {
                      await EasyLoading.show();
                      final res = await NotulensiRepository().create(
                          meetId: args['id'],
                          notulensiTitle: meetData['meetTitle'],
                          notulensiContent: "",
                          notulensiSignPIC: "",
                          notulensiSignCust: "",
                          dokumentasi: []);
                      if (res.isNotEmpty) {
                        isNotulensiExist.value = true;
                        await EasyLoading.dismiss();
                        Get.back();
                        RsToast.show("Success", "Meeting started");
                        getDetailMeet();
                        Get.toNamed(Routes.MEETING_NOTES, arguments: {
                          'meetId': args['id'],
                          'notulensiId': res['idNotulensi']
                        });
                      }
                    }),
                8.gH,
              ],
            ),
          ),
        ),
      );
    } else {
      if (isNotulensiExist.value) {
        when(statusCode.value, {
          1: () => RsToast.show("Hold On", "Meeting already started"),
          2: () => RsToast.show("Hold On", "Meeting already finished")
        });
      } else {
        RsToast.show("Hold On", "Meeting date not reached yet");
      }
    }
  }

  void initData() async {
    meetDetail.value = [
      {
        'type': 'text',
        'icon': Icons.location_city_rounded,
        'title': 'Office Location',
        'url': '',
        'description': meetData['officeLocation']['locationName'] ?? '-'
      },
      {
        'type': 'text',
        'icon': Icons.people_alt_rounded,
        'title': 'Involved Staff',
        'url': '',
        'description':
            meetData['users'].map((e) => e['name']).toList().join(', ')
      },
      {
        'type': 'url',
        'icon': Icons.file_copy_rounded,
        'title': 'File Attachment',
        'description': meetData['fileAttachment'].isNotEmpty
            ? meetData['fileAttachment'].first['fileTitle']
            : '-',
        'url': meetData['fileAttachment'].isNotEmpty
            ? meetData['fileAttachment'].first['fileLink']
            : null
      },
      {
        'type': 'url',
        'icon': Icons.link,
        'title': 'Meeting Link',
        'url': meetData.containsKey('meetLink') ? meetData['meetLink'] : '-',
        'description':
            meetData.containsKey('meetLink') ? meetData['meetLink'] : '-'
      },
    ];

    buttonDetail.value = [
      {
        'icon': Icons.note_add_rounded,
        'title': 'Meeting Notes',
        'description': "Add or view meeting notes",
        'isEnabled': isNotulensiExist.value,
        'onTap': () {
          if (isNotulensiExist.value) {
            Get.toNamed(Routes.MEETING_NOTES, arguments: {
              'meetID': args['id'],
              'status_code': statusCode.value,
              'notulensiId': meetData['notulensi'].first['idNotulensi']
            });
          } else {
            RsToast.show("Hold On", "Notulensi not created yet");
          }
        }
      },
      {
        'icon': Icons.draw_rounded,
        'title': 'Meeting Sign',
        'description': "Add or view meeting sign",
        'isEnabled': !isSigned.value,
        'onTap': () {
          if (isNotulensiExist.value && !isSigned.value) {
            Get.toNamed(Routes.MEETING_SIGN, arguments: {
              'notulensiId': meetData['notulensi'].first['idNotulensi']
            });
          } else {
            if (isSigned.value) {
              RsToast.show("Hold On", "Meeting already signed");
            }
            if (!isNotulensiExist.value) {
              RsToast.show("Hold On", "Notulensi not created yet");
            }
          }
        }
      },
      {
        'icon': Icons.photo,
        'title': 'Meeting Documentation',
        'description': "Add or view documentation",
        'isEnabled': isNotulensiExist.value,
        'onTap': () {
          if (isNotulensiExist.value) {
            Get.toNamed(Routes.MEETING_PHOTO, arguments: {
              'notulensiId': meetData['notulensi'].first['idNotulensi'],
              'meetId': args['id'],
              'status_code': statusCode.value
            });
          } else {
            RsToast.show("Hold On", "Notulensi not created yet");
          }
        }
      },
      {
        'icon': Icons.download,
        'title': 'Download Meeting',
        'description': "Download meeting notes",
        'isEnabled': isNotulensiExist.value,
        'onTap': () {
          if (isNotulensiExist.value) {
            downloadNotul();
          } else {
            RsToast.show("Hold On", "Notulensi not created yet");
          }
        }
      },
    ];
  }

  void downloadNotul() async {
    await NotulensiRepository().download(
      id: meetData['notulensi'].first['idNotulensi'],
    );
  }

  void editMeet() {
    Get.toNamed(Routes.CREATE_MEET);
  }

  void deleteMeet() {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Meet"),
        content: Text("Are you sure want to delete this meet?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void finishMeet() {
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
              Text("Finish this meeting",
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
                "Are you sure want to finish this meeting?",
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
                        "Confirm",
                        style: RsTextStyle.bold.copyWith(color: Colors.white),
                      ),
                      8.gW,
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18.w,
                      ),
                    ],
                  ),
                  onTap: () async {
                    await EasyLoading.show();
                    final res = await MeetRepository().finish(id: args['id']);
                    if (res.isNotEmpty) {
                      isNotulensiExist.value = true;
                      await EasyLoading.dismiss();
                      Get.back();
                      RsToast.show("Success", "Meeting finished");
                      getDetailMeet();
                    }
                  }),
              8.gH,
            ],
          ),
        ),
      ),
    );
  }
}
