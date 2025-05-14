import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resource/colors.dart';
import 'filds/text_small.dart';

class DetailElement extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  const DetailElement({super.key, required this.title, required this.subTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.sp),
      child: Row(
        children: <Widget>[
          Icon(icon, color: AppColors.primaryColor, size: Theme.of(context).iconTheme.fill ?? 20.sp),
          SizedBox(width: 2.sp),
          TextSmall(text: title, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 15.sp),
          SizedBox(width: 2.sp),
          TextSmall(text: subTitle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 15.sp)
        ]
      )
    );
  }
}