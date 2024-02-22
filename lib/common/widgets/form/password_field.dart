// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deeznote/common/extensions/gaps.dart';

import '../../styles/color_scheme.dart';
import '../../styles/rs_style_library.dart';

class RsPasswordField extends StatelessWidget {
  final String? label;
  final String name;
  final String? hint;
  final bool obscureText;
  final TextEditingController controller;
  final void Function()? onObscurePressed;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  const RsPasswordField({
    Key? key,
    this.label,
    required this.name,
    this.hint,
    required this.obscureText,
    required this.controller,
    this.onObscurePressed,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label!,
              style: RsTextStyle.semiBold,
            ),
            12.gH,
            FormBuilderTextField(
              name: name,
              style: RsTextStyle.regular,
              decoration: RsInputDecoration.passwordDecoration(
                  hint: hint,
                  label: label!,
                  isObscure: obscureText,
                  onObscurePressed: onObscurePressed),
              obscureText: obscureText,
              validator: validator,
              controller: controller,
              cursorColor: RsColorScheme.primary,
              obscuringCharacter: "*",
              onChanged: onChanged,
            ),
          ],
        ));
  }
}
