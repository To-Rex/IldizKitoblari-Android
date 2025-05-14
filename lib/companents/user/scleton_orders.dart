import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../resource/colors.dart';

class SkeletonOrders extends StatefulWidget {

  const SkeletonOrders({super.key});

  @override
  State<SkeletonOrders> createState() => _ProductItemState();
}

class _ProductItemState extends State<SkeletonOrders> {

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              Container(
                width: Get.width,
                margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,bottom: Get.height * 0.01),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Theme.of(context).colorScheme.background, boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 5)]),
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        Text('Muvaffaqiyatli'.tr),
                        const Spacer(),
                        Text('Muvaffaqiyatli'.tr)
                      ]
                    ),
                    SizedBox(height: Get.height * 0.01),
                    const Divider(),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        Text('Muvaffaqiyatli'.tr),
                      ]
                    ),
                    SizedBox(height: Get.height * 0.01)
                  ]
                )
              )
          ]
        )
    );
  }
}