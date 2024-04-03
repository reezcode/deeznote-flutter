import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/color_scheme.dart';

class RsButton extends StatelessWidget {
  const RsButton({
    super.key,
    required this.child,
    required this.onTap,
    this.buttonColor = RsColorScheme.primary,
    this.splashColor = RsColorScheme.primary,
    this.height = 50,
    this.radius = 40,
    this.width = 200,
    this.margin = const EdgeInsets.all(0),
    this.isDisabled,
    this.disabledColor,
  });

  final Widget child;
  final void Function() onTap;
  final Color buttonColor, splashColor;
  final double height, radius, width;
  final EdgeInsets margin;
  final bool? isDisabled;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.w,
      margin: margin,
      decoration: BoxDecoration(
        color: isDisabled ?? false
            ? disabledColor ?? RsColorScheme.primaryDark
            : buttonColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: splashColor,
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
