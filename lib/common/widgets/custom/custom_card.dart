// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:deeznote/common/styles/rs_style_library.dart';

class RsCard extends StatelessWidget {
  final double width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final double? radius;
  final Color? color;
  const RsCard({
    Key? key,
    required this.width,
    this.height,
    this.margin,
    this.padding,
    required this.child,
    this.radius,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? RsColorScheme.primaryLight.withOpacity(0.15),

          borderRadius: BorderRadius.circular(radius ?? 10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.05),
          //     spreadRadius: 1,
          //     blurRadius: 10,
          //     offset: const Offset(0, 4), // changes position of shadow
          //   ),
          // ]
        ),
        child: child);
  }
}
