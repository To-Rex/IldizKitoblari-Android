import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/category_item.dart';
import '../../companents/filds/text_large.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';

class SubCategoryPage extends StatelessWidget {
  final String title;
  final String menuSlug;
  final int menuIndex;
  final int index;

  SubCategoryPage({super.key, required this.title, required this.menuSlug, required this.menuIndex, required this.index});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(title),
            centerTitle: false,
            toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () => Get.back())
        ),
        body: Obx(() {
          final menuModel = _getController.menuModel.value.data?.result;
          if (menuModel == null || menuModel.isEmpty) {
            return Center(
                child: TextLarge(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
            );
          }

          final childrenList = menuModel[menuIndex].children;
          if (childrenList == null || index >= childrenList.length) {
            return Center(
                child: TextLarge(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
            );
          }

          final subChildrenList = childrenList[index].children;
          if (subChildrenList == null || subChildrenList.isEmpty) {
            return Center(
                child: TextLarge(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)
            );
          }

          return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: subChildrenList.length,
                        itemBuilder: (context, indexs) {
                          final child = subChildrenList[indexs];
                          return CategoryItem(
                              child.sId!,
                              _getController.getLocale() == 'uz_UZ' ? child.title?.uz ?? '' : _getController.getLocale() == 'oz_UZ' ? child.title?.oz ?? '' : child.title?.ru ?? '', () {
                            _getController.page.value = 1;
                            _getController.productModelLength.value = 0;
                            _getController.clearProductModel();
                            Get.to(() => CatDetailPage(title: _getController.getLocale() == 'uz_UZ' ? child.title?.uz ?? '' : _getController.getLocale() == 'oz_UZ' ? child.title?.oz ?? '' : child.title?.ru ?? '', menuSlug: child.slug!, parent: false, menuIndex: menuIndex));
                          },
                              child.productCount?.toString() ?? '0'
                          );
                        }
                    )
                )
              ]
          );
        })
    );
  }
}
