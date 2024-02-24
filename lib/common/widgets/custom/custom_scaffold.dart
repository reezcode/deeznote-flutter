import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../config/main_config.dart';
import '../../utils/screen.dart';

class RsScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appbar;
  final Color statusBarColor, systemNavigationBarColor;
  final Color? bgColor;
  final Brightness statusBarIconBrightness, systemNavigationBarIconBrightness;
  final bool withNavbar;
  final bool useSafeArea;
  final String? bgImg;
  final int? currentIndex;
  final void Function(int)? onTap;

  const RsScaffold({
    super.key,
    required this.body,
    required this.useSafeArea,
    this.statusBarColor = Colors.transparent,
    this.statusBarIconBrightness = Brightness.dark,
    this.systemNavigationBarIconBrightness = Brightness.dark,
    this.systemNavigationBarColor = Colors.black,
    this.appbar,
    this.withNavbar = false,
    this.bgColor,
    this.bgImg,
    this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        systemNavigationBarColor: systemNavigationBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appbar,
        body: (useSafeArea)
            ? SafeArea(
                child: Stack(
                  children: [
                    body,
                    // Positioned(
                    //   top: 0,
                    //   child: appbar,
                    // ),
                    withNavbar ? GoogleNavbar(onTap: onTap) : const SizedBox()
                  ],
                ),
              )
            : Container(
                width: RsScreen.w,
                height: RsScreen.h,
                decoration: BoxDecoration(
                  image: bgImg != null
                      ? DecorationImage(
                          image: AssetImage(bgImg ??
                              MainConfig.kDefaultAssetImagePlaceholder),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: withNavbar
                    ? Stack(
                        children: [
                          body,
                          // Positioned(
                          //   top: 0,
                          //   child: appbar,
                          // ),
                          GoogleNavbar(onTap: onTap)
                        ],
                      )
                    : body,
              ),
      ),
    );
  }
}

class GoogleNavbar extends StatelessWidget {
  const GoogleNavbar({
    super.key,
    required this.onTap,
  });

  final void Function(int p1)? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: GNav(
          rippleColor: RsColorScheme.primaryLight,
          hoverColor: RsColorScheme.primary.withOpacity(0.5),
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: RsColorScheme.primaryLight.withOpacity(0.3),
          color: Colors.black,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.calendar,
              text: 'Meetings',
            ),
            GButton(
              icon: LineIcons.bell,
              text: 'Notif',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ],
          onTabChange: onTap,
        ),
      ),
    );
  }
}
