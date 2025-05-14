import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Function function;
  final String count;

  CategoryItem(this.id, this.title, this.function, this.count, {super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        function();
      },
      child: Container(
        width: _getController.width.value,
        margin: EdgeInsets.only(bottom: _getController.width.value * 0.01, top: _getController.width.value * 0.01, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
        padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.width.value * 0.01),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.grey.withOpacity(0.2)),
        child: Row(
          children:[
            Container(
              width: 35.sp,
              height: 35.sp,
              margin: EdgeInsets.only(right: _getController.width.value * 0.04),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: Theme.of(context).colorScheme.surface),
              child: Center(child: Icon(Icons.category, size: 20.sp, color: Theme.of(context).colorScheme.onSurface))
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title, maxLines: 2, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400)),
                    Text('$count ${'ta kitob'.tr}', maxLines: 1, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)))
                  ],
                )
            ),
            Icon(Icons.arrow_forward, size: 25.sp, color: Theme.of(context).colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}