import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/wrap_chip.dart';
import '../../companents/wrap_chip_genre.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';


class FilterPage1 extends StatelessWidget{
  final int menuIndex;
  final String menuSlug;
  final bool? parent;
  FilterPage1({super.key, required this.menuIndex, required this.menuSlug, this.parent});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Filter'.tr, style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () => Get.back()),
            actions: [
              TextButton(onPressed: () => _getController.clearFilters(), child: TextSmall(text: 'Filterlarni o‘chirish'.tr, fontSize: 18.sp, color: AppColors.red, fontWeight: FontWeight.w500)),
              SizedBox(width: 10.sp)
            ]
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const CustomRefreshHeader(),
            footer: const CustomRefreshFooter(),
            onLoading: () async {_refreshController.loadComplete();},
            onRefresh: () async {_refreshController.refreshCompleted();},
            controller: _refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => Column(
                    children: [
                      Container(width: double.infinity, margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04, top: _getController.width.value * 0.04), child: Text('Janrlar'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))),
                      Container(margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04)),
                      if (_getController.menuModel.value.data != null)
                        WrapChipGenre(
                            function: (int value) {
                              if (_getController.genreIndex.value == 1) {
                                _getController.changeGenreListSelect(value);
                              } else if (_getController.genreIndex.value == 2) {
                                _getController.changeGenreListSelect(value);
                              }
                            },
                            select: _getController.genreIndex.value == 0 ? null : _getController.filterGenre[menuIndex],
                            icon: Icons.keyboard_arrow_down_outlined
                        ),
                      Container(margin: EdgeInsets.only(top: _getController.width.value * 0.04,left: _getController.width.value * 0.04, right: _getController.width.value * 0.04), child: Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
                      Container(width: double.infinity, margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04, top: _getController.width.value * 0.04,bottom: _getController.width.value * 0.01), child: Text('Narx'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))),
                      Row(children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                                child: TextField(
                                    controller: _getController.startPriceController,
                                    decoration: InputDecoration(
                                        fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                        contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.height.value * 0.008),
                                        hintText: '0 dan'.tr,
                                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                                    )
                                )
                            )
                        ),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                                child: TextField(
                                    controller: _getController.endPriceController,
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                      filled: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                      contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.height.value * 0.008),
                                      hintText: '0 gacha'.tr,
                                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                                    )
                                )
                            )
                        )
                      ]),
                      SizedBox(height: _getController.height.value * 0.01),
                      if ( _getController.menuModel.value.data != null && _getController.menuDetailModel.value.data != null)
                        Container(margin: EdgeInsets.only(top: _getController.width.value * 0.04,bottom: _getController.width.value * 0.02,left: _getController.width.value * 0.04, right: _getController.width.value * 0.04), child: Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
                      if (_getController.filtersListSelect.isNotEmpty &&_getController.menuOptionsModelList.isNotEmpty &&_getController.menuDetailModel.value.data!.options != null)
                        for (var index = 0; index < _getController.menuDetailModel.value.data!.options!.length; index++)
                          Column(
                              children: [
                                if (_getController.menuOptionsModelList.length > index)
                                  Container(
                                      width: _getController.width.value,
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                                      child: Text('uz_UZ' == Get.locale.toString()
                                          ? _getController.menuDetailModel.value.data!.options![index].optionId!.name!.uz!
                                          : 'oz_OZ' == Get.locale.toString()
                                          ? _getController.menuDetailModel.value.data!.options![index].optionId!.name!.oz!
                                          : 'ru_RU' == Get.locale.toString()
                                          ? _getController.menuDetailModel.value.data!.options![index].optionId!.name!.ru!
                                          : _getController.menuDetailModel.value.data!.options![index].optionId!.name!.uz!,
                                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20.sp, fontWeight: FontWeight.w500))),
                                if (_getController.menuOptionsModelList.length > index && _getController.menuDetailModel.value.data!.options![index].optionId!.type == 3)
                                  WrapChip(
                                      index: index,
                                      title: _getController.getMenuOptionsModelListData(index),
                                      function: (int value) {_getController.changeFilterListSelect(index,int.parse('$value'));},
                                      select: _getController.filtersListSelect.isNotEmpty ? _getController.filtersListSelect[index] : null,
                                      icon: Icons.close,
                                      more: _getController.menuOptionsModelList[index].data!.count! > _getController.menuOptionsModelList[index].data!.result!.length ? true : false,
                                      optionId: _getController.menuDetailModel.value.data!.options![index].optionId!.sId.toString(),
                                      menuSlug: menuSlug
                                  ),
                                if (_getController.menuOptionsModelList.length > index && _getController.menuOptionsModelList[index].data != null && _getController.menuDetailModel.value.data!.options![index].optionId!.type == 1 && _getController.textControllers.isNotEmpty)
                                  Container(
                                      margin: EdgeInsets.only(top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                      child: TextField(
                                          controller: _getController.textControllers.length > index ? _getController.textControllers[index] : null,
                                          decoration: InputDecoration(
                                            fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                            filled: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.height.value * 0.008),
                                            hintText: 'Kiriting'.tr,
                                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                                          )
                                      )
                                  )
                              ]
                          ),
                      Container(
                          width: _getController.width.value,
                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01, top: _getController.height.value * 0.05, bottom: _getController.height.value * 0.01),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: AppColors.primaryColor3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                              onPressed: () {
                                _getController.productModel.value.data!.result!.clear();
                                _getController.page.value = 0;
                                if (!parent!) {
                                  ApiController().getProduct(_getController.page.value + 1, menuSlug, true,
                                      _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                      _getController.filters[4] == true ? true : null,
                                      _getController.filters[5] == true ? true : null,
                                      _getController.filters[0] == true ? 1 : -1
                                  ).then((value) => _refreshController.loadComplete());
                                } else {
                                  ApiController().getSelectProduct(_getController.page.value + 1, menuSlug, true,
                                      _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                      _getController.filters[4] == true ? true : null,
                                      _getController.filters[5] == true ? true : null,
                                      _getController.filters[0] == true ? 1 : -1
                                  ).then((value) => _refreshController.loadComplete());}
                                Get.back();
                              },
                              child: Text('Tasdiqlash'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 20.sp, fontWeight: FontWeight.w500)))
                      )
                    ]
                ))
            )
        )
    );
  }
}