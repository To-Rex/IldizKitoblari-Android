import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz_kitoblari/pages/auth/register_page.dart';
import 'package:ildiz_kitoblari/pages/auth/reset_password.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/text_fild_auth.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GetController _getController = Get.put(GetController());

  final mackFormater = MaskTextInputFormatter(mask: '+998 (##) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (FocusManager.instance.primaryFocus != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Obx(() => Stack(
                    fit: StackFit.loose,
                    children: [
                      Positioned(
                          height: 150.h,
                          top: 0,
                          left: 0,
                          right: 0,
                          child:  SizedBox(child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: 150.h))),
                      Positioned(
                          height: 80.h,
                          width: 170.w,
                          top: 31.h,
                          left: 15,
                          child:  SizedBox(child: SvgPicture.asset('assets/svgImages/keps.svg', fit: BoxFit.fitWidth, height: 25.sp))
                      ),
                      Positioned(
                          width: Get.width,
                          //top: Get.height * 0.136,
                          top: 110.h,
                          bottom: 0,
                          child:  Container(
                              width: Get.width,
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                              child: Column(
                                  children: [
                                    AppBarSheets(title: 'Kirish'),
                                    TextFieldHints(hintText: '${'Telefon raqam'.tr}:'),
                                    TextFieldPhoneAuth(nameController: _getController.phoneController, next: TextInputAction.next),
                                    SizedBox(height: 16.h),
                                    TextFieldHints(hintText: '${'Parolni kiriting'.tr}:'),
                                    TextFieldsAuth(nameController: _getController.passwordController, next: TextInputAction.next, inputType: TextInputType.visiblePassword),
                                    SizedBox(height: 8.h),
                                    Row(
                                        children: [
                                          Checkbox(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                                              activeColor: AppColors.primaryColor,
                                              value: _getController.check.value,
                                              side: const BorderSide(color: AppColors.grey,style: BorderStyle.solid),
                                              onChanged: (bool? value) {
                                                if (FocusManager.instance.primaryFocus != null) {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                }
                                                _getController.check.value = value!;}
                                          ),
                                          Expanded(child: InkWell(onTap: () {_getController.check.value = !_getController.check.value;}, child: TextSmall(text: 'Eslab qolish', color: Theme.of(context).colorScheme.onSurface))),
                                          InkWell(
                                              onTap: () {
                                                _getController.fullCheck.value = false;
                                                _getController.passwordCheck.value = false;
                                                Get.to(ResetPasswordPage());
                                              },
                                              child: const TextSmall(text: 'Parolni unutdingizmi?', color: AppColors.red)
                                          ),
                                          SizedBox(width: 15.w)
                                        ]
                                    ),
                                    const Spacer(),
                                    Container(
                                        width: Get.width,
                                        margin: EdgeInsets.only(left: 15.w, right: 15.w),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (_getController.phoneController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'Telefon raqamni kiriting!', true,2);
                                                return;
                                              }
                                              if (_getController.passwordController.text.isEmpty) {
                                                ApiController().showToast(context, 'Xatolik', 'Parolni kiriting!', true,2);
                                                return;
                                              }
                                              if (_getController.passwordController.text.length < 6) {
                                                ApiController().showToast(context, 'Xatolik', 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak!', true,2);
                                                return;
                                              }
                                              ApiController().login();
                                            },
                                            style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Get.height * 0.018), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                            child: TextSmall(text: 'Kirish'.tr, color: AppColors.white, fontWeight: FontWeight.bold)
                                        )
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextSmall(text: 'Ro‘yxatdan o‘tganmisiz?', color: Theme.of(context).colorScheme.onSurface),
                                          SizedBox(width: Get.height * 0.01),
                                          InkWell(onTap: () {Get.off(RegisterPage());}, child: const TextSmall(text: 'Ro‘yxatdan o‘tish', color: AppColors.primaryColor, fontWeight: FontWeight.bold))
                                        ]
                                    ),
                                    SizedBox(height: 60.h)
                                  ]
                              )
                          )
                      )
                    ]
                ))
            )
        )
      )
    );
  }
}