import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../styles/rs_style_library.dart';

class RsRadioOptions extends StatefulWidget {
  final String? label;
  final String name;
  final String? value;
  final String? text;
  final List<dynamic>? dataList;
  final String? Function(dynamic)? validator;
  final TextEditingController? controller;
  final Function(dynamic)? onChanged;
  const RsRadioOptions({
    Key? key,
    this.label,
    required this.name,
    this.value,
    this.text,
    this.dataList,
    this.validator,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RsRadioOptions> createState() => _RsRadioOptionsState();
}

class _RsRadioOptionsState extends State<RsRadioOptions> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      name: widget.name,
      onChanged: (value) {
        widget.onChanged!(value);
        widget.controller!.text = value!.toString();
      },
      initialValue: widget.controller!.text,
      decoration: InputDecoration(
          labelStyle: RsTextStyle.semiBold.copyWith(fontSize: 19.sp),
          labelText: widget.label,
          border: InputBorder.none),
      options: widget.dataList!
          .map((e) => FormBuilderFieldOption(
                value: e[widget.value ?? 'value'],
                child: Text(e[widget.text ?? 'text'],
                    style: RsTextStyle.regular.copyWith(fontSize: 12.sp)),
              ))
          .toList(),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: "${widget.label} is required"),
      ]),
      activeColor: RsColorScheme.primary,
      orientation: OptionsOrientation.vertical,
    );
  }
}
