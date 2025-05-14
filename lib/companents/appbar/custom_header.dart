import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRefreshHeader extends StatelessWidget {

  const CustomRefreshHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: 100.sp,
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = Text('Ma’lumotlarni yangilash uchun tashlang'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface));
        } else if (mode == RefreshStatus.refreshing) {
          body = Container(margin: EdgeInsets.only(top: 20.sp), child: const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2));
        } else if (mode == RefreshStatus.failed) {
          body = Text('Ex nimadir xato ketdi'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.error));
        } else if (mode == RefreshStatus.canRefresh) {
          body = Text('Ma’lumotlarni yangilash uchun tashlang'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.surface));
        } else {
          body = Text('Ma’lumotlar yangilandi'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.surface));
        }
        return SizedBox(height: 60.sp, child: Center(child: body));
      }
    );
  }
}

class CustomRefreshFooter extends StatelessWidget {
  const CustomRefreshFooter({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SizedBox();
        } else if (mode == LoadStatus.loading) {
          body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
        } else if (mode == LoadStatus.failed) {
          body = Text('Ex nimadir xato ketdi'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.error));
        } else if (mode == LoadStatus.canLoading) {
          body = const SizedBox();
        } else {
          body = Text('Ma’lumotlar yangilandi'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface));
        }
        return SizedBox(height: 60.sp, child: Center(child: body));
      }
    );
  }
}