// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currency_formatter/currency_formatter.dart';
import 'package:deeznote/common/extensions/gaps.dart';
import 'package:deeznote/common/widgets/custom/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/color_scheme.dart';
import '../../styles/text_style.dart';
import '../../utils/currency.dart';
import '../../utils/format_date.dart';
import '../../utils/screen.dart';
import '../rs_turing.dart';
import 'rs_custom_circle_card.dart';

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

class RsCardNotif extends StatelessWidget {
  final String type;
  final String title;
  final String description;
  final String date;
  const RsCardNotif({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RsCard(
        width: RsScreen.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  color: RsColorScheme.primary,
                ),
                8.gW,
                Text(
                  type,
                  style:
                      RsTextStyle.medium.copyWith(color: RsColorScheme.primary),
                ),
                const Spacer(),
                Text(
                  "45m ago",
                  style: RsTextStyle.medium
                      .copyWith(fontSize: 12.sp, color: RsColorScheme.primary),
                )
              ],
            ),
            8.gH,
            Text(
              title,
              style: RsTextStyle.bold,
            ),
            8.gH,
            Text(
              description,
              style: RsTextStyle.regular.copyWith(fontSize: 12.sp),
            ),
          ],
        ));
  }
}

class RsCardSettingMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Function() onTap;
  final bool isEnabled;
  const RsCardSettingMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RsButton(
        width: RsScreen.w,
        radius: 10.r,
        buttonColor: RsColorScheme.primaryLight.withOpacity(0.2),
        splashColor: RsColorScheme.secondary,
        height: 60.w,
        margin: EdgeInsets.only(bottom: 16.w),
        isDisabled: !isEnabled,
        disabledColor: RsColorScheme.grey.withOpacity(0.2),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.w,
              color: isEnabled ? RsColorScheme.primary : RsColorScheme.grey,
            ),
            8.gW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: RsTextStyle.bold.copyWith(
                      fontSize: 14.sp,
                      color: isEnabled
                          ? RsColorScheme.primary
                          : RsColorScheme.grey),
                ),
                Text(
                  description,
                  style: RsTextStyle.medium.copyWith(
                      fontSize: 12.sp,
                      color: isEnabled
                          ? RsColorScheme.text.withOpacity(0.8)
                          : RsColorScheme.grey.withOpacity(0.4)),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.w,
              color: isEnabled ? RsColorScheme.primary : RsColorScheme.grey,
            )
          ],
        ));
  }
}

class RsCardStaff extends StatelessWidget {
  final String? image;
  final String? name;
  final String? role;
  final bool? isCheck;
  final void Function() onTap;
  const RsCardStaff({
    Key? key,
    this.image,
    this.name,
    this.role,
    this.isCheck,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RsButton(
        width: RsScreen.w,
        radius: 10.r,
        buttonColor: isCheck!
            ? RsColorScheme.primary
            : RsColorScheme.primaryLight.withOpacity(0.2),
        splashColor: RsColorScheme.secondary,
        height: 60.w,
        margin: EdgeInsets.only(bottom: 16.w),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RsCirclePict(
              image: image,
            ),
            8.gW,
            SizedBox(
              width: RsScreen.w * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name ?? "Resma Adi Nugroho",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: RsTextStyle.bold.copyWith(
                        fontSize: 14.sp,
                        color: isCheck! ? Colors.white : RsColorScheme.primary),
                  ),
                  Text(
                    role ?? "Mobile Developer",
                    style: RsTextStyle.medium.copyWith(
                        fontSize: 12.sp,
                        color: isCheck!
                            ? Colors.white.withOpacity(0.8)
                            : RsColorScheme.text.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            isCheck!
                ? Icon(
                    Icons.check_circle,
                    size: 24.w,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.circle,
                    size: 24.w,
                    color: RsColorScheme.primary,
                  )
          ],
        ));
  }
}

class RsCardListDetail extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String type;
  final Function()? onTap;
  final String? fileSum;
  final List? fileList;
  const RsCardListDetail(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.type,
      this.fileSum,
      this.onTap,
      this.fileList})
      : super(key: key);

  @override
  State<RsCardListDetail> createState() => _RsCardListDetailState();
}

class _RsCardListDetailState extends State<RsCardListDetail> {
  bool isUrl = false;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.type == "url") {
      isUrl = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type == "file" && widget.fileList != null) {
          RsDialog.show(children: [
            Text("File Attachments",
                style: RsTextStyle.bold
                    .copyWith(fontSize: 14.sp, color: RsColorScheme.text)),
            16.gH,
            ...widget.fileList!
                .map((e) => FileAttach(
                      link: e['fileLink'],
                      fileName: e['fileTitle'],
                    ))
                .toList(),
          ]);
        } else if (isUrl) {
          widget.onTap!();
        }
      },
      child: Container(
        width: RsScreen.w,
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: RsColorScheme.text.withOpacity(0.2), width: 1))),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: RsColorScheme.primary,
              size: 24.w,
            ),
            8.gW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: RsTextStyle.bold
                      .copyWith(fontSize: 14.sp, color: RsColorScheme.text),
                ),
                4.gH,
                widget.type == "file"
                    ? Text(
                        "${widget.fileSum ?? "0"} files",
                        style: RsTextStyle.medium.copyWith(
                            fontSize: 12.sp, color: RsColorScheme.text),
                      )
                    : Text(
                        widget.description,
                        style: RsTextStyle.medium.copyWith(
                            fontSize: 12.sp, color: RsColorScheme.text),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RsTab extends StatelessWidget {
  final int currentIdx;
  final Map e;
  final Function(int) onTap;
  const RsTab({
    Key? key,
    required this.currentIdx,
    required this.e,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(e['idx']);
      },
      child: Container(
        width: 190.w,
        height: 45.w,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
            color:
                currentIdx != e['idx'] ? Colors.white : RsColorScheme.primary,
            border: Border.all(color: RsColorScheme.primary),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              e['icon'],
              size: 20,
              color:
                  currentIdx != e['idx'] ? RsColorScheme.primary : Colors.white,
            ),
            8.gW,
            Text(
              e['title'],
              style: (currentIdx != e['idx']
                      ? RsTextStyle.medium
                      : RsTextStyle.bold)
                  .copyWith(
                      fontSize: 13.sp,
                      color: currentIdx != e['idx']
                          ? RsColorScheme.primary
                          : Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
