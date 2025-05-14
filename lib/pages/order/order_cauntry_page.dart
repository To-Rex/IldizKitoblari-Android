import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/orders/indicator_order.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../models/orders/region_model.dart';
import '../../resource/colors.dart';
import 'order_payment_type.dart';

class OrderCountryPage extends StatelessWidget {
  OrderCountryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCountry();
    _getController.addressController.clear();
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
            const IndicatorOrder(index: 0),
            Container(
                width: Get.width,
                height: Get.height * 0.8,
                margin: EdgeInsets.only(top: 10.sp),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                    boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                ),
                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Get.width * 0.03),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Yetkazib berish manzili'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.02),
                      Text('${'Davlat'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.01),
                      if (_getController.getCountryModel.value.data != null && _getController.dropDownOrders[0] != null)
                        Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(10.r),
                                dropdownColor: Theme.of(context).colorScheme.background,
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                value: _getController.getCountryModel.value.data?.result?[_getController.dropDownOrders[0]].name?.uz.toString(),
                                onChanged: (newValue) {
                                  if (newValue != 'Kiriting'.tr) {
                                    _getController.getRegionModel.value = RegionModel();
                                    _getController.dropDownOrders[0] = _getController.getCountryModel.value.data?.result?.indexWhere((element) => element.name?.uz.toString() == newValue) ?? 0;
                                    ApiController().getRegion(_getController.getCountryModel.value.data?.result?[_getController.dropDownOrders[0]].sId.toString());
                                  } else {
                                    ApiController().showToast(context, 'Xatolik', 'Manzilni tanlang', false, 3);
                                  }
                                },
                                items: _getController.getCountryModel.value.data?.result?.map<String>((country) {return country.name!.uz.toString();}).toList().map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                            )
                        ),
                      SizedBox(height: Get.height * 0.02),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        Text('${'Tuman / shahar'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        SizedBox(height: Get.height * 0.01),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        Container(
                            width: Get.width,
                            height: Get.height * 0.06,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(10.r),
                                dropdownColor: Theme.of(context).colorScheme.background,
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                value: _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].name?.uz.toString(),
                                onChanged: (newValue) {
                                  if (newValue != 'Kiriting'.tr) {
                                    _getController.dropDownOrders[1] = _getController.getRegionModel.value.data?.result?.indexWhere((element) => element.name?.uz.toString() == newValue) ?? 0;
                                    if (_getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].priceType.toString() == 'district') {
                                      ApiController().getAddPriceDistrict();
                                    }
                                  } else {
                                    ApiController().showToast(context, 'Xatolik', 'Manzilni tanlang', false, 3);
                                  }
                                },
                                items: _getController.getRegionModel.value.data?.result?.map<String>((country) {return country.name!.uz.toString();}).toList().map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList()
                            )
                      ),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true)
                        SizedBox(height: Get.height * 0.01),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true && _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].name?.uz.toString() != null && _getController.dropDownOrders[1] != null)
                        SizedBox(height: Get.height * 0.01),
                      if (_getController.getRegionModel.value.data != null && _getController.dropDownOrders[0] != null && _getController.dropDownOrders[1] != null && _getController.getRegionModel.value.data?.result != null && _getController.getRegionModel.value.data?.result?.isNotEmpty == true && _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].name?.uz.toString() != null && _getController.dropDownOrders[1] != null)
                        Container(
                            width: Get.width * 0.95,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                            padding: EdgeInsets.only(left: 10.sp, right: 10.sp,  bottom: 10.sp, top: 10.sp),
                            margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                            child: Text(
                                _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].priceType.toString() == 'constant' && _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].priceType.toString() != 'district' && _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].deliveryPrice != 0
                                ? '${'Yetkazib berish narxi'.tr}: ${_getController.getMoneyFormat(_getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].deliveryPrice ?? 0)} ${'so‘m'.tr} '
                                : _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].priceType.toString() != 'district'
                                ? 'uz_UZ' == Get.locale.toString() ?  _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].text?.uz.toString() ?? ''
                                : 'oz_OZ' == Get.locale.toString() ?  _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].text?.oz.toString() ?? ''
                                :  _getController.getRegionModel.value.data?.result![_getController.dropDownOrders[1]].text?.ru.toString() ?? ''
                                : '${'Yetkazib berish narxi'.tr}: ${_getController.getMoneyFormat(_getController.deliveryPrice.value)} ${'so‘m'.tr}',
                                style: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor2, fontWeight: FontWeight.w500))),
                      Text('${'Manzil'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: Get.height * 0.01),
                      Container(
                        width: Get.width * 0.95,
                        height: Get.height * 0.15,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                        padding: EdgeInsets.only(left: 10.sp, right: 10.sp,  bottom: 10.sp),
                        child: TextField(
                          maxLines: 30,
                          maxLength: 800,
                          controller: _getController.addressController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kiriting'.tr,
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
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
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.error,
          color: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.016, horizontal: Get.width * 0.03),
            child: SizedBox(
              width: Get.width,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor2), shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                onPressed: (){
                  if (_getController.dropDownOrders[0] == 0) {
                    ApiController().showToast(Get.context, 'Xatolik', 'Davlatni tanlang!', true, 3);
                    return;
                  }
                  if (_getController.dropDownOrders[1] == 0) {
                    ApiController().showToast(Get.context, 'Xatolik', 'Viloyatni tanlang!', true, 3);
                    return;
                  }
                  if (_getController.addressController.text.isEmpty || _getController.addressController.text == '') {
                    ApiController().showToast(Get.context, 'Xatolik', 'Manzilni kiriting!', true, 3);
                    return;
                  }
                  ApiController().putOrder().then((value) => Get.to(() => PaymentTypePage(), transition: Transition.rightToLeft));
                },
                child: Text('Davom etish'.tr, style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.w500)
                ),
              )
          )
        )
    );
  }
}