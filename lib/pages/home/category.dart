import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';
import 'category_page.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Kategoriya'.tr),
            centerTitle: false,
            toolbarTextStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp),
              onPressed: () {Get.back();}
            )
        ),
        body: Obx(() => _getController.menuModel.value.data == null
            ? Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)))
            : SizedBox(
            width: _getController.width.value,
            height: _getController.height.value,
            child: ListView.builder(
                itemCount: _getController.menuModel.value.data == null ? 0 : _getController.menuModel.value.data!.result!.length,
                itemBuilder: (context, index) => CategoryItem(
                      _getController.menuModel.value.data!.result![index].sId!,
                      'uz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![index].title!.uz! : 'oz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![index].title!.oz! : _getController.menuModel.value.data!.result![index].title!.ru!, () {
                        if (_getController.menuModel.value.data!.result![index].children == null) {
                          Get.to(() => CatDetailPage(
                            title: 'uz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![index].title!.uz! : 'oz_UZ' == _getController.getLocale() ? _getController.menuModel.value.data!.result![index].title!.oz! : _getController.menuModel.value.data!.result![index].title!.ru!,
                            menuSlug: _getController.menuModel.value.data!.result![index].slug!,
                            parent: false,
                            menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![index]),
                          ));
                        } else {
                          Get.to(() => CategoryPage(menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![index])));
                        }
                      },
                    _getController.menuModel.value.data!.result![index].productCount == null ? '0' : _getController.menuModel.value.data!.result![index].productCount!.toString()
                  )
                )
        ))
    );
  }
}
