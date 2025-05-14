import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'Offer_page.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {if (FocusManager.instance.primaryFocus != null) {FocusManager.instance.primaryFocus?.unfocus();}},
          child: Obx(() => SingleChildScrollView(
            child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                    children: [
                      Positioned(height: 150.h, top: 0, left: 0, right: 0, child:  SizedBox(child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: 150.h))),
                      Positioned(height: 80.h, width: 170.w, top: 31.h, left: 15, child:  SizedBox(child: SvgPicture.asset('assets/svgImages/keps.svg', fit: BoxFit.fitWidth, height: 25.sp))),
                      Positioned(
                          width: Get.width,
                          top: 110.h,
                          bottom: 0,
                          child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                              child: Column(
                                  children: [
                                    AppBarSheets(title: 'Ro‘yxatdan o‘tish'.tr),
                                    TextFieldHints(hintText: 'f.i.sh'.tr),
                                    TextFieldsAuth(nameController: _getController.fullNameController, next: TextInputAction.next, inputType: TextInputType.name),
                                    SizedBox(height: 16.h),
                                    TextFieldHints(hintText: '${'Telefon raqam'.tr}:'),
                                    TextFieldPhoneAuth(nameController: _getController.phoneController, next: TextInputAction.next),
                                    SizedBox(height: 16.h),
                                    TextFieldHints(hintText: '${'Parolni kiriting'.tr}:'),
                                    TextFieldsAuth(nameController: _getController.passwordController, next: TextInputAction.next, inputType: TextInputType.visiblePassword),
                                    SizedBox(height: 16.h),
                                    TextFieldHints(hintText: '${'Parolni takrorlang'.tr}:'),
                                    TextFieldsAuth(nameController: _getController.repeatPasswordController, next: TextInputAction.done, inputType: TextInputType.visiblePassword),
                                    SizedBox(height: 5.h),
                                    Row(
                                        children: [
                                          SizedBox(width: 5.w),
                                          Checkbox(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                                              activeColor: AppColors.primaryColor,
                                              value: _getController.check.value,
                                              overlayColor: WidgetStateProperty.all(AppColors.backgroundApp.withOpacity(0.5)),
                                              side: const BorderSide(color: AppColors.grey,style: BorderStyle.solid),
                                              onChanged: (bool? value) {_getController.check.value = value!;}
                                          ),
                                          InkWell(overlayColor: WidgetStateProperty.all(AppColors.backgroundApp.withOpacity(0.5)), onTap: () {_getController.check.value = true;Get.to(() => OfferPage());}, child: const TextSmall(text: 'Ommaviy oferta', color: AppColors.primaryColor)),
                                          TextSmall(text: ' ${'shartlariga roziman'.tr}!', color: Theme.of(context).colorScheme.onSurface)
                                        ]
                                    ),
                                    const Spacer(),
                                    Container(
                                        width: Get.width,
                                        margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (_getController.fullNameController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'f.i.sh kiriting!', true, 2);
                                                return;
                                              }
                                              if (_getController.phoneController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true, 2);
                                                return;
                                              }
                                              if (_getController.passwordController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'Parolni kiriting!', true, 2);
                                                return;
                                              }
                                              if (_getController.repeatPasswordController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'Parolni takrorlang!', true, 2);
                                                return;
                                              }
                                              if (_getController.passwordController.text != _getController.repeatPasswordController.text) {
                                                ApiController().showToast(context, 'Xatolik', 'Parollar mos kelmadi!', true, 2);
                                                return;
                                              }
                                              if (_getController.passwordController.text.length < 6) {
                                                ApiController().showToast(context, 'Xatolik', 'Parol kamida 6 ta belgidan iborat bo‘lishi kerak!', true, 2);
                                                return;
                                              }
                                              if (!_getController.check.value) {
                                                ApiController().showToast(context, 'Xatolik', 'Ommaviy oferta shartlariga rozilik bildirishingiz kerak!', true, 2);
                                                return;
                                              }
                                              if (_getController.phoneController.text.length < 19) {
                                                ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true, 2);
                                                return;
                                              }
                                              ApiController().check(1, false);
                                            },
                                            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Get.height * 0.018), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                                            child: const TextSmall(text: 'Ro‘yxatdan o‘tish', color: AppColors.white, fontWeight: FontWeight.bold)
                                        )
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextSmall(text: 'Ro‘yxatdan o‘tganmisiz?', color: Theme.of(context).colorScheme.onSurface),
                                          SizedBox(width: Get.height * 0.01),
                                          InkWell(onTap: () {Get.off(LoginPage());}, child: const TextSmall(text: 'Kirish', color: AppColors.primaryColor, fontWeight: FontWeight.bold))
                                        ]
                                    ),
                                    SizedBox(height: 60.h)
                                  ]
                              )
                          )
                      )
                    ]
                )
            )
        ))
      )
    );
  }
}
