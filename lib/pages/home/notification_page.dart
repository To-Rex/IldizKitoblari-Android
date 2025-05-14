import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../../resource/component_size.dart';
import 'detail_page.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final GetController _getController = Get.put(GetController());

  void _getData() {
    _getController.clearNotificationModel();
    ApiController().getNotification();
    _getController.refreshNotifyController.refreshCompleted();
  }

  void _onLoading() async {
    _getController.refreshNotifyController.refreshCompleted();
    _getController.refreshNotifyController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    _getController.clearNotificationModel();
    ApiController().getNotification();

    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.black : AppColors.white,
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.black : AppColors.white,
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () => Navigator.pop(context)),
            title: TextSmall(text: 'Bildirishnomalar'.tr, color: Theme.of(context).colorScheme.onSurface), centerTitle: true,
          actions: [
            IconButton(onPressed: () {ApiController().readAllNotification();}, icon: Icon(Icons.done_all, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context))),
            SizedBox(width: 10.w),
          ],
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: const CustomRefreshHeader(),
            footer: const CustomRefreshFooter(),
            onLoading: _onLoading,
            onRefresh: _getData,
            controller: _getController.refreshNotifyController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() {
                  final results = _getController.notificationModel.value.data?.result ?? [];
                  if (results.isEmpty) {
                    return SizedBox(height: Get.height * 0.8, width: Get.width, child: Center(child: TextSmall(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface)));
                  } else {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: results.length,
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final item = results[index];
                        return InkWell(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          onTap: () {
                            if (item.isRead == false)ApiController().readNotification(item.sId);
                            if (item.product?.menuSlug != null) {
                              _getController.page.value = 1;
                              _getController.productModelLength.value = 0;
                              _getController.clearProductDetailModel();
                              _getController.clearProductDetailList();
                              Get.to(() => DetailPage(slug: item.product!.slug!, pageIndex: 0));
                            }
                          },
                          child: Container(
                              width: Get.width,
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              padding: EdgeInsets.only(left: 10.w, right: 8.w, top: 10.h, bottom: 10.h),
                              decoration: BoxDecoration(
                                  border: Border.all(color: item.isRead == false ? Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.primaryColor : Colors.transparent, width: 0.5.w),
                                  color: Theme.of(context).brightness == Brightness.dark ? AppColors.black : AppColors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.2), blurRadius: 15, spreadRadius: 5)]
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      TextSmall(text: DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(item.createdAt!)), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400, fontSize: 12.sp),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          ApiController().notificationRemove(item.sId);
                                        },
                                        child: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: 20.sp)
                                      )
                                    ]
                                  ),
                                  SizedBox(height: 5.h),
                                  if (item.product?.name != null)
                                    TextSmall(text:'uz_UZ' == _getController.getLocale() ? item.product!.name!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? item.product!.name!.oz.toString() : 'ru_RU' == _getController.getLocale() ? item.product!.name!.ru.toString() : '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, maxLines: 3000),
                                  SizedBox(height: 5.h),
                                  TextSmall(text:'uz_UZ' == _getController.getLocale() ? item.title?.uz ?? '' : 'oz_OZ' == _getController.getLocale() ? item.title?.oz ?? '' : 'ru_RU' == _getController.getLocale() ? item.title?.ru ?? '' : '', color: Theme.of(context).colorScheme.onSurface, maxLines: 3000, fontWeight: item.product?.name != null ? FontWeight.normal : FontWeight.bold),
                                  if (item.product?.name != null)
                                    SizedBox(height: 5.h),
                                  if (item.product?.name != null)
                                  TextSmall(text: 'uz_UZ' == _getController.getLocale() ? item.description?.uz ?? '': 'oz_OZ' == _getController.getLocale() ? item.description?.oz ?? '': 'ru_RU' == _getController.getLocale() ? item.description?.ru ?? '': '', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), maxLines: 3000),
                                ]
                              )
                          )
                        );
                      }
                    );
                  }
                })
            )
        )
    );
  }
}
