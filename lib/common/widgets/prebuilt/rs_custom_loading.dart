import 'package:deeznote/common/widgets/custom/custom_shimmer.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/screen.dart';

class HomeLoadingShimmer extends StatelessWidget {
  const HomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: RsScreen.w * 0.75.w,
          height: RsScreen.w * 0.4.w,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [DoubleLongShimmer()],
          ),
        ),
        const RsBottomSheet(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListLongShimmer(
                count: 6,
              )
            ])
      ],
    );
  }
}
