import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class RsPhotoView extends StatelessWidget {
  const RsPhotoView({
    super.key,
    required this.imgSrc,
    required this.child,
  });

  final Widget child;
  final ImageProvider<Object> imgSrc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Stack(
            alignment: Alignment.center,
            children: [
              PhotoView(
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                imageProvider: imgSrc,
              ),
              Positioned(
                bottom: 64.w,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: 32.w,
                    height: 32.w,
                    child: Image.asset('assets/icons/ic_cross_rounded.png'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: child,
    );
  }
}
