import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/appbar/custom_header.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/scleton_item.dart';
import '../companents/search_fild.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../pages/home/cat_detail_page.dart';
import '../pages/home/detail_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final GetController _getController = Get.put(GetController());

  void _getData() {
    _getController.clearBannerModel();
    _getController.onLoad();
    if(_getController.onLoading.value) {
      ApiController().getBanner(1,1).then((value) {
        _getController.changeItemPage(0);
        if (_getController.menuModel.value.data != null) {
          ApiController().getShopMenu().then((value) => _getController.refreshController.refreshCompleted());
        } else {
          _getController.refreshController.refreshCompleted();
        }
      });
    }
  }

  void _onLoading() async {
    _getController.refreshController.refreshCompleted();
    _getController.refreshController.loadComplete();
    Get.focusScope!.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    _getController.changeItemPage(0);
    _getData();
    _getController.scrollController.addListener(() {
      if (_getController.scrollController.position.userScrollDirection != ScrollDirection.idle) {
        Get.focusScope!.unfocus();
      }
    });
    print('========= ${Get.height} - ${Get.width} ==========');
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        header: const CustomRefreshHeader(),
        footer: const CustomRefreshFooter(),
        onLoading: _onLoading,
        onRefresh: _getData,
        controller: _getController.refreshController,
        scrollDirection: Axis.vertical,
        scrollController: _getController.scrollController,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => Column(
                children: [
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 63.h, left: 15.sp),
                    alignment: Alignment.topLeft,
                    height: 35.h,
                    child: Text('Do‘kon'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 27.sp, fontWeight: FontWeight.bold)),
                  ),
                  SearchFields(onChanged: (String value) {
                    if (value.isEmpty && _getController.searchController.text == '') {
                      _getData();
                    }
                    if (value.isNotEmpty && _getController.menuModel.value.data != null && value.length >= 3 ) {
                      _getController.changeItemPage(0);
                      _getData();
                    }
                  }),
                  Container(
                    width: _getController.width.value,
                    padding: EdgeInsets.only(top: _getController.height.value * 0.01),
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                    child: Column(
                      children: [
                        if (_getController.shopDataModel.value.data != null && _getController.onLoading.value)
                          if (_getController.shopDataModel.value.data!.result!.any((category) => category.children != null && category.productCount! >= 2 && category.shopProductModel != null && category.shopProductModel!.data != null && category.shopProductModel!.data!.result!.isNotEmpty))
                            for (var category in _getController.shopDataModel.value.data!.result!)
                              Column(
                                children: [
                                  if (category.children != null && category.productCount! >= 2 && category.shopProductModel != null && category.shopProductModel!.data != null && category.shopProductModel!.data!.result!.length > 2)
                                    ChildItem(
                                      title: 'uz_UZ' == _getController.getLocale() ? category.title!.uz! : 'oz_OZ' == _getController.getLocale() ? category.title!.oz! : category.title!.ru!,
                                      function: () {
                                        _getController.page.value = 1;
                                        _getController.productModelLength.value = 0;
                                        _getController.clearProductModel();
                                        Get.to(() => CatDetailPage(
                                          title: 'uz_UZ' == _getController.getLocale()  ? category.title!.uz! : 'oz_OZ' == _getController.getLocale() ? category.title!.oz! : category.title!.ru!,
                                          menuSlug: category.slug!,
                                          parent: true,
                                          menuIndex: _getController.shopDataModel.value.data!.result!.indexOf(category)
                                        ));
                                      }
                                    ),
                                  if (category.children != null && category.productCount! >= 2 && category.shopProductModel != null && category.shopProductModel!.data != null && category.shopProductModel!.data!.result!.isNotEmpty)
                                    SizedBox(
                                      height: 385.h,
                                      width: _getController.width.value,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(left: 16.w),
                                        itemCount: category.shopProductModel != null && category.shopProductModel!.data != null ? category.shopProductModel!.data!.result!.length : 0,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return ProductItem(
                                            imageUrl: category.shopProductModel!.data!.result![index].image!,
                                            title: category.shopProductModel!.data!.result![index].name!,
                                            price: category.shopProductModel!.data!.result![index].price.toString(),
                                            function: () {
                                              _getController.page.value = 1;
                                              _getController.productModelLength.value = 0;
                                              _getController.clearProductModel();
                                              _getController.clearProductDetailModel();
                                              _getController.clearProductDetailList();
                                              Get.to(() => DetailPage(slug: category.shopProductModel!.data!.result![index].slug!, pageIndex: 0));
                                            },
                                            id: category.shopProductModel!.data!.result![index].sId,
                                            deck: category.shopProductModel!.data!.result![index].name,
                                            count: category.shopProductModel!.data!.result![index].count,
                                            sale: category.shopProductModel!.data!.result![index].sale ?? 0
                                          );
                                        }
                                      )
                                    )
                                ]
                              )
                          else
                            SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))))
                        else if (_getController.onLoading.value == false)
                          for (int i = 0; i < 4; i++)
                            Column(
                              children: [
                                Skeletonizer(child: ChildItem(title: 'kategoriyalar', function: (){})),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 16.w),
                                      for (int i = 0; i < 7; i++)
                                        const SkeletonItem(),
                                      SizedBox(width: 16.w)
                                    ]
                                  )
                                )
                              ]
                            )
                        else
                          SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))))
                      ]
                    )
                  )
                ]
            )
            )
        )
    );
  }
}

