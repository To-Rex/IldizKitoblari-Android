import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../pages/onboarding_page.dart';
import '../../pages/shop/filter_page.dart';
import '../../resource/colors.dart';
import '../filds/text_large.dart';
import '../filds/text_small.dart';

class BottomSheets {
  final GetController _getController = Get.put(GetController());

  bottomSheetBookSettings(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: _getController.backgroundColor.value,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _getController.getSystemBrightness();
            return Obx(() => Container(
                height: Get.height * 0.53,
                decoration: BoxDecoration(color: _getController.backgroundColor.value, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.01, top: Get.height * 0.01),
                          child: Center(
                            child: Container(
                              width: Get.width * 0.1,
                              height: 5,
                              margin: EdgeInsets.only(top: 5, bottom: Get.height * 0.01),
                              decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.5) : Theme.of(context).colorScheme.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(10.r))
                            )
                          )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                        child: Row(
                          children: [
                            Icon(TablerIcons.sun, color: _getController.textColor.value),
                            Expanded(
                                child:Slider(
                                    value: _getController.brightness.value,
                                    activeColor: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.8) : Theme.of(context).colorScheme.surface.withOpacity(0.8),
                                    overlayColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.2)),
                                    inactiveColor: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.5) : Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                    thumbColor: Theme.of(context).colorScheme.surface,
                                    max: 1.0, min: 0.0,
                                    onChanged: (value) {
                                      _getController.brightness.value = value;
                                      _getController.setBrightness(value);
                                    }
                                )
                            ),
                            Icon(TablerIcons.sun_high, color: _getController.textColor.value)
                          ]
                        )
                      ),
                      Container(
                          width: Get.width,
                          height: 55.h,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
                          decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.2) : Theme.of(context).colorScheme.surface.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                child: IconButton(
                                    color: Theme.of(context).colorScheme.surface,
                                    splashColor: Theme.of(context).colorScheme.surface,
                                    onPressed: () {if (_getController.fontSize.value >= 11) _getController.fontSize.value -= 1;},
                                    icon: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(TablerIcons.letter_a_small, color: AppColors.black,size: 30),
                                          TextSmall(text: '-', color: AppColors.black)
                                        ]
                                    )
                                )
                              ),
                              Text(' ${_getController.fontSize.value.toString().split('.').first} px', style: TextStyle(color: _getController.textColor.value)),
                              Container(
                                  width: 100.w,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                  child: IconButton(
                                      color: Theme.of(context).colorScheme.surface,
                                      splashColor: Theme.of(context).colorScheme.surface,
                                      onPressed: () {if (_getController.fontSize.value <= 30) _getController.fontSize.value += 1;},
                                      icon: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(TablerIcons.letter_a_small, color: AppColors.black,size: 30),
                                            TextSmall(text: '+', color: AppColors.black)
                                          ]
                                      )
                                  )
                              )
                            ]
                          )
                      ),
                      Container(
                          width: Get.width,
                          height: 55.h,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03,vertical: Get.height * 0.01),
                          decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.2) : Theme.of(context).colorScheme.surface.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 60,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                child: IconButton(
                                    color: Theme.of(context).colorScheme.surface,
                                    splashColor: Theme.of(context).colorScheme.surface,
                                    onPressed: () {if (_getController.fontSize.value >= 11) _getController.fontSize.value -= 1;},
                                    icon: const Icon(TablerIcons.caret_left_filled, color: AppColors.black,size: 20),
                                )
                              ),
                              Text('SF Pro Display', style: TextStyle(color: _getController.textColor.value)),
                              Container(
                                  width: 60,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                  child: IconButton(
                                      color: Theme.of(context).colorScheme.surface,
                                      splashColor: Theme.of(context).colorScheme.surface,
                                      onPressed: () {if (_getController.fontSize.value <= 30) _getController.fontSize.value += 1;},
                                      icon: const Icon(TablerIcons.caret_right_filled, color: AppColors.black,size: 20),
                                  )
                              )
                            ]
                          )
                      ),
                      const SizedBox(height: 5),
                      Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                TextSmall(text: 'Vertical', color: _getController.textColor.value, fontWeight: FontWeight.w400),
                                SizedBox(
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.05,
                                    child: CupertinoSwitch(
                                        value: _getController.isVertical.value,
                                        onChanged: (value) => _getController.isVertical.value = value,
                                        activeColor: Theme.of(context).colorScheme.primary
                                    )
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _getController.backgroundColor.value = AppColors.white;
                                _getController.textColor.value = AppColors.black;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                minimumSize: const Size(40, 40),
                                maximumSize: const Size(40, 40),
                                shape: const CircleBorder(
                                  side: BorderSide(
                                    color: AppColors.grey,
                                    width: 1,
                                  ),
                                ),
                                padding: const EdgeInsets.all(20),
                              ),
                              child: const Text('', style: TextStyle(color: AppColors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _getController.backgroundColor.value = AppColors.trueToneColor;
                                _getController.textColor.value = AppColors.black;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.trueToneColor,
                                minimumSize: const Size(40, 40),
                                maximumSize: const Size(40, 40),
                                shape: const CircleBorder(side: BorderSide(color: AppColors.grey, width: 1)),
                                padding: const EdgeInsets.all(20),
                              ),
                              child: const Text('', style: TextStyle(color: AppColors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _getController.backgroundColor.value = AppColors.grey;_getController.textColor.value = AppColors.black;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.grey,
                                minimumSize: const Size(40, 40),
                                maximumSize: const Size(40, 40),
                                shape: const CircleBorder(side: BorderSide(color: AppColors.grey, width: 1)),
                                padding: const EdgeInsets.all(20),
                              ),
                              child: const Text('', style: TextStyle(color: AppColors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _getController.backgroundColor.value = AppColors.midnightBlack;
                                _getController.textColor.value = AppColors.grey;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.midnightBlack,
                                minimumSize: const Size(40, 40),
                                maximumSize: const Size(40, 40),
                                shape: const CircleBorder(side: BorderSide(color: AppColors.grey, width: 1)),
                                padding: const EdgeInsets.all(20)
                              ),
                              child: const Text('', style: TextStyle(color: AppColors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _getController.backgroundColor.value = AppColors.black;
                                _getController.textColor.value = AppColors.grey;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.black,
                                minimumSize: const Size(40, 40),
                                maximumSize: const Size(40, 40),
                                shape: const CircleBorder(side: BorderSide(color: AppColors.grey, width: 1)),
                                padding: const EdgeInsets.all(20)
                              ),
                              child: const Text('', style: TextStyle(color: AppColors.black))
                            )
                          ])
                    ]
                )
            ));
          })
  );

  void showBottomSheet(BuildContext context, parent, menuSlug) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.45,
                  child: Container(
                      height: Get.height * 0.4,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.width * 0.03, width: Get.width),
                            Container(
                                height: Get.width * 0.01,
                                width: Get.width,
                                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.42),
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), borderRadius: BorderRadius.circular(100))
                            ),
                            SizedBox(height: Get.width * 0.08, width: Get.width),
                            TextLarge(text: 'Saralash'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                            SizedBox(height: Get.width * 0.03),
                            for (int i = 0; i < _getController.filters.length; i++)
                              Column(
                                  children: [
                                    GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          _getController.changeFilterIndex(i);
                                          setState(() {
                                            if (!parent) {
                                              ApiController().getProduct(1, menuSlug, false,
                                                  _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                                  _getController.filters[4] == true ? true : null,
                                                  _getController.filters[5] == true ? true : null,
                                                  _getController.filters[0] == true ? 1 : -1
                                              );
                                            }
                                            else {
                                              //ApiController().getSelectProduct(1, menuSlug, false);
                                              ApiController().getSelectProduct(1, menuSlug, false,
                                                  _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                                  _getController.filters[4] == true ? true : null,
                                                  _getController.filters[5] == true ? true : null,
                                                  _getController.filters[0] == true ? 1 : -1
                                              );
                                            }
                                          });
                                        },
                                        child: Row(
                                            children: [
                                              if (_getController.filters[i])
                                                Container(
                                                    margin: EdgeInsets.only(right: Get.width * 0.02),
                                                    width: Get.width * 0.015,
                                                    height: Get.width * 0.015,
                                                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(100))
                                                ),
                                              TextSmall(text: i == 0 ? 'Nomi (A - Z)'.tr : i == 1 ? 'Nomi (Z - A)'.tr : i == 2 ? 'Avval arzonlari'.tr : i == 3 ? 'Avval qimmatlari'.tr : i == 4 ? 'Yangisidan boshlab'.tr : 'Yangisidan boshlab'.tr, fontWeight: FontWeight.w500, color: _getController.filters[i] ? AppColors.primaryColor : Theme.of(context).colorScheme.onSurface)
                                            ]
                                        )
                                    ),
                                    SizedBox(height: 5.h),
                                    if (i == 1 || i == 3) const Divider(),
                                    if (i == 1 || i == 3) SizedBox(height: 5.h)
                                  ]
                              )
                          ]
                      )
                  )
              );
            })
    );
  }

  void getFilterData(menuIndex, menuSlug){
    if (_getController.menuModel.value.data!.result![menuIndex].children != null) {
      _getController.textControllers.clear();
      _getController.filterGenre.clear();
      _getController.filterGenre.add(null);
      _getController.genreIndex.value = 0;
      _getController.clearMenuOptionsModelList();
      _getController.filtersListSelect.clear();
      _getController.clearControllers();
      ApiController().getMenuDetail(menuSlug).then((value) => {
        ApiController().getMenuOption(1, menuIndex, menuSlug, 10, true)
      });
    }
  }

  void showBottomSheetFilter(BuildContext context,menuIndex, menuSlug, parent) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        backgroundColor: Theme.of(context).colorScheme.surface,
        isScrollControlled: true,
        enableDrag: true,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.9,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.width * 0.03, width: Get.width),
                        Container(
                            height: Get.width * 0.01,
                            width: Get.width,
                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.42),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), borderRadius: BorderRadius.circular(100))
                        ),
                        SizedBox(height: Get.width * 0.03),
                        SizedBox(
                            height: Get.height * 0.8,
                            width: Get.width,
                            child: FilterPage(menuIndex: menuIndex, menuSlug: menuSlug,parent: parent)
                        ),
                      ]
                  )
              );
            })
    );
  }

  void showLogOut(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Dasturdan chiqmoqchimisiz?'.tr),
        titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 19.sp),
        content: Text('Dasturdan chiqqaningdan so‘ng login va parolingiz orqali qayta kirishingiz mumkin.'.tr),
        contentTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 16.sp),
        actions: [
          SizedBox(
              child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                disabledForegroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                elevation: 0,
                                backgroundColor: AppColors.grey.withOpacity(0.3),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                            ),
                            onPressed: () {Get.back();},
                            child: Text('Orqaga'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 16.sp))
                        )
                    ),
                    SizedBox(width: Get.width * 0.03),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                disabledForegroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                elevation: 0,
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                            ),
                            onPressed: () {
                              _getController.clearMeModel();
                              GetStorage().remove('token');
                              Get.offAll(const OnboardingPage());
                            },
                            child: Text('Chiqish'.tr, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 16.sp))
                        )
                    )
                  ]
              )
          )
        ]
    ));
  }

}