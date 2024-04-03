import 'package:deeznote/common/utils/screen.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../common/styles/rs_style_library.dart';
import '../controllers/meeting_notes_controller.dart';

class MeetingNotesView extends GetView<MeetingNotesController> {
  const MeetingNotesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RsScaffold(
      useSafeArea: false,
      bgColor: Colors.white,
      appbar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          Visibility(
            visible: controller.args['status_code'] == 1,
            child: IconButton(
              onPressed: () {
                controller.saveMeetingNotes();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          )
        ],
        title: Text(
          "Meeting Notes",
          style:
              RsTextStyle.bold.copyWith(color: Colors.white, fontSize: 18.sp),
        ),
        backgroundColor: RsColorScheme.primary,
      ),
      body: ListView(
        children: [
          HtmlEditor(
            controller: controller.htmlEditorController,
            htmlEditorOptions: HtmlEditorOptions(
              hint: "Type meeting notes here...",
            ),
            otherOptions: OtherOptions(
              height: RsScreen.h * 0.80,
            ),
            htmlToolbarOptions: HtmlToolbarOptions(
                toolbarPosition: ToolbarPosition.belowEditor),
          )
        ],
      ),
    );
  }
}
