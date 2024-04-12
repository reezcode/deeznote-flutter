// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:deeznote/common/extensions/gaps.dart';

import '../../styles/rs_style_library.dart';
import '../../utils/screen.dart';
import '../rs_turing.dart';

class RsError extends StatelessWidget {
  final String msg;
  final bool light;
  final Function() onError;
  const RsError({
    Key? key,
    required this.msg,
    required this.light,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.warning,
            color: light ? Colors.white : RsColorScheme.grey,
            size: 32.w,
          ),
          4.gH,
          Text(
            msg,
            style: RsTextStyle.regular
                .copyWith(color: light ? Colors.white : RsColorScheme.grey),
          ),
          16.gH,
          RsButton(
              width: 120.w,
              buttonColor: RsColorScheme.grey.withOpacity(0.5),
              onTap: onError,
              child: Text(
                "Try Again",
                style: RsTextStyle.bold.copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class RsHomeError extends StatelessWidget {
  final String msg;
  final Function() onError;
  const RsHomeError({
    Key? key,
    required this.msg,
    required this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: RsScreen.w * 0.75.w,
          height: RsScreen.w * 0.4.w,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RsError(
                msg: msg,
                light: true,
                onError: onError,
              )
            ],
          ),
        ),
        RsBottomSheet(
            height: RsScreen.h * 0.7,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RsError(
                msg: msg,
                light: false,
                onError: onError,
              )
            ])
      ],
    );
  }
}
