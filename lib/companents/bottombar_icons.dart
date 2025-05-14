import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';
import 'filds/text_small.dart';

class BottomBarIcons extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;

  BottomBarIcons({super.key, required this.icon, required this.title,required this.isSelected});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getController.width * 0.17,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(icon, width: 25.sp, height: 25.sp, colorFilter: isSelected ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : null),
              SizedBox(height: 3.sp),
              Expanded(child: TextSmall(text: title, color: isSelected ? AppColors.primaryColor : AppColors.grey,fontSize: 13.sp, fontWeight: FontWeight.w500))
            ]
        )
    );
  }
}
