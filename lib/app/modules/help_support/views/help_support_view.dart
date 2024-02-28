import 'package:deeznote/common/widgets/custom/custom_blank.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
        child: ListView(
          children: [DefaultBlank()],
        ),
      ),
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Help & Support",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        backgroundColor: RsColorScheme.primary,
      ),
      useSafeArea: false,
      bgColor: Colors.white,
    );
  }
}
