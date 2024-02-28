import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/config/form_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../../../../common/widgets/rs_turing.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
        child: ListView(
          children: [
            RsFormContainer(
              action: FormAction.update,
              config: FormConfig().editProfileForm,
              buttonText: "Edit Profile",
              onUpdate: (v) {},
              icon: Icons.save,
            )
          ],
        ),
      ),
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Edit Profile",
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
