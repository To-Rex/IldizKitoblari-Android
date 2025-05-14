import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz_kitoblari/pages/home/sub_category_page.dart';
import '../../companents/category_item.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';

class CategoryPage extends StatelessWidget {
  final int menuIndex;

  CategoryPage({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextLarge(text: 'Kategoriya'.tr, fontWeight: FontWeight.w500),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () => Get.back())
      ),
      body: Obx(() => _getController.menuModel.value.data!.result![menuIndex].children == null
          ? Center(child: TextSmall(text: 'Ma`lumotlar yo`q!', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600))
          : Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _getController.menuModel.value.data!.result?[menuIndex].children!.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                          _getController.menuModel.value.data!.result![menuIndex].children![index].sId!,
                          'uz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!, () {
                            _getController.page.value = 1;
                            _getController.productModelLength.value = 0;
                            _getController.clearProductModel();
                            print('menuIndex: $menuIndex');
                            if (_getController.menuModel.value.data!.result![menuIndex].children![index].children != null) {
                              Get.to(() => SubCategoryPage(
                                title: 'uz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!,
                                menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].slug!,
                                menuIndex: menuIndex,
                                index: index,
                              ));
                            } else {
                              Get.to(() => CatDetailPage(
                                  title: 'uz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!, menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].slug!,
                                  parent: false,
                                  menuIndex: menuIndex
                              ));
                            }
                          },
                          _getController.menuModel.value.data!.result![menuIndex].children![index].productCount == null ? '0' : _getController.menuModel.value.data!.result![menuIndex].children![index].productCount.toString()
                      );
                    })
            )
          ]
      ))
    );
  }
}