// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/app/domain/di/controllers/universal_controller.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_card.dart';
import 'package:deeznote/common/widgets/prebuilt/rs_custom_circle_card.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../styles/rs_style_library.dart';

class RsDialogPick extends StatefulWidget {
  final String? label;
  final List<dynamic>? values;
  const RsDialogPick({
    Key? key,
    this.label,
    this.values,
  }) : super(key: key);

  @override
  State<RsDialogPick> createState() => _RsDialogPickState();
}

class _RsDialogPickState extends State<RsDialogPick> {
  UniversalController universalController = Get.find<UniversalController>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _showDialog() {
    Get.dialog(
        Obx(
          () => Center(
            child: Container(
              width: RsScreen.w * 0.8,
              height: RsScreen.h * 0.5,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                children: [
                  RsTextField(
                    name: "search",
                    controller: controller,
                    hint: "Search staff here...",
                    icon: Icons.search,
                    onChanged: (p0) {
                      universalController.searchStaffData(p0 ?? "");
                    },
                  ),
                  Expanded(
                      child: ListView(
                    children: universalController.staffData
                        .map((e) => RsCardStaff(
                              image: e["photo"],
                              isCheck: universalController.isSelected(e["id"]),
                              name: e["name"],
                              role: e["position"],
                              onTap: () {
                                universalController.checkData(e["id"]);
                              },
                            ))
                        .toList(),
                  ))
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 300),
        useSafeArea: true);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
        padding: EdgeInsets.only(bottom: 20.w),
        child: SizedBox(
          width: RsScreen.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label!,
                style: RsTextStyle.semiBold,
              ),
              12.gH,
              GestureDetector(
                onTap: _showDialog,
                child: Container(
                  width: RsScreen.w,
                  height: 60.w,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: RsColorScheme.grey),
                      borderRadius: BorderRadius.circular(15.w)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RsCirclePict(
                        image: universalController.selectedStaffImage.value,
                      ),
                      12.gW,
                      Text(
                        universalController.selectedStaff.value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: RsTextStyle.regular.copyWith(fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
              ),
              12.gH,
              RsButton(
                  width: 130.w,
                  height: 30.h,
                  splashColor: RsColorScheme.secondary,
                  onTap: _showDialog,
                  child: Text(
                    "Choose Staff",
                    style: RsTextStyle.bold
                        .copyWith(color: Colors.white, fontSize: 13.sp),
                  ))
            ],
          ),
        )));
  }
}
