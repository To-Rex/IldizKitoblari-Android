import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class AuthorItem extends StatelessWidget {
  final String sId;
  final String title;
  final String subTitle;
  final String image;
  var onTap;
  bool? switchValue;
  Color? color;
  final int index;

  AuthorItem({super.key,required this.sId, required this.title, required this.subTitle, required this.image, required this.onTap, this.switchValue, this.color, required this.index});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            margin: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.035, vertical: _getController.width.value * 0.02),
            color: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Theme.of(context).colorScheme.onSurface,
            elevation: 5,
            shadowColor: Theme.of(context).colorScheme.surface,
            child: Container(
                width: _getController.width.value,
                padding: EdgeInsets.only(right: Get.width * 0.02,left: image == '' ? Get.width * 0.02 : 0,top: image == '' ? Get.width * 0.01:0,bottom: image == '' ? Get.width * 0.01:0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).colorScheme.surface),
                child: Row(
                    children: [
                      if (image != '')
                        Container(width: 90.w, height: 90.h, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)))
                      else
                        Icon(Icons.person, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), size: 30.sp),
                      SizedBox(width: _getController.width.value * 0.02),
                      Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
                            Text('$subTitle ${'ta kitob'.tr}', style: TextStyle(fontSize: 16.sp, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w500))
                          ]
                      )),
                      Icon(TablerIcons.arrow_right, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), size: 25.sp)
                    ]
                )
            )
        )
    );
  }
}
