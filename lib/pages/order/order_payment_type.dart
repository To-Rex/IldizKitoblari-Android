import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../companents/orders/indicator_order.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../models/orders/region_model.dart';
import '../../resource/colors.dart';
import 'order_confirmation_page.dart';

class PaymentTypePage extends StatelessWidget {
  final bool? isBook;
  PaymentTypePage({super.key, this.isBook = false});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCountry();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.96),
        body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () {Get.back();},),
              title: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
              centerTitle: false,
            ),
            IndicatorOrder(index: 1, isBook: isBook),
            Container(
                width: Get.width,
                height: Get.height * 0.8,
                margin: EdgeInsets.only(top: 10.sp),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                    boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                ),
                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Get.width * 0.03),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To‘lov turi'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      InkWell(
                        onTap: () {
                          if (_getController.paymentTypeIndex.value == 1) {
                            _getController.paymentTypeIndex.value = 0;
                          } else {
                            _getController.paymentTypeIndex.value = 1;
                          }
                        },
                        child: Container(
                            width: Get.width,
                            height: Get.height * 0.1,
                            margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.02),
                            decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor2.withOpacity(0.2) : Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor2 : Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Row(
                              children: [
                                Text('Click'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                                const Spacer(),
                                Image.asset('assets/images/click.png', fit: BoxFit.contain, width: Get.width * 0.2, height: Get.width * 0.11)
                              ],
                            )
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            if (_getController.paymentTypeIndex.value == 2) {
                              _getController.paymentTypeIndex.value = 0;
                            } else {
                              _getController.paymentTypeIndex.value = 2;
                            }
                          },
                        child: Container(
                            width: Get.width,
                            height: Get.height * 0.1,
                            decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 2 ? AppColors.primaryColor2.withOpacity(0.2) : Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: _getController.paymentTypeIndex.value == 2 ? AppColors.primaryColor2 : Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Row(
                              children: [
                                Text('Payme'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                                const Spacer(),
                                Image.asset('assets/images/payme.png', fit: BoxFit.contain, width: Get.width * 0.2, height: Get.width * 0.11)
                              ],
                            )
                        )
                      ),
                    ]
                )
            )
          ],
        )
        )
      ),
        bottomNavigationBar: BottomAppBar(
          height: _getController.height.value * 0.09,
          surfaceTintColor: Theme.of(context).colorScheme.background,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.error,
          color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.016, horizontal: Get.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.grey.withOpacity(0.5)), elevation: MaterialStateProperty.all(0), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                      onPressed: (){Get.back();},
                      child: Text('Orqaga'.tr, style: TextStyle(fontSize: 16.sp, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w500)),
                    )
                ),
                SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor2), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                      onPressed: (){
                        if (isBook == false) {
                          if (_getController.paymentTypeIndex.value != 0) {
                            debugPrint(_getController.paymentTypeIndex.value.toString());
                            ApiController().putOrderType(false);
                            Get.to(() => OrderConfirmationPage(), transition: Transition.rightToLeft);
                          }
                        } else {
                          if (_getController.paymentTypeIndex.value != 0) {
                            ApiController().putLibraryType(false);
                            debugPrint(_getController.paymentTypeIndex.value.toString());
                            Get.to(() => OrderConfirmationPage(isBook: true), transition: Transition.rightToLeft);
                          }
                        }

                      },
                      child: Text('Davom etish'.tr, style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w500))
                    )
                )
              ],
            )
        )
    );
  }
}