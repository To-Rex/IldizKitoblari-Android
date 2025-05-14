import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class ListShop extends StatelessWidget {
  ListShop({super.key});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.01, right: Get.width * 0.03),
              child: Row(
                  children: [
                    Checkbox(
                        side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        value: _getController.allCheckBoxCard.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) {
                          _getController.allCheckBoxCard.value = value!;
                          _getController.changeAllCheckBoxCardList();
                        }),
                    Text('${'Barchasini tanlash'.tr} (${_getController.basketModel.value.data!.result!.length}) ')
                  ]
              )
            ),
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            Container(margin: EdgeInsets.only(top: 5.sp, bottom: 18.sp, left: Get.width * 0.03, right: Get.width * 0.03), child: Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                padding: EdgeInsets.only(right: Get.width * 0.03, left: Get.width * 0.01),
                itemCount: _getController.basketModel.value.data!.result!.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return  SizedBox(
                      height: 131.h,
                      child: Row(
                          children: [
                            Checkbox(
                              side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), style: BorderStyle.solid),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                              value: _getController.checkBoxCardList[index],
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                if (_getController.tabController.index == 0) {
                                  _getController.changeCheckBoxCardList(index);
                                } else {
                                  _getController.changeECheckBoxCardList(index);
                                }
                              }),
                            Container(
                                width: 118.w,
                                height: 116.h,
                                margin: EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.015),
                                child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network(_getController.basketModel.value.data!.result![index].image == null || _getController.basketModel.value.data!.result![index].image == '' || _getController.basketModel.value.data!.result![index].image == 'null' || _getController.basketModel.value.data!.result![index].image == ' ' ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : _getController.basketModel.value.data!.result![index].image!, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {if (loadingProgress == null) {return child;}return SizedBox(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, color: AppColors.grey)));}, errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))
                            ),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5.h),
                                      Text('uz_UZ' == Get.locale.toString() ? _getController.basketModel.value.data!.result![index].name!.uz! : 'oz_OZ' == Get.locale.toString() ? _getController.basketModel.value.data!.result![index].name!.oz! : _getController.basketModel.value.data!.result![index].name!.ru!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      Text('${_getController.getMoneyFormat(_getController.basketModel.value.data!.result![index].price)} ${'so‘m'.tr}',maxLines: 1, style: TextStyle(color: AppColors.primaryColor2, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          InkWell(
                                              child: Text('O‘chirish'.tr, style: TextStyle(color: AppColors.red, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                                              onTap: () {
                                                //ApiController().addToBasket('0', _getController.basketModel.value.data!.result![index].productId!,'deleted','book');
                                                ApiController().deleteBasket(_getController.basketModel.value.data!.result![index].sId!,);
                                              }
                                          ),
                                          const Spacer(),
                                          if (_getController.basketModel.value.data!.result![index].productType != 'ebook' && _getController.basketModel.value.data!.result![index].productType != 'audio')
                                            Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey.withOpacity(0.2)),
                                              child: Row(
                                                  children: [
                                                    IconButton(
                                                        color: Theme.of(context).colorScheme.onSurface,
                                                        onPressed: () {
                                                          if (_getController.basketModel.value.data!.result![index].cartCount! > 1) {
                                                            ApiController().addToBasket('${_getController.basketModel.value.data!.result![index].cartCount! - 1}', _getController.basketModel.value.data!.result![index].productId!, 'active','book');
                                                          } else {
                                                            ApiController().addToBasket('0', _getController.basketModel.value.data!.result![index].productId!,'deleted','book');
                                                          }},
                                                        icon: Icon(TablerIcons.minus, color: Theme.of(context).colorScheme.onSurface, size: 17.sp)
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Text(_getController.basketModel.value.data!.result![index].cartCount.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                                    SizedBox(width: 5.w),
                                                    IconButton(
                                                        color: Theme.of(context).colorScheme.onSurface,
                                                        onPressed: () {
                                                          if (_getController.basketModel.value.data!.result![index].count! >= _getController.basketModel.value.data!.result![index].cartCount!) {
                                                            ApiController().addToBasket('${_getController.basketModel.value.data!.result![index].cartCount! + 1}', _getController.basketModel.value.data!.result![index].productId!, 'active', 'book');
                                                          } else {
                                                            ApiController().showToast(context, 'Error', 'The number of products in the basket cannot be less than 1', true, 2);
                                                          }},
                                                        icon: Icon(TablerIcons.plus, color: Theme.of(context).colorScheme.onSurface, size: 17.sp)
                                                    )
                                                  ]
                                              )
                                          )
                                        ]
                                    ),
                                      SizedBox(height: 20.h)
                                    ]
                                )
                            )
                          ]
                      )
                  );
                }
            )
        ]
    ));
  }
}
