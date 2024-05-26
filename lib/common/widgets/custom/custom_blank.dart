import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/rs_style_library.dart';
import '../../utils/screen.dart';

class DefaultBlank extends StatelessWidget {
  const DefaultBlank({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: RsScreen.w * 0.4.w,
          height: 250.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/img_bg_default_blank.png'),
              fit: BoxFit.contain,
            ),
          )),
    );
  }
}

class CardBlank extends StatelessWidget {
  const CardBlank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: RsScreen.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: RsColorScheme.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upcoming_rounded,
                color: RsColorScheme.grey.withOpacity(0.7), size: 40),
            Text("That's all for this week",
                style: RsTextStyle.medium.copyWith(
                    color: RsColorScheme.grey.withOpacity(0.7),
                    fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}

class EmptyMeetings extends StatelessWidget {
  const EmptyMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: RsScreen.w * 0.8,
      height: 70.w,
      decoration: BoxDecoration(
        color: RsColorScheme.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
        child: Text(
          "Touch grass 🍃, \nthere is no meeting today",
          textAlign: TextAlign.center,
          style: RsTextStyle.regular.copyWith(color: RsColorScheme.grey),
        ),
      ),
    ));
  }
}
