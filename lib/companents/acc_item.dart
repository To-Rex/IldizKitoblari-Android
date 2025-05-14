import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../resource/colors.dart';
import 'filds/text_small.dart';

class AccItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final String icon;
  var onTaps;
  var switchValue;
  final Color? color;

  AccItem({super.key, required this.title, required this.subTitle, required this.icon, required this.onTaps, this.switchValue, this.color});

  @override
  State<AccItem> createState() => _AccItemState();
}

class _AccItemState extends State<AccItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 17.3.h,
      title: Row(
        children: [
          TextSmall(text: widget.title, color: widget.color ?? Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600,fontSize: 18.sp),
          const Spacer(),
          TextSmall(text: widget.subTitle, color: widget.color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w500,fontSize: 14.sp)
        ]
      ),
      leading: Container(
        padding: EdgeInsets.all(11.sp),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        ),
        child: SvgPicture.asset(widget.icon,
          colorFilter: ColorFilter.mode(widget.color ?? Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          height: 22.h
        )
      ),
      trailing: widget.switchValue != null ? CupertinoSwitch(
          value: Theme.of(context).brightness == Brightness.dark ? widget.switchValue! : !widget.switchValue!,
          onChanged: (value) {
            AdaptiveTheme.of(context).brightness == Brightness.light ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
            setState(() {
              widget.switchValue = value;
            });
          },
          activeColor: AppColors.green,
          trackColor: AppColors.grey.withOpacity(0.5),
          focusColor: AppColors.green,
          thumbColor: Theme.of(context).colorScheme.surface,
          applyTheme: true
      ) : Icon(Icons.arrow_forward, color: widget.color ?? Theme.of(context).colorScheme.onSurface,
          size: 22.sp
      ),
      onTap: widget.onTaps,
    );
  }
}