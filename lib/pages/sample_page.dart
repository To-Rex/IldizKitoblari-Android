import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../companents/bottombar_icons.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  void _onItemTapped(int index) {
    _getController.changeIndex(index);
    _getController.changeWidgetOptions();
    _getController.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    _getController.changeWidgetOptions();
    if (_getController.meModel.value.data == null) {
      ApiController().me().then((value) => ApiController().getBasket());
    }
    return Scaffold(
        //body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
        body: Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/back.png'), fit: BoxFit.cover)),
            child: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value))
        ),
        bottomNavigationBar: BottomAppBar(
          height: 85.sp,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.surface,
          child: Obx(() => Container(
            margin: EdgeInsets.only(left: 5.sp, right: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(0);
                  },
                  child: BottomBarIcons(
                    icon: 'assets/icon/home.svg',
                    title: 'Asosiy'.tr,
                    isSelected: _getController.index.value == 0
                  )
                ),
                InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    onTap: () {_onItemTapped(1);},
                    child: BottomBarIcons(
                      icon: 'assets/icon/shop.svg',
                      title: 'Do‘kon'.tr,
                      isSelected: _getController.index.value == 1,
                    )
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(2);
                  },
                  child: BottomBarIcons(
                    icon: 'assets/icon/library.svg',
                    title: 'Kutubxona'.tr,
                    isSelected: _getController.index.value == 2
                  )
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(3);
                  },
                    child:BottomBarIcons(
                      icon: 'assets/icon/basket.svg',
                      title: 'Savatcha'.tr,
                      isSelected: _getController.index.value == 3
                    )
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(4);
                  },
                    child: BottomBarIcons(
                      icon: 'assets/icon/account.svg',
                      title: 'Sahifam'.tr,
                      isSelected: _getController.index.value == 4
                    )
                )
              ]
            )
          )
          ),
        )
    );
  }
}