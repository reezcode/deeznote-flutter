// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deeznote/common/extensions/gaps.dart';

import '../../styles/color_scheme.dart';
import '../../styles/input_decoration.dart';
import '../../styles/rs_style_library.dart';
import '../rs_turing.dart';

class RsTextField extends StatefulWidget {
  final String? label;
  final String name;
  final String? hint;
  final IconData? icon;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextEditingController controller;
  const RsTextField({
    Key? key,
    this.label,
    required this.name,
    this.hint,
    this.icon,
    this.validator,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<RsTextField> createState() => _RsTextFieldState();
}

class _RsTextFieldState extends State<RsTextField> with RsValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label!,
              style: RsTextStyle.semiBold,
            ),
            12.gH,
            FormBuilderTextField(
              name: widget.name,
              style: RsTextStyle.regular,
              onChanged: widget.onChanged,
              validator: widget.validator ?? validateUserName,
              cursorColor: RsColorScheme.primary,
              controller: widget.controller,
              decoration: RsInputDecoration.defaultDecoration(
                  hint: widget.hint, icon: widget.icon, label: widget.label!),
            ),
          ],
        ));
  }
}
