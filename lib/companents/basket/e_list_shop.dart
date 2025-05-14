import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class EListShop extends StatelessWidget {
  EListShop({super.key});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          if (_getController.eBasketModel.value.data != null && _getController.eBasketModel.value.data!.result != null && _getController.eBasketModel.value.data!.result!.isNotEmpty)
            Container(
                margin: EdgeInsets.only(left: Get.width * 0.01, right: Get.width * 0.03),
                child: Row(
                    children: [
                      Checkbox(
                          side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), style: BorderStyle.solid),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                          value: _getController.allECheckBoxCard.value,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            _getController.allECheckBoxCard.value = value!;
                            _getController.changeAllECheckBoxCardList();
                          }),
                      Text('${'Barchasini tanlash'.tr} (${_getController.eBasketModel.value.data!.result!.length}) ')
                    ]
                )
            ),
          if (_getController.eBasketModel.value.data != null && _getController.eBasketModel.value.data!.result != null && _getController.eBasketModel.value.data!.result!.isNotEmpty)
            Container(margin: EdgeInsets.only(top: 5.sp, bottom: 18.sp, left: Get.width * 0.03, right: Get.width * 0.03), child: Divider(height: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))),
          if (_getController.eBasketModel.value.data != null && _getController.eBasketModel.value.data!.result != null && _getController.eBasketModel.value.data!.result!.isNotEmpty)
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                padding: EdgeInsets.only(right: Get.width * 0.03, left: Get.width * 0.01),
                itemCount: _getController.eBasketModel.value.data!.result!.length,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) {
                  return  SizedBox(
                      height: 131.h,
                      child: Row(
                          children: [
                            Checkbox(
                                side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), style: BorderStyle.solid),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                                value: _getController.checkEBoxCardList[index],
                                activeColor: AppColors.primaryColor,
                                onChanged: (value) {
                                  _getController.changeECheckBoxCardList(index);
                                }),
                            Container(
                                width: 118.w,
                                height: 116.h,
                                margin: EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.015),
                                child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network(_getController.eBasketModel.value.data!.result![index].image == null || _getController.eBasketModel.value.data!.result![index].image == '' || _getController.eBasketModel.value.data!.result![index].image == 'null' || _getController.eBasketModel.value.data!.result![index].image == ' ' ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : _getController.eBasketModel.value.data!.result![index].image!, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {if (loadingProgress == null) {return child;}return SizedBox(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, color: AppColors.grey)));}, errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))
                            ),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5.h),
                                      Text('uz_UZ' == Get.locale.toString() ? _getController.eBasketModel.value.data!.result![index].name!.uz! : 'oz_OZ' == Get.locale.toString() ? _getController.eBasketModel.value.data!.result![index].name!.oz! : _getController.eBasketModel.value.data!.result![index].name!.ru!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      Text('${_getController.getMoneyFormat(_getController.eBasketModel.value.data!.result![index].price)} ${'so‘m'.tr}',maxLines: 1, style: TextStyle(color: AppColors.primaryColor2, fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      InkWell(
                                          child: Text('O‘chirish'.tr, style: TextStyle(color: AppColors.red, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                                          onTap: () {
                                            ApiController().deleteBasket(_getController.eBasketModel.value.data!.result![index].sId!,);
                                          }
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
