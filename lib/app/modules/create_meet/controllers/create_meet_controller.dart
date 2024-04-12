import 'package:deeznote/app/domain/di/controllers/universal_controller.dart';
import 'package:deeznote/app/domain/impl/meet_impl.dart';
import 'package:deeznote/app/domain/impl/office_impl.dart';
import 'package:deeznote/app/domain/impl/staff_impl.dart';
import 'package:deeznote/app/modules/detail_meet/controllers/detail_meet_controller.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/enums/form_type.dart';
import '../../../data/models/form_model.dart';
import '../../../domain/di/controllers/upload_controller.dart';

class CreateMeetController extends GetxController {
  //TODO: Implement CreateMeetController
  UniversalController universalController = Get.find<UniversalController>();
  UploadController uploadController = Get.find<UploadController>();
  final args = Get.arguments;

  /// CONTROLLER ///
  TextEditingController meetNameController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController meetLinkController = TextEditingController();
  TextEditingController reminderController = TextEditingController();

  /// ---- ///

  @override
  void onInit() {
    super.onInit();
    if (args['type'] == FormAction.update) initUpdate();
    getInitData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    universalController.selectedData.clear();
    universalController.selectedStaff.value = "Choose Staff Here...";
    universalController.selectedStaffImage.value =
        "https://via.placeholder.com/150";
    uploadController.listFile.clear();
  }

  RxList officeList = [].obs;
  RxList staffList = [].obs;
  RxList formConfig = [].obs;
  RxBool isLoading = true.obs;

  void cuMeet(GlobalKey<FormBuilderState> form) async {
    await EasyLoading.show();
    final formData = form.currentState!.value;
    final res = (args['type'] == FormAction.create)
        ? await MeetRepository().create(
            meetTitle: formData['meet_name'],
            meetDate:
                "${DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(formData['date'].toString()).toUtc())}Z",
            officeId: formData['office_location'],
            meetLink: formData['meet_link'],
            attachment: uploadController.listFile,
            meetReminder: int.parse(formData['meet_reminder'].isNotEmpty
                ? formData['meet_reminder']
                : '5'),
            involvedStaff: universalController.selectedData,
            customerName: formData['customer_name'],
          )
        : await MeetRepository().update(
            id: args['data']['idMeet'],
            meetTitle: formData['meet_name'],
            meetDate:
                "${DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(formData['date'].toString()).toUtc())}Z",
            officeId: formData['office_location'],
            meetLink: formData['meet_link'],
            attachment: uploadController.listFile,
            meetReminder: int.parse(formData['meet_reminder'].isNotEmpty
                ? formData['meet_reminder']
                : '5'),
            involvedStaff: universalController.selectedData,
            customerName: formData['customer_name'],
          );
    if (res.isNotEmpty) {
      EasyLoading.dismiss();
      DetailMeetController detailMeetController = Get.find();
      detailMeetController.getDetailMeet();
      Get.back();
      RsToast.show("Success",
          "Meeting ${args['type'] == FormAction.create ? 'created' : 'updated'} successfully 🎉");
      universalController.selectedData.clear();
      uploadController.listFile.clear();
    } else {
      EasyLoading.dismiss();
      RsToast.show("Error",
          "Failed to ${args['type'] == FormAction.create ? 'create' : 'update'} meeting 😪");
    }
  }

  void initUpdate() {
    final data = args['data'];
    meetNameController.text = data['meetTitle'];
    customerController.text = data['customerName'];
    // locationController.text = data['officeLocation']['idOfficeLocation'];
    meetLinkController.text = data['meetLink'];
    // reminderController.text = data['meetReminder'].toString();
  }

  void getInitData() async {
    officeList.value = await OfficeRepository().list();
    staffList.value = await StaffRepository().list();
    isLoading.value = false;
    universalController.staffData.value = staffList;

    formConfig.value = [
      RsFormModel(
        formType: FormType.text,
        name: "meet_name",
        controller: meetNameController,
        label: "Meeting Name",
        hint: "Fill meeting name",
        icon: Icons.video_call_rounded,
      ),
      RsFormModel(
        formType: FormType.date,
        name: "date",
        controller: TextEditingController(),
        initDateValue: (args['type'] == FormAction.update)
            ? DateTime.parse(args['data']['meetDate'])
            : null,
        label: "Tanggal",
        hint: "Pilih tanggal",
        icon: Icons.date_range_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Tanggal is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.text,
        name: "customer_name",
        controller: customerController,
        label: "Nama Customer",
        hint: "Masukan nama customer",
        icon: Icons.person_rounded,
      ),
      RsFormModel(
        formType: FormType.dropdown,
        dataDropdown: officeList,
        valueField: "idOfficeLocation",
        textField: "locationName",
        name: "office_location",
        controller: locationController,
        label: "Lokasi Kantor",
        hint: "Pilih lokasi kantor",
        icon: Icons.location_city_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Lokasi kantor is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.dialogPick,
        name: "involved_staff",
        controller: TextEditingController(),
        label: "Personel Terlibat",
        hint: "Pilih personel terlibat",
        icon: Icons.people_alt_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Personel terlibat is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.upload,
        name: "upload",
        controller: TextEditingController(),
        label: "File Attachment",
        hint: "Upload file attachment disini",
        icon: Icons.upload_file_rounded,
        fileType: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      ),
      RsFormModel(
        formType: FormType.text,
        name: "meet_link",
        controller: meetLinkController,
        label: "Link Meeting",
        hint: "Masukan link meeting",
        icon: Icons.link,
      ),
      RsFormModel(
        formType: FormType.text,
        name: "meet_reminder",
        controller: reminderController,
        label: "Pengingat Meeting (Hari)",
        hint: "Masukan pengingat meeting",
        icon: Icons.location_city_rounded,
      ),
    ];
  }
}
