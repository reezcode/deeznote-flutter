import 'package:deeznote/app/domain/impl/notulensi_impl.dart';
import 'package:deeznote/common/widgets/custom/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class MeetingNotesController extends GetxController {
  //TODO: Implement MeetingNotesController

  HtmlEditorController htmlEditorController = HtmlEditorController();
  final args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      final res = await NotulensiRepository().show(id: args['notulensiId']);
      if (res.isNotEmpty) {
        htmlEditorController.setText(res['notulensiContent']);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void saveMeetingNotes() async {
    final meetNotes = await htmlEditorController.getText();
    NotulensiRepository()
        .update(
            meetIdMeet: args['meetId'],
            id: args['notulensiId'],
            notulensiContent: meetNotes)
        .then((value) {
      if (value.isNotEmpty) {
        RsToast.show("Success", "Meeting notes has been saved");
      } else {
        RsToast.show("Failed", "Failed to save meeting notes");
      }
    });
  }
}
