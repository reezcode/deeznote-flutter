import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../common/enums/form_type.dart';
import 'response_model.dart';

class RsFormModel {
  RsFormModel(
      {required this.formType,
      required this.name,
      this.hint,
      this.label,
      this.valueField,
      this.textField,
      required this.controller,
      this.icon,
      this.onObscurePressed,
      this.onObscureSecondPressed,
      this.obscureText = false,
      this.obscureSecondText = false,
      this.onChanged,
      this.dataDropdown,
      this.futureDataDropdown,
      this.validator,
      this.allowedExtensions,
      this.initDateValue,
      this.fileType});

  FormType formType;
  String name;
  String? hint;
  String? label;
  String? valueField;
  String? textField;
  TextEditingController controller;
  IconData? icon;
  void Function()? onObscurePressed;
  void Function()? onObscureSecondPressed;
  String? Function(String?)? validator;
  bool obscureText;
  bool? obscureSecondText;
  void Function(dynamic)? onChanged;
  List<dynamic>? dataDropdown;
  Future<ResponseModel>? futureDataDropdown;
  FileType? fileType;
  List<String>? allowedExtensions;
  DateTime? initDateValue;

  RsFormModel copyWith({
    FormType? formType,
    String? name,
    String? hint,
    String? label,
    String? valueField,
    String? textField,
    TextEditingController? controller,
    IconData? icon,
    void Function()? onObscurePressed,
    bool? obscureText,
    void Function(dynamic)? onChanged,
    List<dynamic>? dataDropdown,
    Future<ResponseModel>? futureDataDropdown,
    FileType? fileType,
    List<String>? allowedExtensions,
  }) =>
      RsFormModel(
        formType: formType ?? this.formType,
        name: name ?? this.name,
        hint: hint ?? this.hint,
        label: label ?? this.label,
        valueField: valueField ?? this.valueField,
        textField: textField ?? this.textField,
        controller: controller ?? this.controller,
        icon: icon ?? this.icon,
        onObscurePressed: onObscurePressed ?? this.onObscurePressed,
        obscureText: obscureText ?? this.obscureText,
        obscureSecondText: obscureSecondText ?? this.obscureSecondText,
        onObscureSecondPressed:
            onObscureSecondPressed ?? this.onObscureSecondPressed,
        validator: validator ?? this.validator,
        onChanged: onChanged ?? this.onChanged,
        dataDropdown: dataDropdown ?? this.dataDropdown,
        futureDataDropdown: futureDataDropdown ?? this.futureDataDropdown,
        fileType: fileType ?? this.fileType,
        allowedExtensions: allowedExtensions ?? this.allowedExtensions,
      );

  factory RsFormModel.fromJson(Map<String, dynamic> json) => RsFormModel(
        formType: json["formType"],
        name: json["name"],
        hint: json["hint"],
        label: json["label"],
        valueField: json["valueField"],
        textField: json["textField"],
        controller: json["controller"],
        icon: json["icon"],
        onObscurePressed: json["onObscurePressed"],
        onObscureSecondPressed: json["onObscureSecondPressed"],
        obscureText: json["obscureText"],
        obscureSecondText: json["obscureSecondText"],
        onChanged: json["onChanged"],
        dataDropdown: json["dataDropdown"],
        validator: json["validator"],
        futureDataDropdown: json["futureDataDropdown"],
        allowedExtensions: json["allowedExtensions"],
        fileType: json["fileType"],
      );

  Map<String, dynamic> toJson() => {
        "formType": formType,
        "name": name,
        "hint": hint,
        "label": label,
        "valueField": valueField,
        "textField": textField,
        "controller": controller,
        "icon": icon,
        "onObscurePressed": onObscurePressed,
        "onObscureSecondPressed": onObscureSecondPressed,
        "validator": validator,
        "obscureText": obscureText,
        "obscureSecondText": obscureSecondText,
        "onChanged": onChanged,
        "dataDropdown": dataDropdown,
        "futureDataDropdown": futureDataDropdown,
        "allowedExtensions": allowedExtensions,
        "fileType": fileType,
      };
}
