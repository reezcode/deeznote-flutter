// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deeznote/common/extensions/gaps.dart';

import '../../../config/main_config.dart';
import '../../styles/color_scheme.dart';
import '../../styles/text_style.dart';

class RsBottomNavbar extends StatelessWidget {
  final void Function(int)? onTap;
  final int? currentIndex;
  const RsBottomNavbar({
    Key? key,
    this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 30.w,
          left: MainConfig.kDefaultMargin,
          right: MainConfig.kDefaultMargin,
        ),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RsItemNavbar(
              index: 0,
              currentIndex: currentIndex ?? 0,
              imageUrl: 'assets/icons/ic_logo.png',
              text: "Dashboard",
              onTap: () => onTap!(0),
            ),
            RsItemNavbar(
              index: 1,
              currentIndex: currentIndex ?? 0,
              imageUrl: 'assets/icons/ic_logo.png',
              text: "Data Center",
              onTap: () => onTap!(1),
            )
          ],
        ),
      ),
    );
  }
}

class RsItemNavbar extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String imageUrl;
  final String text;
  final Function() onTap;
  const RsItemNavbar({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.imageUrl,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: (currentIndex == index) ? RsColorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            0.gW,
            Image.asset(
              imageUrl,
              width: 24,
              height: 24,
              color:
                  (currentIndex == index) ? Colors.white : RsColorScheme.grey,
            ),
            10.gW,
            Text(text,
                style: (currentIndex == index)
                    ? RsTextStyle.bold
                        .copyWith(fontSize: 14, color: Colors.white)
                    : RsTextStyle.semiBold
                        .copyWith(fontSize: 14, color: RsColorScheme.grey))
          ],
        ),
      ),
    );
  }
}
