import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ComponentSize {
  static double backIcons(BuildContext context) {
    return Theme.of(context).iconTheme.size ?? 24.sp;
  }

  static double starIcons(BuildContext context) {
    return Theme.of(context).iconTheme.fill ?? 32.sp;
  }
  static double? textSmall(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.fontSize;
  }

  static double? textLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall?.fontSize;
  }
}