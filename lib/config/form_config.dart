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
        FormBuilderValidators.minLength(8, errorText: "Minimum 8 characters"),
        FormBuilderValidators.maxLength(20, errorText: "Maximum 20 characters"),
        FormBuilderValidators.match(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',
            errorText:
                "Password must contain at least one uppercase letter, one lowercase letter and one number")
      ]),
    ),
  ];

  // List<RsFormModel> profileForm = [
  //   RsFormModel(formType: Form, name: name, controller: controller)
  // ];
}
