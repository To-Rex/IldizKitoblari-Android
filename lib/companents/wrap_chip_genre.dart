import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../models/menu_model.dart';
import '../resource/colors.dart';

class WrapChipGenre extends StatelessWidget {
  final Function(int) function;
  var select;
  var icon;
  final GetController _getController = Get.put(GetController());

  WrapChipGenre({super.key, required this.function, required this.select, required this.icon});


  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.01, top: Get.height * 0.02, bottom: Get.height * 0.02),
        child: Wrap(
            spacing: Get.width * 0.02,
            runSpacing: Get.height * 0.006,
            children: [
              if (_getController.genreIndex.value == 1 || _getController.genreIndex.value == 2)
                InkWell(
                    onTap: () {
                      if (_getController.genreIndex.value == 1) {
                        _getController.genreIndex.value = 0;
                      } else {
                        _getController.genreIndex.value = 1;
                        select = null;
                      }
                      _getController.filterGenre[0]= null;
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Icon(Icons.arrow_back, color: AppColors.white, size: 25.sp),
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                        labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),
                        backgroundColor: AppColors.primaryColor,
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                ),
              if (_getController.genreIndex.value == 0)
                for (var i in _getController.menuModel.value.data!.result!)
                  InkWell(
                      onTap: () {
                        _getController.genreIndex.value = 1;
                        function(_getController.menuModel.value.data!.result!.indexOf(i));
                        _getController.genreIndexSub.value = _getController.menuModel.value.data!.result!.indexOf(i);
                        _getController.filterGenre.clear();
                        _getController.filterGenre.add(null);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Chip(
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, style: TextStyle(color: select != null ?  _getController.genreIndex.value == 0 && _getController.menuModel.value.data!.result!.indexOf(i) == select ? AppColors.white : AppColors.black : AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                          labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                          deleteIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).colorScheme.onBackground, size: 25.sp),
                          deleteIconColor: AppColors.white,
                          deleteButtonTooltipMessage: 'Selected',
                          onDeleted: () {},
                          side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                          backgroundColor: select != null ?  _getController.menuModel.value.data!.result!.indexOf(i) == select ? AppColors.primaryColor : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2) : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                      )
                  ),
              if (_getController.genreIndex.value == 1 && _getController.genreIndexSub.value != null)
                for (var i in _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children!)
                  InkWell(
                      onTap: () {
                        select = null;
                        function(_getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children!.indexOf(i));
                        if (i.children != null) {
                          _getController.genreIndex.value = 2;
                          _getController.genreIndexSubSub.value = _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children!.indexOf(i);
                          _getController.filterGenre[0]= null;
                        }
                        print(_getController.genreIndexSubSub.value);
                        },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Chip(
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, style: TextStyle(color: select != null ?  _getController.genreIndex.value != 1 || _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children!.indexOf(i) == select ? AppColors.white : AppColors.black : AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                          labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                          deleteIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).colorScheme.onBackground, size: 25.sp),
                          deleteIconColor: AppColors.white,
                          deleteButtonTooltipMessage: 'Selected',
                          onDeleted: i.children == null ? null : () {},
                          side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),
                          backgroundColor: select != null ?  _getController.genreIndex.value != 1 || _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children!.indexOf(i) == select ? AppColors.primaryColor : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2) : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                      )
                  ),
              if (_getController.genreIndex.value == 2 && _getController.genreIndexSub.value != null && _getController.genreIndexSubSub.value != null)
                for (var i in _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children![_getController.genreIndexSubSub.value].children!)
                  InkWell(
                      onTap: () {
                        select = null;
                        function(_getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children![_getController.genreIndexSubSub.value].children!.indexOf(i));
                        print(_getController.genreIndexSubSub.value);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Chip(
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, style: TextStyle(color: select != null ?  _getController.genreIndex.value != 2 ||  _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children![_getController.genreIndexSubSub.value].children!.indexOf(i) == select ? AppColors.white : AppColors.black : AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                          labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                          side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),
                          backgroundColor: select != null ?  _getController.genreIndex.value != 2 || _getController.menuModel.value.data!.result![_getController.genreIndexSub.value].children![_getController.genreIndexSubSub.value].children!.indexOf(i) == select ? AppColors.primaryColor : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2) : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                      )
                  )
            ]
        )
    );
  }
}
