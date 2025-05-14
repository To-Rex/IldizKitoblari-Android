import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../pages/home/notification_page.dart';

class SearchFields extends StatelessWidget {
  final Function(String) onChanged;
  SearchFields({super.key, required this.onChanged});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.sp,
      margin: EdgeInsets.only(top: 17.sp, left: 15.sp, right: 15.sp, bottom: 13.sp),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52.sp,
              padding: EdgeInsets.only(right: 5.sp),
              child: TextField(
                controller: _getController.searchController,
                onChanged: onChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (onChanged),
                decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13)),
                    fillColor: Theme.of(context).colorScheme.surface,
                    hintText: 'Kitoblarni izlash'.tr,
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), fontSize: 18.sp),
                    prefixIcon: Container(padding: EdgeInsets.all(12.sp), child: SvgPicture.asset('assets/icon/search.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface.withOpacity(0.6), BlendMode.srcIn))),
                    suffixIcon: _getController.searchController.text.isNotEmpty ? IconButton(
                      onPressed: () {
                        _getController.searchController.clear();
                        onChanged('');
                        },
                      icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), size: 15.sp),
                    ) : const SizedBox(height: 0, width: 0)
                )
              )
            )
          ),
          SizedBox(width: 10.sp),
          InkWell(
            onTap: () {
              //ApiController().me()
              Get.to(() => NotificationPage());
              //Get.to(() => AudioPage(sId: '6460ade09be170082729b3e1', title: 'test'));
              //Get.to(() => AudioPages(sId: '6460ade09be170082729b3e1', title: 'test'));

              /*_getController.page.value = 1;
              _getController.productModelLength.value = 0;
              _getController.clearProductDetailModel();
              _getController.clearProductDetailList();
              Get.to(() => DetailPage(slug: 'aldanganlar', pageIndex: 0));*/
            },
            child: Obx(() => Container(
                alignment: Alignment.center,
                height: 52.sp, width: 52.sp, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(0.2), borderRadius: BorderRadius.circular(13), border: Border.all(color: Theme.of(context).colorScheme.surface.withOpacity(0.2))),
                child: Badge(
                    isLabelVisible: _getController.notificationCountModel.value.notificationCountModelData == null ? false : _getController.notificationCountModel.value.notificationCountModelData!.count != null && _getController.notificationCountModel.value.notificationCountModelData!.count! > 0 ? true : false,
                    alignment: Alignment.topRight,
                    smallSize: 8.sp,
                    label: Text('${_getController.notificationCountModel.value.notificationCountModelData == null ? 0 : _getController.notificationCountModel.value.notificationCountModelData!.count == null ? 0 : _getController.notificationCountModel.value.notificationCountModelData!.count!.toInt() > 99 ? '99+' : _getController.notificationCountModel.value.notificationCountModelData?.count}', style: TextStyle(fontSize: 10.sp, color: Theme.of(context).colorScheme.onError, fontWeight: FontWeight.w500)),
                    child: SvgPicture.asset('assets/icon/bell.svg', height: 25.sp, width: 25.sp, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn))
                )
            ))
          )
        ]
      )
    );
  }
}