import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resource/colors.dart';

class IndicatorOrder extends StatelessWidget {
  final int index;
  final bool? isBook;
  const IndicatorOrder({super.key, required this.index, this.isBook = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBook == false)
            Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.width * 0.012,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  decoration: BoxDecoration(
                    color: index == 0 ? AppColors.primaryColor3 : index == 1 || index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Text(
                    'Yetkazib berish manzili'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: index == 0 ? AppColors.primaryColor3 : index == 1 || index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.width * 0.012,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  decoration: BoxDecoration(
                    color: index == 1 ? AppColors.primaryColor3 : index == 0 ? AppColors.grey : index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Text(
                    'To‘lov turi'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: index == 1 ? AppColors.primaryColor3 : index == 0 ? AppColors.grey : index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.width * 0.012,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  decoration: BoxDecoration(
                    color: index == 2 ? AppColors.primaryColor3 : index == 0 || index == 1 ? AppColors.grey : AppColors.primaryColor2,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Text(
                    'Buyurtmani tasdiqlash'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: index == 2 ? AppColors.primaryColor3 : index == 0 || index == 1 ? AppColors.grey : AppColors.primaryColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

