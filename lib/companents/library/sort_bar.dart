import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';
import '../../pages/shop/filter_page1.dart';

class SortBar extends StatelessWidget {
  final String? title;
  SortBar({super.key, required this.title});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
        child: Row(
            children: [
              Expanded(child: Text(title!, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500))),
              InkWell(
                  onTap: () {
                    //showBottomSheet(context);
                  },
                  child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface),
                      child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)))),
              IconButton(
                  onPressed: () {
                    //Get.to(() => FilterPage1(menuIndex: menuIndex, menuSlug: menuSlug,parent: parent), fullscreenDialog: true, transition: Transition.cupertino);
                    //showBottomSheetFilter(context);
                  },
                  icon: Icon(TablerIcons.adjustments_horizontal, size: 25.sp, color: Theme.of(context).colorScheme.onSurface)
              )
            ]
        )
    );
  }

}