// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import '../../styles/color_scheme.dart';
import '../../styles/text_style.dart';
import '../../utils/currency.dart';
import '../../utils/format_date.dart';
import '../../utils/screen.dart';
import '../custom/custom_card.dart';

class RsCardH2YS extends StatelessWidget {
  final String name;
  final String? imgUrl;
  final String description;
  const RsCardH2YS({
    Key? key,
    required this.name,
    this.imgUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: RsCard(
          width: RsScreen.w,
          radius: 15.w,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/ic_warung.png'))),
                ),
                20.gW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: RsTextStyle.bold,
                    ),
                    4.gH,
                    SizedBox(
                      width: RsScreen.w * 0.55,
                      child: Text(
                        description,
                        style: RsTextStyle.regular.copyWith(
                            fontSize: 12.sp, color: RsColorScheme.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class RsCardH3YC extends StatelessWidget {
  final String code;
  final String price;
  final String date;
  final String status;
  final String shift;
  final String method;
  final Map<String, dynamic>? colorMap;
  const RsCardH3YC({
    Key? key,
    required this.code,
    required this.price,
    required this.date,
    required this.status,
    required this.shift,
    required this.method,
    this.colorMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.w),
      child: RsCard(
          width: RsScreen.w,
          radius: 15.w,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: const BoxDecoration(
                      color: RsColorScheme.primaryLight,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Image.asset(
                      "assets/icons/ic_money.png",
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                ),
                20.gW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code,
                      style: RsTextStyle.bold,
                    ),
                    2.gH,
                    Row(
                      children: [
                        Text(
                          CurrencyFormatter.format(price, idrSetting,
                              decimal: 0),
                          style: RsTextStyle.regular.copyWith(
                              fontSize: 12.sp, color: RsColorScheme.primary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        4.gW,
                        Text(
                          "• ${formatDateTime(date, false)}",
                          style: RsTextStyle.regular.copyWith(
                              fontSize: 12.sp, color: RsColorScheme.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    4.gH,
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.w),
                          decoration: BoxDecoration(
                              color: RsColorScheme.primary,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              "Shift $shift",
                              style: RsTextStyle.regular.copyWith(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        8.gW,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.w),
                          decoration: BoxDecoration(
                              color: RsColorScheme.primary,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              status,
                              style: RsTextStyle.regular.copyWith(
                                  fontSize: 10.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        8.gW,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.w),
                          decoration: BoxDecoration(
                              color: RsColorScheme.background,
                              border: Border.all(
                                  color: RsColorScheme.grey, width: 1.w),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              method,
                              style: RsTextStyle.regular.copyWith(
                                  fontSize: 10.sp, color: RsColorScheme.grey),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
