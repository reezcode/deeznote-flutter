import 'package:deeznote/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailMeetController extends GetxController {
  //TODO: Implement DetailMeetController
  RxList meetDetail = [].obs;
  RxList buttonDetail = [].obs;

  @override
  void onInit() {
    initData();
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

  void initData() async {
    meetDetail.value = [
      {
        'icon': Icons.location_city_rounded,
        'title': 'Office Location',
        'description': 'Office 8, 18th Floor, SCBD Lot 28, Jakarta'
      },
      {
        'icon': Icons.people_alt_rounded,
        'title': 'Involved Staff',
        'description': 'Resma Adi, Irwan F and 3 others'
      },
      {
        'icon': Icons.file_copy_rounded,
        'title': 'File Attachment',
        'description': 'See attachment file here'
      },
      {
        'icon': Icons.link,
        'title': 'Meeting Link',
        'description': 'https://meet.google.com/abc-xyz-123'
      },
    ];

    buttonDetail.value = [
      {
        'icon': Icons.note_add_rounded,
        'title': 'Meeting Notes',
        'description': "Add or view meeting notes",
        'onTap': () {
          Get.toNamed(Routes.MEETING_NOTES);
        }
      },
      {
        'icon': Icons.draw_rounded,
        'title': 'Meeting Sign',
        'description': "Add or view meeting sign",
        'onTap': () {
          Get.toNamed(Routes.MEETING_SIGN);
        }
      },
      {
        'icon': Icons.photo,
        'title': 'Meeting Documentation',
        'description': "Add or view meeting documentation",
        'onTap': () {
          Get.toNamed(Routes.MEETING_PHOTO);
        }
      }
    ];
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
}
