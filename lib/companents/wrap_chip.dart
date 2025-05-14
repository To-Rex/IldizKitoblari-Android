import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../models/menu_model.dart';
import '../resource/colors.dart';

class WrapChip extends StatelessWidget {
  final int index;
  final List title;
  final Function(int) function;
  final int? select;
  final bool more;
  final IconData icon;
  final String optionId;
  final String menuSlug;
  final GetController _getController = Get.put(GetController());

  WrapChip({super.key, required this.index,required this.title, required this.function, required this.select, this.more = false, required this.icon, required this.optionId, required this.menuSlug});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.02, bottom: Get.height * 0.02),
        child: Wrap(
            spacing: Get.width * 0.02,
            runSpacing: Get.height * 0.006,
            children: [
              for (var i in title)
                InkWell(
                    onTap: () {
                      function(title.indexOf(i));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Text(i, style: TextStyle(color: title.indexOf(i) == select ? AppColors.white : Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                        labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        deleteIcon: title.indexOf(i) == select ? Icon(icon, color: title.indexOf(i) == select ? AppColors.white : Theme.of(context).colorScheme.onSurface, size: 17.sp) : null,
                        deleteIconColor: title.indexOf(i) == select ? Theme.of(context).colorScheme.onSurface : null,
                        deleteButtonTooltipMessage: title.indexOf(i) == select ? 'Selected' : null,
                        onDeleted: title.indexOf(i) == select ? () {
                          function(title.indexOf(i));
                        } : null,
                        backgroundColor: select != null ? title.indexOf(i) == select ? AppColors.primaryColor : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2) : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                ),
              if (more)
                InkWell(
                    onTap: () {
                      function(title.length);
                      _getController.changeFiltersPage(index);
                      ApiController().getMenuOptions(_getController.filtersPage[index], optionId, menuSlug, 10, true, index);
                      print('filtersPage: ${_getController.filtersPage}');
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      width: Get.width,
                      height: Get.height * 0.045,
                      margin: EdgeInsets.only(top: Get.height * 0.01),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ko‘proq ko‘rsatish'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                            Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).colorScheme.onSurface, size: 25.sp)
                          ],
                        )
                      )
                    )
                )
            ]
        )
    );
  }
}