// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:deeznote/config/main_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/styles/rs_style_library.dart';
import '../../../../../common/widgets/rs_turing.dart';

class ProfileSection extends StatelessWidget {
  final HomeController controller;
  const ProfileSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: RsScreen.w * 0.75.w,
          height: RsScreen.w * 0.55.w,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.r),
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/img_profile_photo.png'),
                        fit: BoxFit.cover)),
              ),
              8.gH,
              Text(
                "Resma Adi Nugroho",
                style: RsTextStyle.bold
                    .copyWith(fontSize: 18.sp, color: Colors.white),
              ),
              Chip(
                label: Text(
                  "Mobile Developer",
                  style: RsTextStyle.semiBold
                      .copyWith(fontSize: 12.sp, color: RsColorScheme.text),
                ),
                backgroundColor: RsColorScheme.secondary,
              ),
            ],
          ),
        ),
        RsBottomSheet(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...MainConfig()
              .profileListButton
              .map(
                (e) => RsCardSettingMenu(
                    icon: e['icon'],
                    title: e['title'],
                    description: e['description'],
                    onTap: e['onTap']),
              )
              .toList(),
          24.gH,
          RsButton(
              width: RsScreen.w,
              radius: 10.r,
              splashColor: RsColorScheme.secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Log Out",
                    style: RsTextStyle.bold
                        .copyWith(fontSize: 14.sp, color: Colors.white),
                  ),
                  4.gW,
                  Icon(
                    Icons.logout_rounded,
                    size: 21.w,
                    color: Colors.white,
                  )
                ],
              ),
              onTap: () {}),
          32.gH
        ])
      ],
    );
  }
}
