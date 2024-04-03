// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deeznote/common/styles/rs_style_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RsCirclePict extends StatelessWidget {
  final double? width;
  final double? height;
  final String? image;
  const RsCirclePict({
    Key? key,
    this.width,
    this.height,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 30.w,
      height: height ?? 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.w),
          image: DecorationImage(
              image: NetworkImage(image ?? 'https://via.placeholder.com/150'),
              fit: BoxFit.cover)),
    );
  }
}

class RsCircleBlank extends StatelessWidget {
  final double? width;
  final double? height;
  final String? char;
  final Color? color;
  const RsCircleBlank({
    Key? key,
    this.width,
    this.height,
    this.char,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 30.w,
      height: height ?? 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.w),
        color: color ?? RsColorScheme.secondary,
      ),
      child: Center(
          child: Text(
        char ?? 'A',
        style: RsTextStyle.bold
            .copyWith(color: RsColorScheme.text, fontSize: 12.sp),
      )),
    );
  }
}
