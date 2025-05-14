import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../resource/colors.dart';
import 'filds/text_small.dart';

class SkeletonItem extends StatefulWidget {
  const SkeletonItem({super.key});
  @override
  State<SkeletonItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<SkeletonItem> {

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: Container(
            margin: EdgeInsets.only(top: 5.sp, right: 15.sp),
            width: 185.sp,
            height: 384.h,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 185.sp, height: 190.sp, child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png', fit: BoxFit.cover))),
                  SizedBox(height: 10.sp),
                  Container(margin: EdgeInsets.only(right: 5.sp), child: TextSmall( text: 'Assalom', fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),),
                  SizedBox(height: 5.sp),
                  Row(children: [Expanded(child: Text('300 ${'so‘m'.tr}', style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)))]),
                  Row(
                      children: [
                        InkWell(onTap: () {}, child: Icon(TablerIcons.shopping_cart_plus, size: 18.sp, color: AppColors.secondaryColor)),
                        SizedBox(width: 2.sp),
                        Expanded(child:  TextSmall(text: 'Sotuvda mavjud emas', fontSize: 14.sp, color: AppColors.secondaryColor, fontWeight: FontWeight.w600))
                      ]
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      height: 35.h,
                      width: 190.w,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          child: Text('Xarid'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w600))
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      height: 35.h,
                      width: 190.w,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          child: Text('Savatga qo‘shish'.tr, maxLines: 1, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600))
                      )
                  )
                ]
            )
        )
    );
  }
}