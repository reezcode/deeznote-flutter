import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
