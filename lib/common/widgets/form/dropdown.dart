// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deeznote/common/extensions/gaps.dart';

import '../../../app/data/models/response_model.dart';
import '../../styles/rs_style_library.dart';

class RsDropdown extends StatefulWidget {
  final String? label;
  final String name;
  final String? hint;
  final IconData? icon;
  final List<dynamic> dataDropdown;
  final Future<ResponseModel>? futureDataDropdown;
  final void Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final String textField;
  final String valueField;
  final TextEditingController? controller;
  const RsDropdown({
    Key? key,
    this.label,
    required this.name,
    this.hint,
    this.icon,
    required this.dataDropdown,
    this.futureDataDropdown,
    this.onChanged,
    this.validator,
    required this.textField,
    required this.valueField,
    this.controller,
  }) : super(key: key);

  @override
  State<RsDropdown> createState() => _RsDropdownState();
}

class _RsDropdownState extends State<RsDropdown> {
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
          (widget.futureDataDropdown != null)
              ? FutureBuilder(
                  future: widget.futureDataDropdown,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FormBuilderDropdown(
                        name: widget.name,
                        style: RsTextStyle.regular,
                        isExpanded: true,
                        elevation: 6,
                        validator: widget.validator,
                        initialValue: widget.controller!.text,
                        borderRadius: BorderRadius.circular(10),
                        decoration: RsInputDecoration.defaultDecoration(
                            hint: widget.hint,
                            label: widget.label,
                            icon: widget.icon),
                        onChanged: (e) async {
                          widget.controller!.text = e.toString();
                          widget.onChanged!(e);
                        },
                        items: snapshot.data!.data
                            .map((e) => DropdownMenuItem(
                                  value: e[widget.valueField],
                                  child: Center(
                                    child: Text(
                                      e[widget.textField],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: RsTextStyle.regular,
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
              : FormBuilderDropdown(
                  name: widget.name,
                  style: RsTextStyle.regular,
                  isExpanded: true,
                  elevation: 6,
                  initialValue: widget.controller!.text,
                  borderRadius: BorderRadius.circular(10),
                  decoration: RsInputDecoration.defaultDecoration(
                      hint: widget.hint,
                      label: widget.label,
                      icon: widget.icon),
                  onChanged: (e) async {
                    widget.controller!.text = e.toString();
                    widget.onChanged!(e);
                  },
                  items: widget.dataDropdown
                      .map((e) => DropdownMenuItem(
                            value: e[widget.valueField],
                            child: Center(
                              child: Text(
                                e[widget.textField],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: RsTextStyle.regular,
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
