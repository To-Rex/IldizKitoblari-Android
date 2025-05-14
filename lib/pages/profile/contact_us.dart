import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../../resource/component_size.dart';


class ContactUs extends StatelessWidget{
  ContactUs({super.key});

  final GetController _getController = Get.put(GetController());


  @override
  Widget build(BuildContext context) {

    ApiController().getContactUs();

    return Scaffold(
      appBar: AppBar(
          title: TextLarge(text: 'Biz bilan bog‘lanish', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {Get.back();})
      ),
      body: SingleChildScrollView(
          child: Obx(() => _getController.contactUsModel.value.data == null
              ? !_getController.onLoading.value
              ? SizedBox(height: Get.height * 0.8, width: Get.width, child: Center(child: TextLarge(text: 'Ma‘lumotlar yo‘q!', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400)))
              : Skeletonizer(child: Container(
                  margin: EdgeInsets.only(top: _getController.width.value * 0.04, left: _getController.width.value * 0.03,right: _getController.width.value * 0.03),
                  child: Column(
                      children: [
                        Container(
                            width: Get.width,
                            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bog‘lanish'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Bog‘lanish uchun:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.h),
                                  Text('+998 (99) 534 03 13', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Hamkorlar uchun bog‘lanish:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.w),
                                  Text('+998 (99) 534 03 13', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                  SizedBox(height: 10.w),
                                  Row(
                                      children: [
                                        Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Ijtimoiy tarmoqlar:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                      children: [
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_youtube,
                                                    color: AppColors.backgroundApp, size: 20.sp
                                                )
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_instagram,
                                                    color: AppColors.backgroundApp, size: 20.sp
                                                )
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                              icon: Icon(
                                                  TablerIcons.brand_telegram,
                                                  color: AppColors.backgroundApp,
                                                  size: 20.sp
                                              ),
                                            )
                                        ),
                                        SizedBox(width: 15.w),
                                        Container(
                                            height: 35.h,
                                            width: 35.w,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                            child: IconButton(onPressed: () {},
                                                icon: Icon(
                                                    TablerIcons.brand_facebook,
                                                    color: AppColors.backgroundApp,
                                                    size: 20.sp
                                                )
                                            )
                                        )
                                      ]
                                  )
                                ]
                            )
                        ),
                        SizedBox(height: 20.h),
                        Container(
                            width: Get.width,
                            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ildiz kitoblari Xadra filiali'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 10.h),
                                  Row(
                                      children: [
                                        Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                        SizedBox(width: 10.w),
                                        Text('Manzil'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                      ]
                                  ),
                                  SizedBox(height: 10.h),
                                  Text('Farg‘ona viloyati O‘zbekiston tumani'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                                ]
                            )
                        )
                      ]
                  )
              ))
              : Column(
              children: [
                Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLarge(text: 'Ildiz kitoblari do‘koni', fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                TextSmall(text: '${'Bog‘lanish uchun'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                              ]
                          ),
                          SizedBox(height: 10.h),
                          InkWell(
                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                            onTap: () {
                              launchUrl(Uri.parse('tel:${_getController.contactUsModel.value.data!.result!.phone.toString()}'));
                            },
                            child: Text(_getController.contactUsModel.value.data!.result!.phone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400))
                          ),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                TextSmall(text: '${'Hamkorlik masalalari uchun bog‘lanish'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                              ]
                          ),
                          SizedBox(height: 10.w),
                          //Text(_getController.contactUsModel.value.data!.result!.corpPhone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                          InkWell(
                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                            onTap: () {
                              launchUrl(Uri.parse('tel:${_getController.contactUsModel.value.data!.result!.corpPhone.toString()}'));
                            },
                            child: Text(_getController.contactUsModel.value.data!.result!.corpPhone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400))
                          ),
                          SizedBox(height: 10.w),
                          Row(
                              children: [
                                Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                TextSmall(text: '${'Ijtimoiy tarmoqlar'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                              ]
                          ),
                          SizedBox(height: 15.h),
                          Row(
                              children: [
                                Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.youtube.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(TablerIcons.brand_youtube, color: AppColors.backgroundApp, size: 22.sp)
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.instagram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(TablerIcons.brand_instagram, color: AppColors.backgroundApp, size: 22.sp)
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.telegram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                      icon: Icon(TablerIcons.brand_telegram, color: AppColors.backgroundApp, size: 22.sp)
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.facebook.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(TablerIcons.brand_facebook, color: AppColors.backgroundApp, size: 22.sp)
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    launchUrl(Uri.parse('https://www.google.com/maps/place/Ildiz+Kitoblari/@41.3225176,69.2412639,17z/data=!3m1!4b1!4m6!3m5!1s0x38ae8badf2ad5ce5:0x1b714768928cd6c5!8m2!3d41.3225176!4d69.2412639!16s%2Fg%2F11qpvw832s?entry=ttu&g_ep=EgoyMDI0MDgyOC4wIKXMDSoASAFQAw%3D%3D'), mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                      width: Get.width,
                      margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 20.h),
                      padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextLarge(text: 'Ildiz kitoblari Xadra filiali', fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface,maxLines: 5),
                            SizedBox(height: 10.h),
                            Row(
                                children: [
                                  Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                  SizedBox(width: 10.w),
                                  TextSmall(text: '${'Manzil'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                                ]
                            ),
                            Html(style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(ComponentSize.textSmall(context)!), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)}, data: 'uz_UZ' == _getController.getLocale() ? _getController.contactUsModel.value.data!.result!.address!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.contactUsModel.value.data!.result!.address!.oz.toString() : _getController.contactUsModel.value.data!.result!.address!.ru.toString()),
                            SizedBox(height: 10.h)
                          ]
                      )
                  )
                ),
                if (_getController.partnerModel.value.data != null && _getController.partnerModel.value.data!.result != null)
                  for(int i = 0; i < _getController.partnerModel.value.data!.result!.length; i++)
                    Container(
                        width: Get.width,
                        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextLarge(text: 'uz_UZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].title!.uz! : 'oz_OZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].title!.oz! : _getController.partnerModel.value.data!.result![i].title!.ru!, textAlign: TextAlign.justify, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface,maxLines: 5),
                                  TextSmall(text: ' (${'hamkor'.tr})', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                  children: [
                                    Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                    SizedBox(width: 10.w),
                                    TextSmall(text: '${'Bog‘lanish uchun'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                                  ]
                              ),
                              SizedBox(height: 10.h),
                              InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  onTap: () =>launchUrl(Uri.parse('tel:${_getController.partnerModel.value.data!.result![i].phone.toString()}'), mode: LaunchMode.externalApplication),
                                  //child: Text(_getController.contactUsModel.value.data!.result!.phone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400))
                                  child: TextSmall(text: _getController.partnerModel.value.data!.result![i].phone.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400)
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                  children: [
                                    Icon(Icons.access_time, color: AppColors.backgroundApp, size: 20.sp),
                                    SizedBox(width: 10.w),
                                    TextSmall(text: '${'Ish vaqti'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                                  ]
                              ),
                              SizedBox(height: 10.h),
                              TextSmall(text: _getController.partnerModel.value.data!.result![i].workTime!.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                              SizedBox(height: 10.h),
                              Row(
                                  children: [
                                    Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                    SizedBox(width: 10.w),
                                    TextSmall(text: '${'Manzil'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400),
                                  ]

                              ),
                              Html(style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(ComponentSize.textSmall(context)!), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)}, data: 'uz_UZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].address!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].address!.oz.toString() : _getController.partnerModel.value.data!.result![i].address!.ru.toString()),
                              SizedBox(height: 10.h),
                              Container(
                                  width: Get.width,
                                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextSmall(text: '${'Mo‘ljal'.tr}:', color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                                        SizedBox(height: 10.h),
                                        TextSmall(text: 'uz_UZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].referencePoint!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.partnerModel.value.data!.result![i].referencePoint!.oz.toString() : _getController.partnerModel.value.data!.result![i].referencePoint!.ru.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400, maxLines: 1000),
                                        SizedBox(height: 8.h)
                                      ]
                                  )
                              ),
                              SizedBox(height: 20.h),
                              InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  onTap: () => launchUrl(Uri.parse(_getController.partnerModel.value.data!.result![i].link.toString()), mode: LaunchMode.externalApplication),
                                  child: Row(
                                    children: [
                                      TextSmall(text: 'Xaritada ko‘rish', color: AppColors.primaryColor, fontWeight: FontWeight.w500, fontSize: 18.sp),
                                      SizedBox(width: 5.w),
                                      Icon(TablerIcons.arrow_right, color: AppColors.primaryColor, size: 25.sp),
                                    ],
                                  )
                              ),
                              SizedBox(height: 10.h)
                            ]
                        )
                    ),
                SizedBox(height: 100.h)
              ])
          )
      )
    );
  }
}

class OSMData {
  final String displayName;
  final double lat;
  final double lon;
  OSMData({required this.displayName, required this.lat, required this.lon});
  @override
  String toString() => '$displayName, $lat, $lon';

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is OSMData && other.displayName == displayName;
  }

  @override
  int get hashCode => Object.hash(displayName, lat, lon);
}

class LatLong {
  final double latitude;
  final double longitude;
  const LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String addressName;
  final Map<String, dynamic> address;
  PickedData(this.latLong, this.addressName, this.address);
}