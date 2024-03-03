import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../app/data/models/form_model.dart';
import '../common/enums/form_type.dart';
import '../common/widgets/rs_turing.dart';
import 'controller_config.dart';

class FormConfig with RsValidationMixin {
  List<RsFormModel> loginForm = [
    RsFormModel(
        formType: FormType.text,
        name: 'email',
        controller: ControllerConfig.usernameController,
        label: 'Email',
        hint: 'Enter your email',
        icon: Icons.email_outlined,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ])),
    RsFormModel(
      formType: FormType.password,
      name: 'password',
      controller: ControllerConfig.passwordController,
      label: 'Password',
      hint: 'Enter your password',
      icon: Icons.lock_outline_rounded,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Password is required"),
        // FormBuilderValidators.minLength(8, errorText: "Minimum 8 characters"),
        // FormBuilderValidators.maxLength(20, errorText: "Maximum 20 characters"),
        // FormBuilderValidators.match(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',
        //     errorText:
        //         "Password must contain at least one uppercase letter, one lowercase letter and one number")
      ]),
    ),
  ];

  // List<RsFormModel> profileForm = [
  //   RsFormModel(formType: Form, name: name, controller: controller)
  // ];

  List<RsFormModel> createMeetForm = [
    RsFormModel(
      formType: FormType.text,
      name: "meet_name",
      controller: TextEditingController(),
      label: "Meeting Name",
      hint: "Enter meeting name",
      icon: Icons.video_call_rounded,
    ),
    RsFormModel(
      formType: FormType.date,
      name: "date",
      controller: TextEditingController(),
      label: "Date",
      hint: "Enter meeting date",
      icon: Icons.date_range_rounded,
    ),
    RsFormModel(
      formType: FormType.text,
      name: "customer_name",
      controller: TextEditingController(),
      label: "Customer Name",
      hint: "Enter customer name",
      icon: Icons.person_rounded,
    ),
    RsFormModel(
      formType: FormType.dropdown,
      dataDropdown: [
        {"value": "1", "label": "Kantor Utama"},
        {"value": "2", "label": "Kantor Cabang"}
      ],
      valueField: "value",
      textField: "label",
      name: "office_location",
      controller: TextEditingController(),
      label: "Office Location",
      hint: "Choose office location",
      icon: Icons.location_city_rounded,
    ),
    RsFormModel(
      formType: FormType.dialogPick,
      name: "involved_staff",
      controller: TextEditingController(),
      label: "Involved Staff",
      hint: "Enter Involved Staff",
      icon: Icons.people_alt_rounded,
    ),
    RsFormModel(
      formType: FormType.upload,
      name: "upload",
      controller: TextEditingController(),
      label: "File Attachment",
      hint: "Upload file attachment here",
      icon: Icons.upload_file_rounded,
      fileType: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    ),
    RsFormModel(
      formType: FormType.text,
      name: "meet_link",
      controller: TextEditingController(),
      label: "Meeting Link",
      hint: "Enter meeting link",
      icon: Icons.link,
    ),
    RsFormModel(
      formType: FormType.dropdown,
      dataDropdown: [
        {"value": "1", "label": "H-10"},
        {"value": "2", "label": "H-5"}
      ],
      valueField: "value",
      textField: "label",
      name: "meet_reminder",
      controller: TextEditingController(),
      label: "Meeting Reminder",
      hint: "Choose meeting reminder",
      icon: Icons.location_city_rounded,
    ),
  ];

  List<RsFormModel> updatePasswordForm = [
    RsFormModel(
      formType: FormType.password,
      name: 'old_password',
      controller: TextEditingController(),
      label: 'Old Password',
      hint: 'Enter your old password',
      icon: Icons.lock_clock_outlined,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Password is required"),
        FormBuilderValidators.minLength(8, errorText: "Minimum 8 characters"),
        FormBuilderValidators.maxLength(20, errorText: "Maximum 20 characters"),
        FormBuilderValidators.match(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',
            errorText:
                "Password must contain at least one uppercase letter, one lowercase letter and one number")
      ]),
    ),
    RsFormModel(
      formType: FormType.confirmPassword,
      name: 'new_password',
      controller: TextEditingController(),
      label: 'New Password',
      hint: 'Enter your new password',
      icon: Icons.lock_outline_rounded,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Password is required"),
        FormBuilderValidators.minLength(8, errorText: "Minimum 8 characters"),
        FormBuilderValidators.maxLength(20, errorText: "Maximum 20 characters"),
        FormBuilderValidators.match(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',
            errorText:
                "Password must contain at least one uppercase letter, one lowercase letter and one number")
      ]),
    ),
  ];

  List<RsFormModel> editProfileForm = [
    RsFormModel(
      formType: FormType.text,
      name: "username",
      controller: TextEditingController(),
      label: "Username",
      hint: "resmaadi", // will be placed value field
      icon: Icons.person_2_rounded,
    ),
    RsFormModel(
      formType: FormType.text,
      name: "email",
      controller: TextEditingController(),
      label: "Email",
      hint: "resmaadi@gmail.com", // will be placed value field
      icon: Icons.email_rounded,
    ),
    RsFormModel(
      formType: FormType.text,
      name: "telephone",
      controller: TextEditingController(),
      label: "Telephone",
      hint: "08123456789", // will be placed value field
      icon: Icons.phone_android_rounded,
    ),
    RsFormModel(
      formType: FormType.text,
      name: "departement",
      controller: TextEditingController(),
      label: "Departement",
      hint: "App Department", // will be placed value field
      icon: Icons.work,
    ),
  ];
}
