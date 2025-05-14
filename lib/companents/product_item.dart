import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:text_scroll/text_scroll.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../pages/auth/login_page.dart';
import '../resource/colors.dart';
import 'chashe_image.dart';
import 'filds/text_small.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? deck;
  final String? price;
  final String? imageUrl;
  final int? count;
  final int? sale;
  final String? productType;
  final Function function;
  final bool? sold;

  ProductItem({super.key, this.id, this.title, this.deck, this.price, this.imageUrl, this.count, this.sale, this.productType, required this.function, this.sold = false});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () {
          _getController.commentController.clear();
          function();
        },
        child: Container(
            margin: EdgeInsets.only(top: 5.sp, right: 15.sp),
            width: 185.sp,
            height: 375.h,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*SizedBox(
                      width: 185.sp,
                      height: 190.sp,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                              imageUrl == null || imageUrl == '' || imageUrl == 'null' || imageUrl == ' ' ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : imageUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {return child;}
                                return SizedBox(width: _getController.width.value * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: Get.height * 0.205, color: AppColors.grey)));
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'));
                              }
                          )
                      )
                  ),*/
                  SizedBox(
                      width: 185.sp,
                      height: 190.sp,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CacheImage(
                            keys: id!,
                            url: imageUrl == null || imageUrl == '' || imageUrl == 'null' || imageUrl == ' ' ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : imageUrl!,
                            fit: BoxFit.cover,
                          )
                      )
                  ),
                  SizedBox(height: 10.sp),
                  Container(
                      margin: EdgeInsets.only(right: 10.sp),
                      child: TextScroll(
                          title!,
                          style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                          mode: TextScrollMode.endless,
                          pauseBetween: const Duration(milliseconds: 10000),
                          selectable: true,
                          delayBefore: const Duration(milliseconds: 10000)
                      )
                  ),
                  SizedBox(height: 5.sp),
                  Row(
                      children: [
                        if (sale == 0)
                          Expanded(child: TextSmall(text: '${_getController.getMoneyFormat(price)} ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                        if (sale != 0)
                          Expanded(child: TextSmall(text: '${_getController.getMoneyFormat('${int.parse(price.toString()) - int.parse(price.toString()) * sale! / 100}')} ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                        if (sale != 0)
                          Text('${_getController.getMoneyFormat(price)} ${'so‘m'.tr}', style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough)),
                      ]
                  ),
                  sold == false ? Obx(() => Column(
                    children: [
                      Row(
                          children: [
                            Icon(TablerIcons.shopping_cart_plus, size: 18.sp, color: count == 0 ? AppColors.secondaryColor : AppColors.primaryColor2),
                            SizedBox(width: 2.sp),
                            Expanded(child:  TextScroll(
                                count == 0 ? '${'Sotuvda mavjud emas'.tr}.' : 'Sotuvda mavjud'.tr,
                                style: TextStyle(fontSize: 14.sp, color: count == 0 ? AppColors.secondaryColor : AppColors.primaryColor2, fontWeight: FontWeight.w600),
                                mode: TextScrollMode.endless,
                                pauseBetween: const Duration(milliseconds: 2000),
                                selectable: true,
                                delayBefore: const Duration(milliseconds: 3000))
                            )
                          ]
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10.sp),
                          height: 35.h,
                          width: 190.w,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_getController.meModel.value.data != null) {ApiController().addToBasket('1', id.toString(),'active', 'book').then((value) => _getController.index.value = 3);} else {Get.to(LoginPage());}
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                              child: TextSmall(text: 'Xarid'.tr, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 14.sp)
                          )
                      ),
                      if (!_getController.checkCardId(id))
                        Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            height: 35.h,
                            width: 190.w,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_getController.meModel.value.data != null) {ApiController().addToBasket('1', id.toString(),'active', productType?? 'book');} else {Get.to(LoginPage());}
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                child: TextSmall(text: 'Savatga qo‘shish'.tr, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 14.sp)
                            )
                        ) else if (productType != null && productType == 'ebook' || productType != null && productType != null && productType == 'audio')
                        Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            height: 35.h,
                            width: 190.w,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_getController.meModel.value.data != null) {ApiController().deleteBasket(id.toString());} else {Get.to(LoginPage());}
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                child: TextSmall(text: 'Savatdan o‘chirish'.tr, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 14.sp)
                            )
                        )
                      else
                        Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            height: 35.h,
                            width: 190.w,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColor),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      onPressed: () {
                                        if (_getController.meModel.value.data != null && int.parse(_getController.checkCardIdCount(id.toString())) > 1) {
                                          ApiController().addToBasket('${int.parse(_getController.checkCardIdCount(id.toString())) - 1}', id.toString(), 'active', productType?? 'book');
                                        } else if (_getController.meModel.value.data != null) {
                                          ApiController().addToBasket('0', id.toString(), 'deleted', productType?? 'book');
                                        } else {
                                          Get.to(LoginPage());
                                        }
                                      },
                                      icon: Icon(TablerIcons.minus, color: AppColors.white, size: 20.sp)),
                                  Text(_getController.listCartCreate[_getController.checkCardIdIndex(id.toString())].count == null ? '1' : _getController.listCartCreate[_getController.checkCardIdIndex(id.toString())].count.toString(), style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w600)),
                                  IconButton(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      onPressed: () {
                                        if (_getController.meModel.value.data != null && _getController.basketModel.value.data!.result![_getController.checkCardIdIndex(id.toString())].count! >= _getController.basketModel.value.data!.result![_getController.checkCardIdIndex(id.toString())].cartCount!) {
                                          ApiController().addToBasket('${int.parse(_getController.checkCardIdCount(id.toString())) + 1}', id.toString(), 'active', productType?? 'book');
                                        } else {
                                          Get.to(LoginPage());
                                        }
                                      },
                                      icon: Icon(TablerIcons.plus, color: AppColors.white, size: 20.sp)
                                  )
                                ]
                            )
                        )
                    ],
                  )) : SizedBox(
                      width: 185.sp,
                      child: ElevatedButton(
                          onPressed: (){
                            _getController.commentController.clear();
                            function();
                            },
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          child: TextSmall(text: 'Kirish'.tr, color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 14.sp)
                      )
                  )
                ]
            )
        )
    );
  }

}