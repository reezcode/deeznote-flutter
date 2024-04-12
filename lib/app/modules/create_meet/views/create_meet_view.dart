import 'package:deeznote/common/enums/form_type.dart';
import 'package:deeznote/common/widgets/custom/custom_shimmer.dart';
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
      body: Obx(
        () => controller.isLoading.value
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: const ListLongShimmer(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    RsFormContainer(
                      action: FormAction.create,
                      config: controller.formConfig,
                      buttonText: controller.args['type'] == FormAction.create
                          ? "Create"
                          : "Update",
                      icon: controller.args['type'] == FormAction.create
                          ? Icons.add_circle
                          : Icons.save,
                      onCreate: controller.cuMeet,
                    )
                  ],
                ),
              ),
      ),
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          controller.args['type'] == FormAction.create
              ? "Create Meeting"
              : "Edit Meeting",
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
