// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:deeznote/common/extensions/gaps.dart';

class ListLongShimmer extends StatelessWidget {
  final int? count;
  const ListLongShimmer({
    Key? key,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (var i = 0; i < (count ?? 4); i++)
                Container(
                  width: double.infinity,
                  height: 65.w,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.w)),
                ),
            ],
          ),
        ));
  }
}

class DoubleLongShimmer extends StatelessWidget {
  const DoubleLongShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 45.w,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.w)),
              ),
              12.gH,
              Container(
                width: double.infinity,
                height: 45.w,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.w)),
              ),
            ],
          ),
        ));
  }
}
