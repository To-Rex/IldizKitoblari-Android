import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../companents/appbar_sheets.dart';
import '../../companents/text_fild_auth_phone.dart';
import '../../companents/text_fild_hints.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'login_page.dart';

class VerifyPage extends StatelessWidget {

  VerifyPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
        height: _getController.height.value,
        width: _getController.width.value,
          child:  Obx(() => Stack(
            alignment: Alignment.center,
      children: [
        Positioned(
            height: _getController.height.value * 0.15,
            top: 0, left: 0, right: 0,
            child:  SizedBox(
              child: SvgPicture.asset('assets/svgImages/shap.svg',
                  fit: BoxFit.fitWidth,
                  height: _getController.height.value * 0.15),
            )
        ),
        Positioned(
            height: _getController.height.value * 0.1,
            width: _getController.width.value * 0.45,
            top: _getController.height.value * 0.038,
            left: _getController.width.value * 0.03,
            child:  SizedBox(
              child: SvgPicture.asset(
                  'assets/svgImages/keps.svg',
                  fit: BoxFit.fitWidth,
                  height: _getController.height.value * 0.2),
            )
        ),
        Positioned(
            width: _getController.width.value,
            top: _getController.height.value * 0.13,
            bottom: 0,
            child:  Container(
                width: _getController.width.value,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    AppBarSheets(
                      title: 'Ro\'yxatdan o\'tish'.tr,
                    ),
                    TextFieldHints(
                      hintText: '${'Telefon raqam'.tr}:',
                    ),
                    TextFieldPhoneAuth(
                      nameController: _getController.phoneController,
                      next: TextInputAction.next,
                      enabled: false,
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    //SMS kod
                    TextFieldHints(
                      hintText: 'SMS kod'.tr,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          width: _getController.width.value * 0.655,
                          height: _getController.height.value * 0.056,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                            ),
                          ),
                          child: Obx(() => TextField(
                            controller: _getController.codeController,
                            keyboardType: TextInputType.number,
                            //next or done
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            focusNode: FocusNode(),
                            style: TextStyle(
                              fontSize: _getController.width.value * 0.04,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'Kiriting'.tr,
                              filled: true,
                              isDense: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              hintStyle: TextStyle(
                                fontSize: _getController.width.value * 0.04,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none, // No border
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: _getController.width.value * 0.03,
                        ),
                        Container(
                          width: _getController.width.value * 0.235,
                          height: _getController.height.value * 0.056,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${_getController.countdownDuration.value.inMinutes.toString().padLeft(2, '0')}:${(_getController.countdownDuration.value.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: _getController.width.value * 0.04,
                                fontWeight: FontWeight.bold,
                              )
                            )
                          )
                        ),
                        const Spacer()
                      ]
                    ),
                    SizedBox(height: _getController.height.value * 0.02),
                    if (_getController.countdownDuration.value.inSeconds == 0)
                    Row(
                      children: [
                        SizedBox(
                          width: _getController.width.value * 0.05,
                        ),
                        Text(
                          '${'SMS xabar kelmadimi?'.tr}: ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: _getController.width.value * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _getController.resetTimer();
                            ApiController().otp(_getController.phoneController.text, 1, true);
                          },
                          child: Text(
                            'Qayta yuborish'.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: _getController.width.value * 0.04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    //const Expanded(child: SizedBox()),
                    SizedBox(
                        width: _getController.width.value * 0.91,
                        height: _getController.height.value * 0.061,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_getController.codeController.text.isEmpty) {
                                ApiController().showToast(context, 'Xatolik', 'SMS kodni kiriting!', true, 3);
                              }
                              else {
                                ApiController().create(
                                    _getController.fullNameController.text,
                                    _getController.codeController.text,
                                    _getController.passwordController.text,
                                    _getController.phoneController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )
                            ),
                            child: Text('Tasdiqlash'.tr,
                                style: TextStyle(
                                  fontSize: _getController.width.value * 0.04,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                )
                            )
                        )
                    ),
                    SizedBox(height: _getController.height.value * 0.03),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Ro‘yxatdan o‘tganmisiz?'.tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: _getController.width.value * 0.04,
                          ),
                        ),
                        SizedBox(
                          width: _getController.height.value * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(LoginPage());
                          },
                          child: Text(
                            'Kirish'.tr,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: _getController.width.value * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(height: _getController.height.value * 0.08),
                  ],
                )
            )
        ),
      ],
    ),
        ))
      )
    );
  }
}
