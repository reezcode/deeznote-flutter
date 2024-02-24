// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotifSection extends StatelessWidget {
  final HomeController controller;
  const NotifSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RsScreen.w,
      height: RsScreen.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: Colors.white,
      child: ListView(
        children: const [
          RsCardNotif(
              type: "Meeting Reminder",
              title: "Kick-Off Meeting KPBU 1",
              description: "Today at 10:00 AM with PT. Hutama Karya PBI",
              date: "24 February 2024")
        ],
      ),
    );
  }
}
