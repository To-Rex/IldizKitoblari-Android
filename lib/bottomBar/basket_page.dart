import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/appbar/custom_header.dart';
import '../companents/basket/e_list_shop.dart';
import '../companents/basket/list_shop.dart';
import '../companents/skeleton/skeleton_list_shop.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../pages/order/order_cauntry_page.dart';
import '../pages/order/order_payment_type.dart';
import '../resource/colors.dart';

class BasketPage extends StatelessWidget {
  BasketPage({super.key});
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    _getController.tabController = TabController(length: 2, vsync: Navigator.of(context));
    int previousIndex = 0;
    bool isRefreshing = false;
    _getController.tabController.addListener(() async {
      if (previousIndex != _getController.tabController.index) {
        previousIndex = _getController.tabController.index;
        print(_getController.tabController.index);
        if (isRefreshing) return;  // Prevent duplicate refresh requests
        isRefreshing = true;
        await ApiController().getBasket().then((value) {
          _getController.allCheckBoxCard.value = true;
          _getController.allECheckBoxCard.value = true;
          _getController.changeAllECheckBoxCardList();
        }).whenComplete(() {
          _refreshController.refreshCompleted();
          isRefreshing = false;  // Reset the flag once the request completes
        });
      }
    });

    return Stack(
      children: [
        Positioned.fill(
            child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const CustomRefreshHeader(),
                footer: const CustomRefreshFooter(),
                onLoading: () async {
                  _refreshController.loadComplete();},
                onRefresh: () async {
                  if (isRefreshing) return;  // Prevent duplicate refresh requests
                  isRefreshing = true;
                  await ApiController().getBasket().then((value) {
                    _getController.allCheckBoxCard.value = true;
                    _getController.allECheckBoxCard.value = true;
                    _getController.changeAllECheckBoxCardList();
                  }).whenComplete(() {
                    _refreshController.refreshCompleted();
                    isRefreshing = false;  // Reset the flag once the request completes
                  });
                },
                controller: _refreshController,
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Obx(() => Column(
                        children: [
                          Container(
                            height: 42.h,
                            width: Get.width,
                            margin: EdgeInsets.only(top: 60.h, bottom: 10.h, left: 13.w, right: 15.w),
                            child: Text('Savatcha'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 27.sp, fontWeight: FontWeight.bold)),
                          ),
                          Container(
                              width: Get.width,
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                              child: Column(
                                  children: [
                                    Container(
                                        width: Get.width,
                                        height: Get.height * 0.051,
                                        margin: EdgeInsets.only(top: 16.h),
                                        child: Container(
                                            constraints: BoxConstraints.expand(height:  Get.height * 0.06),
                                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                            padding: EdgeInsets.all(5.sp),
                                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(11.r)),
                                            child: TabBar(
                                                indicatorSize: TabBarIndicatorSize.tab,
                                                dividerColor: Colors.transparent,
                                                controller: _getController.tabController,
                                                labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                                indicator: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(9.r), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: const Offset(0, 2))]),
                                                tabs: [
                                                  Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Do‘kon'.tr,maxLines: 1,overflow: TextOverflow.ellipsis)))),
                                                  //Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: TextSmall(text: 'Do‘kon'.tr,maxLines: 1,overflow: TextOverflow.ellipsis),))),
                                                  Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('EKutubxona'.tr,maxLines: 1,overflow: TextOverflow.ellipsis))))
                                                  //Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: TextSmall(text: 'EKutubxona'.tr,maxLines: 1,overflow: TextOverflow.ellipsis),))),
                                                ]
                                            )
                                        )
                                    ),
                                    SizedBox(
                                        height: _getController.calculateTotalHeight(_getController.tabController.index),
                                        child: TabBarView(
                                            controller: _getController.tabController,
                                            children: [
                                              if (_getController.basketModel.value.data != null && _getController.meModel.value.data != null)
                                                if (_getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
                                                  ListShop()
                                                else if (_getController.basketModel.value.data!.result == null && _getController.basketModel.value.data!.result!.isEmpty)
                                                  const Skeletonizer(child: SkeletonListShop())
                                                else
                                                  Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                                          SizedBox(height: _getController.height.value * 0.01),
                                                          SizedBox(
                                                              width: _getController.width.value * 0.65,
                                                              child: Text(
                                                                  textAlign: TextAlign.center,
                                                                  'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
                                                          ),
                                                          SizedBox(height: _getController.height.value * 0.01),
                                                          SizedBox(
                                                              width: _getController.width.value * 0.5,
                                                              child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                                                  onPressed: () {_getController.index.value = 1;},
                                                                  child: Center(child: Text('Xaridni boshlash'.tr, style: TextStyle(color: Colors.white, fontSize: 16.sp)))
                                                              )
                                                          )
                                                        ],
                                                      ))
                                              else
                                                Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                                        SizedBox(height: _getController.height.value * 0.01),
                                                        SizedBox(
                                                            width: _getController.width.value * 0.65,
                                                            child: Text(
                                                                textAlign: TextAlign.center,
                                                                'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
                                                        ),
                                                        SizedBox(height: _getController.height.value * 0.01),
                                                        SizedBox(
                                                            width: _getController.width.value * 0.5,
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                                                onPressed: () {_getController.index.value = 1;},
                                                                child: Center(child: Text('Xaridni boshlash'.tr, style: TextStyle(color: Colors.white, fontSize: 16.sp)))
                                                            )
                                                        )
                                                      ],
                                                    )),

                                              if (_getController.eBasketModel.value.data != null && _getController.meModel.value.data != null)
                                                if (_getController.eBasketModel.value.data!.result != null && _getController.eBasketModel.value.data!.result!.isNotEmpty)
                                                  EListShop()
                                                else if (_getController.eBasketModel.value.data!.result == null && _getController.eBasketModel.value.data!.result!.isEmpty)
                                                  const Skeletonizer(child: SkeletonListShop())
                                                else
                                                  Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                                          SizedBox(height: _getController.height.value * 0.01),
                                                          SizedBox(
                                                              width: _getController.width.value * 0.65,
                                                              child: Text(
                                                                  textAlign: TextAlign.center,
                                                                  'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
                                                          ),
                                                          SizedBox(height: _getController.height.value * 0.01),
                                                          SizedBox(
                                                              width: _getController.width.value * 0.5,
                                                              child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                                                  onPressed: () {_getController.index.value = 1;},
                                                                  child: Center(child: Text('Xaridni boshlash'.tr, style: TextStyle(color: Colors.white, fontSize: 16.sp)))
                                                              )
                                                          )
                                                        ],
                                                      ))
                                              else
                                                Center(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                                      SizedBox(height: _getController.height.value * 0.01),
                                                      SizedBox(
                                                          width: _getController.width.value * 0.65,
                                                          child: Text(
                                                              textAlign: TextAlign.center,
                                                              'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
                                                      ),
                                                      SizedBox(height: _getController.height.value * 0.01),
                                                      SizedBox(
                                                          width: _getController.width.value * 0.5,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: AppColors.primaryColor,
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                                                              ),
                                                              onPressed: () {
                                                                _getController.index.value = 1;
                                                              },
                                                              child: Center(
                                                                  child: Text('Xaridni boshlash'.tr, style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16.sp)
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ],
                                                  ))
                                            ]
                                        )
                                    )
                                  ]
                              )
                          )
                        ]
                    ))
                )
            )
        ),
        Positioned(
          bottom: 0,
          width: Get.width,
          child: Obx(() {
            bool showBottomBar = false;
            if (_getController.tabController.index == 0) {
              showBottomBar = _getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty && _getController.checkBoxCardList.contains(true);
            } else {
              showBottomBar = _getController.eBasketModel.value.data != null && _getController.eBasketModel.value.data!.result != null && _getController.eBasketModel.value.data!.result!.isNotEmpty && _getController.checkEBoxCardList.contains(true);
            }
            if (!showBottomBar) return const SizedBox();

            return Container(
              padding: EdgeInsets.only(top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01, left: _getController.width.value * 0.02, right: _getController.width.value * 0.02),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)), boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 2))]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${'Jami miqdor'.tr}:', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                        Text('${_getController.tabController.index == 0 ? _getController.getMoneyFormat(_getController.getPriceModel.value.data?.totalPrice) : _getController.getMoneyFormat(_getController.getEPriceModel.value.data?.totalPrice)} ''${'so‘m'.tr}', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)
                        )
                      ]
                    )
                  ),
                  SizedBox(
                    width: _getController.width.value * 0.38,
                    height: _getController.height.value * 0.055,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_getController.tabController.index == 0) {
                          print(_getController.getSelectedCard());
                          ApiController().orderCreate();
                          Get.to(() => OrderCountryPage(), transition: Transition.native);
                        } else {
                          print(_getController.getSelectedECard());
                          ApiController().orderLibraryCreate();
                          Get.to(() => PaymentTypePage(isBook: true), transition: Transition.native);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface))
                    )
                  )
                ]
              )
            );
          })
        )
      ]
    );
  }
}