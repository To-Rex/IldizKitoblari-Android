import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/insturment/bottom_sheets.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../shop/filter_page1.dart';
import 'detail_page.dart';

class CatDetailPage extends StatelessWidget {
  final String title;
  final String menuSlug;
  final bool parent;
  final int menuIndex;

  CatDetailPage({super.key, required this.title, required this.menuSlug, required this.parent, required this.menuIndex});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    _getController.filters.clear();
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);

    if (!parent) {
      ApiController().getProduct(1, menuSlug, false,null,null,null,null);
    } else {
      ApiController().getSelectProduct(1, menuSlug, false,null,null,null,null);
    }
    BottomSheets().getFilterData(menuIndex, menuSlug);

    final ScrollController scrollController = ScrollController();

    return Scaffold(
        appBar: AppBar(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(title, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () {Get.back();},)
        ),
        body: Obx(() => Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.01),
                child: Row(
                    children: [
                      Expanded(child: Text(title, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500))),
                      InkWell(
                          onTap: () => BottomSheets().showBottomSheet(context, parent, menuSlug),
                          child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface),
                          child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)))),
                      IconButton(
                          onPressed: () {
                            Get.to(() => FilterPage1(menuIndex: menuIndex, menuSlug: menuSlug,parent: parent), fullscreenDialog: true, transition: Transition.cupertino);
                            //showBottomSheetFilter(context);
                          },
                          icon: Icon(TablerIcons.adjustments_horizontal, size: 25.sp, color: Theme.of(context).colorScheme.onSurface)
                      )
                    ]
                )
            ),
            if (_getController.productModelLength.value == 0)
              if (_getController.onLoading.value == true)
                Expanded(child: Center(child: TextLarge(text: 'Ma‘lumotlar yo‘q!'.tr, color: Theme.of(context).colorScheme.onSurface, fontSize: 18.sp, fontWeight: FontWeight.w600)))
              else
                Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.8,
                  width: Get.width,
                  padding: EdgeInsets.only(left: Get.width * 0.04), // Symmetrical padding on both sides
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (Get.width < 460) ? 2 : (Get.width < 800) ? 3 : 4, mainAxisExtent: 385.h, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) => const SkeletonItem()
                  )
                ),
              if (_getController.productModelLength.value != 0)
                Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const CustomRefreshHeader(),
                      footer: const CustomRefreshFooter(),
                      onLoading: () async {
                        if (!parent) {
                          ApiController().getProduct(_getController.page.value + 1, menuSlug, true,
                              _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                              _getController.filters[4] == true ? true : null,
                              _getController.filters[5] == true ? true : null,
                              _getController.filters[0] == true ? 1 : -1
                          ).then((value) => _refreshController.loadComplete());
                        }
                        else {
                          ApiController().getSelectProduct(_getController.page.value + 1, menuSlug, true,
                              _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                              _getController.filters[4] == true ? true : null,
                              _getController.filters[5] == true ? true : null,
                              _getController.filters[0] == true ? 1 : -1
                          ).then((value) => _refreshController.loadComplete());
                        }
                        _getController.page.value++;
                      },
                      onRefresh: () async {
                        _getController.page.value = 1;
                        if (!parent) {
                          ApiController().getProduct(1, menuSlug, false,null,null,null,null).then((value) => _refreshController.refreshCompleted());
                        } else {
                          _getController.page.value = 1;
                          _getController.productModelLength.value = 0;
                          ApiController().getSelectProduct(1, menuSlug, false,null,null,null,null).then((value) => _refreshController.refreshCompleted());
                        }
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: _refreshController,
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width * 0.04),
                        child: GridView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: (Get.width < 460) ? 2 : (Get.width < 800) ? 3 : 4,
                              childAspectRatio: (Get.width < 460) ? 0.6 : (Get.width < 800) ? 0.7 : 0.8,
                              mainAxisExtent: 385.h,
                              mainAxisSpacing: Get.width * 0.018,
                              crossAxisSpacing: Get.width * 0.03
                            ),
                            itemCount: _getController.productModel.value.data!.result!.length,
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
                  )
              )
            ]
          )
        )
    );
  }
}
