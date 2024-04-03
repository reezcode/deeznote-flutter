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
