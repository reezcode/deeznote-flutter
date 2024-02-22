import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_scheme.dart';

class RsTextStyle {
  static TextStyle regular = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    color: RsColorScheme.text,
    fontSize: 14.sp,
  );
  static TextStyle medium = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w500,
    color: RsColorScheme.text,
    fontSize: 14.sp,
  );
  static TextStyle semiBold = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    color: RsColorScheme.text,
    fontSize: 14.sp,
  );
  static TextStyle bold = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    color: RsColorScheme.text,
    fontSize: 14.sp,
  );
  static TextStyle extraBold = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w800,
    color: RsColorScheme.text,
    fontSize: 14.sp,
  );
}
