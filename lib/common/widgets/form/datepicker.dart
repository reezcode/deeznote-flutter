// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/styles/rs_style_library.dart';

class RsDatePicker extends StatelessWidget {
  final String name;
  final String? hint;
  final String? label;
  final Function(DateTime?)? onChanged;
  final DateTime? initDateValue;
  const RsDatePicker({
    Key? key,
    required this.name,
    this.hint,
    this.label,
    this.onChanged,
    this.initDateValue,
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
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.both,
              format: DateFormat('dd-MM-yyyy, hh:mm a'),
              decoration: RsInputDecoration.defaultDecoration(
                  hint: hint, label: label, icon: Icons.date_range_rounded),
              initialDate: DateTime.now(),
              style: RsTextStyle.regular,
              onChanged: onChanged,
              initialValue: initDateValue,
            )
          ],
        ));
  }
}
