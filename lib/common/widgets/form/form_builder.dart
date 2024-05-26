// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/widgets/form/dialog_pick.dart';

import '../../../app/data/models/response_model.dart';
import '../../../config/main_config.dart';
import '../../enums/form_type.dart';
import '../../styles/color_scheme.dart';
import '../../styles/text_style.dart';
import '../../utils/screen.dart';
import '../rs_turing.dart';

class RsFormBuilder extends StatelessWidget {
  final FormType formType;
  final String name;
  final String? hint;
  final String? label;
  final String? valueField;
  final String? textField;
  final TextEditingController controller;
  final IconData? icon;
  final void Function()? onObscurePressed;
  final void Function()? onObscureSecondPressed;
  final String? Function(String?)? validator;
  final String? Function(DateTime?)? validatorDateTime;
  final String? Function(dynamic)? validatorDynamic;
  final bool obscureText;
  final bool? obscureSecondText;
  final void Function(dynamic)? onChanged;
  final List<dynamic>? dataDropdown;
  final Future<ResponseModel>? futureDataDropdown;
  final FileType? fileType;
  final List<String>? allowedExtensions;
  final DateTime? initDateValue;
  const RsFormBuilder(
      {super.key,
      required this.formType,
      required this.name,
      this.hint,
      this.label,
      this.valueField,
      this.textField,
      required this.controller,
      this.icon,
      this.onObscurePressed,
      this.onObscureSecondPressed,
      this.validator,
      required this.obscureText,
      this.obscureSecondText,
      this.onChanged,
      this.dataDropdown,
      this.futureDataDropdown,
      this.fileType,
      this.allowedExtensions,
      this.initDateValue,
      this.validatorDateTime,
      this.validatorDynamic});

  @override
  Widget build(BuildContext context) {
    if (formType == FormType.text) {
      return RsTextField(
          name: name,
          controller: controller,
          hint: hint,
          label: label,
          onChanged: onChanged,
          validator: validator,
          icon: icon);
    } else if (formType == FormType.password) {
      return RsPasswordField(
        name: name,
        controller: controller,
        hint: hint,
        label: label,
        obscureText: obscureText,
        validator: validator,
        onObscurePressed: onObscurePressed,
        onChanged: onChanged,
      );
    } else if (formType == FormType.dropdown) {
      return RsDropdown(
        name: name,
        dataDropdown: dataDropdown!,
        hint: hint,
        label: label,
        icon: icon,
        onChanged: onChanged,
        validator: validator,
        textField: textField!,
        valueField: valueField!,
        futureDataDropdown: futureDataDropdown,
        controller: controller,
      );
    } else if (formType == FormType.upload) {
      return RsUploadFile(
        hint: hint,
        label: label,
        name: name,
        icon: icon,
        fileType: fileType,
        allowedExtensions: allowedExtensions,
      );
    } else if (formType == FormType.confirmPassword) {
      return RsPasswordField(
        name: name,
        controller: controller,
        hint: hint,
        label: label,
        validator: validator,
        obscureText: obscureSecondText ?? true,
        onObscurePressed: onObscureSecondPressed,
        onChanged: onChanged,
      );
    } else if (formType == FormType.date) {
      return RsDatePicker(
        initDateValue: initDateValue,
        hint: hint,
        label: label,
        name: name,
        onChanged: onChanged,
        validator: validatorDateTime,
      );
    } else if (formType == FormType.dialogPick) {
      return RsDialogPick(
        label: label,
      );
    } else if (formType == FormType.radio) {
      return RsRadioOptions(
        name: name,
        controller: controller,
        dataList: dataDropdown,
        value: valueField,
        onChanged: onChanged,
        text: textField,
        label: label,
        validator: validatorDynamic,
      );
    } else {
      return const SizedBox();
    }
  }
}

class RsFormContainer extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final FormAction action;
  final void Function(GlobalKey<FormBuilderState>)? onCreate;
  final void Function(GlobalKey<FormBuilderState>)? onUpdate;
  final void Function(GlobalKey<FormBuilderState>)? onRead;
  final List<dynamic> config;
  final String buttonText;
  final IconData? icon;
  const RsFormContainer({
    super.key,
    this.margin,
    this.padding,
    required this.action,
    this.onCreate,
    this.onUpdate,
    this.onRead,
    required this.config,
    required this.buttonText,
    this.icon,
  });

  @override
  State<RsFormContainer> createState() => _RsFormContainerState();
}

class _RsFormContainerState extends State<RsFormContainer>
    with RsValidationMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: widget.margin,
          padding: widget.padding,
          child: FormBuilder(
            key: _formKey,
            child: Column(children: [
              ...widget.config.map((e) => RsFormBuilder(
                    formType: e.formType,
                    name: e.name,
                    controller: e.controller,
                    dataDropdown: e.dataDropdown,
                    futureDataDropdown: e.futureDataDropdown,
                    hint: e.hint,
                    icon: e.icon,
                    label: e.label,
                    validatorDateTime: e.validatorDateTime,
                    validatorDynamic: e.validatorDynamic,
                    onChanged: (p) {
                      e.onChanged?.call(p);
                      MainConfig.universalController.formKeyChecker(_formKey);
                    },
                    validator: e.validator,
                    obscureText:
                        MainConfig.universalController.isPasswordVisible.value,
                    onObscurePressed:
                        MainConfig.universalController.togglePasswordVisibility,
                    obscureSecondText:
                        MainConfig.universalController.isPasswordVisible2.value,
                    onObscureSecondPressed: MainConfig
                        .universalController.togglePasswordVisibility2,
                    textField: e.textField,
                    valueField: e.valueField,
                    initDateValue: e.initDateValue,
                  )),
              RsButton(
                  radius: 12.w,
                  width: RsScreen.w,
                  buttonColor: MainConfig.universalController.isValid.value
                      ? RsColorScheme.primary
                      : RsColorScheme.grey,
                  splashColor: RsColorScheme.secondary,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.buttonText,
                            style: RsTextStyle.bold.copyWith(
                              color: Colors.white,
                            )),
                        10.gW,
                        Icon(
                          widget.icon,
                          color: Colors.white,
                        )
                      ]),
                  onTap: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      if (widget.action == FormAction.create) {
                        widget.onCreate!(_formKey);
                      } else if (widget.action == FormAction.update) {
                        widget.onUpdate!(_formKey);
                      } else if (widget.action == FormAction.read) {
                        widget.onRead!(_formKey);
                      }
                    } else {
                      RsToast.show(
                          'Warning ⚠️', 'There are some invalid fields');
                    }
                  })
            ]),
          ),
        ));
  }
}
