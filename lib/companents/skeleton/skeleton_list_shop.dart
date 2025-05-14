import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../resource/colors.dart';

class SkeletonListShop extends StatelessWidget {
  const SkeletonListShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
              margin: EdgeInsets.only(left: Get.width * 0.01, right: Get.width * 0.03),
              child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10.sp),
                        child: Skeletonizer(
                            child: Icon(
                              TablerIcons.barcode,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 20.sp,
                            )
                        )
                    ),
                    Text('${'Barbarising tanlash'.tr}')
                  ]
              )
          ),
          Container(margin: EdgeInsets.only(top: 5.sp, bottom: 18.sp, left: 18.w, right: 18.w), child: Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
          ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                padding: EdgeInsets.only(right: Get.width * 0.03, left: Get.width * 0.01),
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return  SizedBox(
                      height: 131.h,
                      child: Row(
                          children: [
                            Container(margin: EdgeInsets.all(10.sp), child: Skeletonizer(child: Icon(TablerIcons.barcode, color: Theme.of(context).colorScheme.onSurface, size: 20.sp))),
                            Container(
                                width: 118.w,
                                height: 116.h,
                                margin: EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.015),
                                child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {if (loadingProgress == null) {return child;}return SizedBox(width: Get.width * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: Get.width * 0.44, height: Get.height * 0.205, color: AppColors.grey)));}, errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))
                            ),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5.h),
                                      Text('salom',maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      Text('100 ${'so‘m'.tr}',maxLines: 1, style: TextStyle(color: AppColors.primaryColor2, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      Row(
                                          children: [
                                            Text('O‘chirish'.tr, style: TextStyle(color: AppColors.red, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                                            const Spacer(),
                                            Container(
                                                  height: 40.h,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey.withOpacity(0.2)),
                                                  child: Row(
                                                      children: [
                                                        IconButton(color: Theme.of(context).colorScheme.onSurface, onPressed: () {}, icon: Icon(TablerIcons.minus, color: Theme.of(context).colorScheme.onSurface, size: 17.sp)),
                                                        SizedBox(width: 5.w),
                                                        Text('10', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                                        SizedBox(width: 5.w),
                                                        IconButton(color: Theme.of(context).colorScheme.onSurface, onPressed: () {}, icon: Icon(TablerIcons.plus, color: Theme.of(context).colorScheme.onSurface, size: 17.sp))
                                                      ]
                                                  )
                                              )
                                          ]
                                      ),
                                      SizedBox(height: 20.h)
                                    ]
                                )
                            )
                          ]
                      )
                  );
                }
            )
        ]
    );
  }
}
