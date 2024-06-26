// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deeznote/app/data/sources/local/local_storage.dart';
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
              CachedNetworkImage(
                imageUrl: 'user_detail'.load()['profilePict'],
                imageBuilder: (context, imageProvider) => Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ),
              ),
              8.gH,
              Text(
                'user_detail'.load()['name'],
                style: RsTextStyle.bold
                    .copyWith(fontSize: 18.sp, color: Colors.white),
              ),
              Chip(
                label: Text(
                  'user_detail'.load()['role'],
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
                    isEnabled: true,
                    description: e['description'],
                    onTap: e['onTap']),
              )
              .toList(),
          24.gH,
          RsButton(
              width: RsScreen.w,
              radius: 10.r,
              splashColor: RsColorScheme.secondary,
              onTap: controller.logOut,
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
              )),
          32.gH
        ])
      ],
    );
  }
}
