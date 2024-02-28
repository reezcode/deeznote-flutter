import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/config/form_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/create_meet_controller.dart';

class CreateMeetView extends GetView<CreateMeetController> {
  const CreateMeetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
        child: ListView(
          children: [
            RsFormContainer(
              action: FormAction.create,
              config: FormConfig().createMeetForm,
              buttonText: "Create",
              icon: Icons.add_circle,
              onCreate: (v) {},
            )
          ],
        ),
      ),
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Create Meeting",
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
