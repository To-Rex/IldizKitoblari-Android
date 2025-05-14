import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class OrdersDetailPage extends StatelessWidget{
  OrdersDetailPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    List list = Get.arguments;
    ApiController().getOrderListDetail(list.isNotEmpty ? list.first.toString() : '');
    return Scaffold(
        body: SingleChildScrollView(
            child: Obx(()=> Column(
                children: [
                  AppBar(
                      title: _getController.orderListDetailModel.value.data == null || _getController.orderListDetailModel.value.data!.uid == null
                          ? const SizedBox(width: 0, height: 0)
                          : TextSmall(text: '№${_getController.orderListDetailModel.value.data!.uid.toString()}', fontSize: 20.sp, fontWeight: FontWeight.w500),
                      centerTitle: false,
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
                          onPressed: () {
                            Get.back();
                          }
                      )
                  ),
                  SizedBox(height: _getController.height.value * 0.02),
                  SizedBox(height: _getController.height.value * 0.02),
                  _getController.orderListDetailModel.value.data == null
                      ? SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: TextSmall(text: 'Ma‘lumotlar yo‘q!'.tr, fontSize: 20.sp, fontWeight: FontWeight.w500)))
                      : Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10.sp),
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.surface, boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              TextSmall(text: 'Buyurtma raqami'.tr, fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              TextSmall(text: _getController.orderListDetailModel.value.data!.uid.toString(), fontSize: 16.sp, fontWeight: FontWeight.w500),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                            if (list[1] != null && list[1] != '')
                              TextSmall(text: 'Buyurtma sanasi'.tr, fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            if (list[1] != null && list[1] != '')
                              TextSmall(text: DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(list[1]).toLocal().toString().substring(0, 10).replaceAll('-', '.'), fontSize: 16.sp, fontWeight: FontWeight.w500),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (list[1] != null && list[1] != '')
                              Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                            if (_getController.orderListDetailModel.value.data!.type != null)
                              TextSmall(text: '${'To‘lov turi'.tr}:', fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            if (_getController.orderListDetailModel.value.data!.type != null)
                              TextSmall(text: _getController.orderListDetailModel.value.data!.type == 1 ? 'Click'.tr : 'PayMe'.tr, fontSize: 16.sp, fontWeight: FontWeight.w500),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              TextSmall(text: '${'To‘lov miqdori'.tr}:', fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              TextSmall(text: '${_getController.getMoneyFormat(int.parse(_getController.orderListDetailModel.value.data!.price.toString())+int.parse(_getController.orderListDetailModel.value.data!.deliveryPrice.toString()))} ${'so‘m'.tr}', color: AppColors.primaryColor2, fontSize: 16.sp, fontWeight: FontWeight.w500),
                            SizedBox(height: _getController.height.value * 0.01),
                          ]
                      )
                  ),
                  SizedBox(height: _getController.height.value * 0.02),
                  _getController.orderListDetailModel.value.data != null
                  ? Row(
                    children: [
                      SizedBox(width: _getController.width.value * 0.03),
                      TextSmall(text: 'Mahsulotlar'.tr, fontSize: 20.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                      TextSmall(text: ' (${_getController.orderListDetailModel.value.data!.orderProducts!.length})', fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                    ],
                  )
                  : const SizedBox.shrink(),
                  _getController.orderListDetailModel.value.data != null
                  ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _getController.orderListDetailModel.value.data!.orderProducts!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03,bottom: _getController.height.value * 0.015),
                                  width: 110.w,
                                  height: 131.h,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(4),
                                      child: Image.network(_getController.orderListDetailModel.value.data!.orderProducts![index].image != null || _getController.orderListDetailModel.value.data!.orderProducts![index].image != '' ? _getController.orderListDetailModel.value.data!.orderProducts![index].image! : 'https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740',
                                      fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return SizedBox(
                                            width: _getController.width.value * 0.44,
                                            height: _getController.height.value * 0.205,
                                            child: Skeletonizer(
                                                child: Container(
                                                    width: _getController.width.value * 0.44,
                                                    height: _getController.height.value * 0.205,
                                                    color: AppColors.grey)
                                            )
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: _getController.width.value * 0.67, child: Text(_getController.orderListDetailModel.value.data!.orderProducts![index].product!.name!.uz.toString(),maxLines: 1, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))),
                                    SizedBox(height: _getController.height.value * 0.01),
                                    Row(
                                        children: [
                                          TextSmall(text: '${_getController.orderListDetailModel.value.data!.orderProducts![index].orderCount} ', fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                                          TextSmall(text: 'dona'.tr, fontSize: 16.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                                          Container(
                                              width: 6.sp,
                                              height: 6.sp,
                                              margin: EdgeInsets.symmetric(horizontal: 5.sp),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                          ),
                                          TextSmall(text: '${_getController.getMoneyFormat(int.parse(_getController.orderListDetailModel.value.data!.orderProducts![index].orderPrice.toString())*int.parse(_getController.orderListDetailModel.value.data!.orderProducts![index].orderCount.toString()))} ${'so‘m'.tr}', fontSize: 16.sp, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                        ]
                                    ),
                                    SizedBox(height: _getController.height.value * 0.01),
                                    SizedBox(width: _getController.width.value * 0.67, child: TextSmall(text: '${_getController.getMoneyFormat(_getController.orderListDetailModel.value.data!.orderProducts![index].orderPrice.toString())} ${'so‘m'.tr}', fontSize: 16.sp,fontWeight: FontWeight.bold,color: AppColors.primaryColor2)),
                                    SizedBox(height: _getController.height.value * 0.01),
                                  ]
                              )
                            ]
                        )
                      );
                    }
                  ) : const SizedBox.shrink(),
                ]
            ))
        )
    );
  }
}