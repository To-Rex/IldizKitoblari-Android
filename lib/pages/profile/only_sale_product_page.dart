import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../home/detail_page.dart';

class OnlySaleProductPage extends StatelessWidget{
  OnlySaleProductPage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    //page,limit,add
    ApiController().getOnlySaleProducts(1,12,false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Chegirmalar'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
              onPressed: () {
                Get.back();
              }
          )
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const CustomRefreshHeader(),
          footer: const CustomRefreshFooter(),
          onLoading: () async {
            _refreshController.loadComplete();
          },
          onRefresh: () async {
            _refreshController.refreshCompleted();
            ApiController().getOnlySaleProducts(1,12,false);
          },
          physics: const BouncingScrollPhysics(),
          controller: _refreshController,
          child: Obx(() => Column(
              children: [
                if (_getController.productModelLength.value == 0)
                  if (_getController.onLoading.value == false)
                    Expanded(child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500))))
                  else
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: Get.height < 668 ? 2 : Get.height < 933 ? 2 : Get.height < 1025 || Get.height < 1181 ? 3 : 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        childAspectRatio: Get.height < 668 ? 0.46 : Get.height < 933 ? 0.52 : Get.height < 1025 ? 0.55 : 0.6,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        children: List.generate(15, (index) => const SkeletonItem()), // Replace SkeletonItem with your actual widget
                      ),
                    ),
                if (_getController.onLoading.value == true && _getController.productModelLength.value != 0)
                  Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.04),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.height < 668 ? 2 : Get.height < 933 ? 2 : Get.height < 1025 || Get.height < 1181 ? 3 : 4,
                            childAspectRatio: Get.height < 668 ? 0.46 : Get.height < 933 ? 0.52 : Get.height < 1025 ? 0.55 : 0.6,
                            mainAxisExtent: 385.h,
                            mainAxisSpacing: _getController.height.value * 0.018,
                            crossAxisSpacing: _getController.width.value * 0.03,
                          ),
                          itemCount: _getController.productModelLength.value,
                          itemBuilder: (context, index) {
                            return ProductItem(
                              id: _getController.productModel.value.data!.result![index].sId!,
                              title: _getController.productModel.value.data!.result![index].name!,
                              deck: _getController.productModel.value.data!.result![index].slug!,
                              price: _getController.productModel.value.data!.result![index].price!.toString(),
                              imageUrl: _getController.productModel.value.data!.result![index].image ?? '',
                              count: _getController.productModel.value.data!.result![index].count ?? 0,
                              function: () {
                                _getController.clearProductDetailModel();
                                _getController.clearProductDetailList();
                                Get.to(() => DetailPage(slug: _getController.productModel.value.data!.result![index].slug!, pageIndex: 0));},
                                sale: _getController.productModel.value.data!.result![index].sale ?? 0
                            );
                          })
                  )
              ]
          ))
      )
    );
  }
}