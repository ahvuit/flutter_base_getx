import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  static double setWidth(double width) => width.w;
  static double setHeight(double height) => height.h;
  static double setSp(double fontSize) => fontSize.sp;
  static double radius(double radius) => radius.r;

  static double screenWidth(BuildContext context) => ScreenUtil().screenWidth;
  static double screenHeight(BuildContext context) => ScreenUtil().screenHeight;
}
