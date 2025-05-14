import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/user/scleton_orders.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'orders_detail_page.dart';

class OrdersPage extends StatelessWidget{
  OrdersPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getOrderList();
    return Scaffold(
        body: SingleChildScrollView(
          child: Obx(()=> Column(
              children: [
                AppBar(
                    title: Text('Buyurtmalar'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
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
                Padding(
                    padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
                    child: Row(
                        children: [
                          Expanded(child: Text('Buyurtmalar'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))),
                          /*InkWell(onTap: () {
                            _getController.clearOrderListModel();
                            _getController.onLoad();
                          }, child: Container(width: 20.sp, height: 20.sp, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface), child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)))),
                          SizedBox(width: _getController.width.value * 0.03),*/
                        ]
                    )
                ),
                 SizedBox(height: _getController.height.value * 0.02),
                 _getController.orderListModel.value.data == null || _getController.orderListModel.value.data!.result!.isEmpty
                    ? _getController.onLoading.isFalse
                     ? SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))))
                     : SizedBox(width: Get.width, height: Get.height * 0.7, child: const Center(child: SkeletonOrders()))
                    : ListView.separated(
                     physics: const NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                     itemCount: _getController.orderListModel.value.data!.result!.length,
                     separatorBuilder: (context, index) => SizedBox(height: Get.height * 0.01),
                     itemBuilder: (context, index) {
                       return InkWell(
                         onTap: () {
                           Get.to(() => OrdersDetailPage(), transition: Transition.rightToLeft, arguments: [_getController.orderListModel.value.data!.result![index].sId,_getController.orderListModel.value.data!.result![index].createdAt]);
                         },
                         child: Container(
                             width: Get.width * 0.8,
                             padding: EdgeInsets.all(10.sp),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Theme.of(context).colorScheme.surface,
                                 boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                             ),
                             child: Column(
                                 children: [
                                   SizedBox(height: Get.height * 0.01),
                                   Row(
                                     children: [
                                       Text('№${_getController.orderListModel.value.data!.result![index].uid}', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
                                       const Spacer(),
                                       Text(
                                         DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(_getController.orderListModel.value.data!.result![index].createdAt!).toLocal().toString().substring(0, 10).replaceAll('-', '.'),
                                         style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
                                       ),
                                     ],
                                   ),
                                   Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                                   Row(
                                       children: [
                                         TextSmall(text: '${_getController.getMoneyFormat(int.parse(_getController.orderListModel.value.data!.result![index].price.toString()) + int.parse(_getController.orderListModel.value.data!.result![index].deliveryPrice.toString()))} ${'so‘m'.tr}', color: int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 2
                                             ? AppColors.element : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 3 || int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 7
                                             ? AppColors.primaryColor2 : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 4 || int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 9
                                             ? AppColors.red : AppColors.primaryColor2, fontSize: 17.sp, fontWeight: FontWeight.w500),
                                         Container(
                                             width: 6.sp,
                                             height: 6.sp,
                                             margin: EdgeInsets.symmetric(horizontal: 5.sp),
                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                         ),
                                         Text(
                                             int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 8 || int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 1
                                                 ? 'Yangi'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 2
                                                 ? 'Ko‘rib chiqilmoqda'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 3
                                                 ? 'To‘lov qabul qilindi'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 4
                                                 ? 'To‘lov qabul qilinmadi'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 5
                                                 ? 'To‘lov qilishdagi xatolik'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 6
                                                 ? 'Qaytarildi'.tr : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 9
                                                 ? 'Bekor qilindi'.tr : 'Qabul qilindi'.tr,
                                             style: TextStyle(
                                               fontSize: 17.sp,
                                               fontWeight: FontWeight.w500,
                                               color: int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 2
                                                   ? AppColors.element : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 3 || int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 7
                                                   ? AppColors.primaryColor2 : int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 4 || int.parse(_getController.orderListModel.value.data!.result![index].status.toString()) == 9
                                                   ? AppColors.red : Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                                             )
                                         )
                                       ]
                                   ),
                                   SizedBox(height: Get.height * 0.01)
                                 ]
                             )
                         )
                       );
                     }
                 )
              ]
          ))
        )
    );
  }
}