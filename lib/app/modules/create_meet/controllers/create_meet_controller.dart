import 'package:deeznote/app/domain/di/controllers/universal_controller.dart';
import 'package:deeznote/app/domain/impl/meet_impl.dart';
import 'package:deeznote/app/domain/impl/office_impl.dart';
import 'package:deeznote/app/domain/impl/staff_impl.dart';
import 'package:deeznote/app/modules/detail_meet/controllers/detail_meet_controller.dart';
import 'package:deeznote/app/modules/home/controllers/home_controller.dart';
import 'package:deeznote/common/utils/core.dart';
import 'package:deeznote/common/widgets/rs_turing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController customerEmailControlelr = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController alternativeLocationController = TextEditingController();
  TextEditingController meetLinkController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController locationTypeController = TextEditingController();

  /// ---- ///
  RxInt isOffline = 0.obs;
  // 0 = null, 1 = offline, 2 = online
  RxString onlineId = "".obs;
  RxBool isCustomActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    getInitData();
    if (args['type'] == FormAction.update) initUpdate();
    buildForm();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    universalController.selectedData.value = [];
    universalController.selectedStaff.value = "Choose Staff Here...";
    universalController.selectedStaffImage.value =
        "https://via.placeholder.com/150";
    uploadController.listFile.value = [];
    uploadController.fileList.clear();
  }

  RxList officeList = [].obs;
  RxList staffList = [].obs;
  RxList formConfig = [].obs;
  RxBool isLoading = true.obs;

  void cuMeet(GlobalKey<FormBuilderState> form) async {
    await EasyLoading.show();
    if (isOffline.value == 1) {
      meetLinkController.clear();
    }
    final formData = form.currentState!.value;

    final res = (args['type'] == FormAction.create)
        ? await MeetRepository().create(
            meetTitle: formData['meet_name'],
            projectName: formData['project_name'],
            customerEmail: formData['customer_email'],
            meetDate:
                "${DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(formData['date'].toString()).toUtc())}Z",
            officeId: (!isCustomActive.value)
                ? when(isOffline, {
                    1: () => formData['office_location'],
                    2: () => onlineId.value,
                  })
                : null,
            alternativeLocation: formData['custom_location'],
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
            projectName: formData['project_name'],
            customerEmail: formData['customer_email'],
            meetDate:
                "${DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(DateTime.parse(formData['date'].toString()).toUtc())}Z",
            officeId: (!isCustomActive.value)
                ? when(isOffline, {
                    1: () => formData['office_location'],
                    2: () => onlineId.value,
                  })
                : null,
            alternativeLocation: formData['custom_location'],
            meetLink: meetLinkController.text,
            attachment: uploadController.listFile,
            meetReminder: int.parse(formData['meet_reminder'].isNotEmpty
                ? formData['meet_reminder']
                : '5'),
            involvedStaff: universalController.selectedData,
            customerName: formData['customer_name'],
          );
    if (res.isNotEmpty) {
      EasyLoading.dismiss();
      if (args['type'] == FormAction.update) {
        DetailMeetController detailMeetController = Get.find();
        detailMeetController.getDetailMeet();
      } else {
        HomeController homeController = Get.find();
        homeController.getDashboardData();
      }
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
    final staff = data['users'];
    isOffline.value =
        data['meetLink'] == null || data['meetLink'].isEmpty ? 1 : 2;
    isCustomActive.value = data['alternativeLocation'] != null &&
        data['alternativeLocation'].isNotEmpty;
    meetNameController.text = data['meetTitle'];
    customerController.text = data['customerName'];
    customerEmailControlelr.text = data['customerEmail'];
    projectNameController.text = data['projectName'];
    locationTypeController.text = data['meetLink'].isNotEmpty ? "2" : "1";
    if (isOffline.value == 1) {
      if (isCustomActive.value) {
        locationController.text = "custom";
        alternativeLocationController.text = data['alternativeLocation'];
      } else {
        locationController.text = data['officeLocation']['idOfficeLocation'];
      }
    }
    meetLinkController.text = data['meetLink'];
    reminderController.text = data['meetReminder'].toString();
    universalController.selectedStaffImage.value = staff[0]['profilePict'];
    universalController.selectedStaff.value = staff.length > 1
        ? "${staff[0]['name']} +${staff.length - 1} others"
        : staff[0]['name'];
    universalController.selectedData.value = staff.map((e) => e['id']).toList();
    if (data['fileAttachment'].isNotEmpty) {
      uploadController.listFile.value = data['fileAttachment']
          .map((e) => e['idFileContainer'])
          .toList()
          .cast<String>();
      uploadController.fileList.value = data['fileAttachment']
          .map((e) => {
                'id': e['idFileContainer'],
                'name': e['fileTitle'],
                'link': e['fileLink']
              })
          .toList()
          .cast<Map>();
    }
  }

  void getInitData() async {
    officeList.value = await OfficeRepository().list();
    staffList.value = await StaffRepository().list();
    onlineId.value = officeList
        .where((e) => e['locationName'] == "Online")
        .first['idOfficeLocation'];
    officeList.removeWhere((e) => e['locationName'] == "Online");
    // add custom location that user can fill by themself
    officeList.add({
      "idOfficeLocation": "custom",
      "locationName": "Enter custom location"
    });
    isLoading.value = false;
    universalController.staffData.value = staffList;
  }

  void buildForm() {
    formConfig.value = [
      RsFormModel(
        formType: FormType.text,
        name: "meet_name",
        controller: meetNameController,
        label: "Meeting Name*",
        hint: "Fill meeting name",
        icon: Icons.video_call_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required<String>(
              errorText: "Meeting name is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.date,
        name: "date",
        controller: TextEditingController(),
        initDateValue: (args['type'] == FormAction.update)
            ? DateTime.parse(args['data']['meetDate'])
            : null,
        label: "Date*",
        hint: "Choose date meeting",
        icon: Icons.date_range_rounded,
        validatorDateTime: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Date is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.text,
        name: "project_name",
        controller: projectNameController,
        label: "Project Name*",
        hint: "Fill project name",
        icon: Icons.work_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(errorText: "Project name is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.text,
        name: "customer_name",
        controller: customerController,
        label: "Stakeholder Name*",
        hint: "Fill stakeholder name",
        icon: Icons.person_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Stakeholder name is required"),
        ]),
      ),
      RsFormModel(
        formType: FormType.text,
        name: "customer_email",
        controller: customerEmailControlelr,
        label: "Stakeholder Email*",
        hint: "Fill stakeholder email",
        icon: Icons.email_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Stakeholder email is required"),
          FormBuilderValidators.email(errorText: "Invalid email format"),
        ]),
      ),
      RsFormModel(
          formType: FormType.radio,
          name: 'location_type',
          label: "Location Type*",
          controller: locationTypeController,
          onChanged: (p0) {
            isOffline.value = int.parse(p0);
            isCustomActive.value = false;
            buildForm();
          },
          dataDropdown: [
            {"value": "1", "text": "Offline"},
            {"value": "2", "text": "Online"},
          ]),
      if (isOffline.value == 1)
        RsFormModel(
          formType: FormType.dropdown,
          dataDropdown: officeList,
          valueField: "idOfficeLocation",
          textField: "locationName",
          name: "office_location",
          controller: locationController,
          label: "Office Location*",
          hint: "Choose office location",
          icon: Icons.location_city_rounded,
          onChanged: (p0) {
            if (p0 == "custom") {
              isCustomActive.value = true;
            } else {
              isCustomActive.value = false;
            }
            buildForm();
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Office location is required"),
          ]),
        ),
      if (isCustomActive.value)
        RsFormModel(
          formType: FormType.text,
          name: "custom_location",
          controller: alternativeLocationController,
          label: "Custom Location*",
          hint: "Fill custom location",
          icon: Icons.location_city_rounded,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Office location is required"),
          ]),
        ),
      if (isOffline.value == 2)
        RsFormModel(
          formType: FormType.text,
          name: "meet_link",
          controller: meetLinkController,
          label: "Meeting Link*",
          hint: "Fill meeting link",
          icon: Icons.link,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Link meeting is required"),
            FormBuilderValidators.url(
                errorText: "Invalid URL format", requireProtocol: true),
          ]),
        ),
      RsFormModel(
        formType: FormType.dialogPick,
        name: "involved_staff",
        controller: TextEditingController(),
        label: "Involved Staff*",
        hint: "Choose staff involved in this meeting",
        icon: Icons.people_alt_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Involved staff is required"),
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
        name: "meet_reminder",
        controller: reminderController,
        label: "Meeting Reminder(Days)*",
        hint: "FIll meeting reminder in days",
        icon: Icons.location_city_rounded,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(
              errorText: "Meeting reminder is required"),
        ]),
      ),
    ];
  }
}
