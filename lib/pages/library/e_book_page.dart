import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../home/detail_page.dart';
import '../shop/audio_page.dart';

class EBookPage extends StatelessWidget {
  final bool? isEbook;
  final bool? sale;

  EBookPage({super.key, this.isEbook = true , this.sale = false});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  //Future<void> _openEpubReader(BuildContext context, url) async => await CosmosEpub.openURLBook(urlPath: url, context: context, bookId: '3', accentColor: Colors.transparent, onPageFlip: (int currentPage, int totalPages) {debugPrint(currentPage.toString());}, onLastPage: (int lastPageIndex) {debugPrint('We arrived to the last widget');});

  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(isEbook == true ? 'Elektron kitoblar'.tr : 'Audio kitoblar'.tr, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () {Get.back();},)
        ),
        body: Obx(() => sale == false
            ? Column(
            children: [
              if (_getController.productEBookModel.value.data == null || _getController.productEBookModel.value.data!.result == null || _getController.productEBookModel.value.data!.result!.isEmpty && _getController.productAudioBookModel.value.data == null || _getController.productAudioBookModel.value.data!.result == null || _getController.productAudioBookModel.value.data!.result!.isEmpty)
                if (_getController.onLoading.value == true)
                  Expanded(child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500))))
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
              //if (_getController.onLoading.value == true && _getController.productEBookModel.value.data?.result!.isNotEmpty == true)
              if (_getController.onLoading.value == true && _getController.productEBookModel.value.data!.result!.isNotEmpty ||  _getController.productAudioBookModel.value.data!.result!.isNotEmpty)
                Expanded(
                    child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const CustomRefreshHeader(),
                        footer: const CustomRefreshFooter(),
                        onRefresh: () async {
                          if (isEbook == true) {
                            ApiController().getEBookLibraryList().then((value) => _refreshController.refreshCompleted());
                          } else {
                            ApiController().getAudioLibraryList().then((value) => _refreshController.refreshCompleted());
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: _refreshController,
                        child: Container(
                            margin: EdgeInsets.only(left: Get.width * 0.04),
                            child: isEbook == true
                                ? GridView.builder(
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
                                itemCount: _getController.productEBookModel.value.data!.result!.length,
                                itemBuilder: (context, index) {
                                  return ProductItem(
                                      id: _getController.productEBookModel.value.data!.result![index].sId!,
                                      title: _getController.productEBookModel.value.data!.result![index].name!,
                                      deck: _getController.productEBookModel.value.data!.result![index].slug!,
                                      price: _getController.productEBookModel.value.data!.result![index].price!.toString(),
                                      imageUrl: _getController.productEBookModel.value.data!.result![index].image ?? '',
                                      count: _getController.productEBookModel.value.data!.result![index].count ?? 0,
                                      function: () {
                                        _getController.clearProductDetailModel();
                                        _getController.clearProductDetailList();
                                        Get.to(() => DetailPage(slug: _getController.productEBookModel.value.data!.result![index].slug!, pageIndex: 0));},
                                      sale: _getController.productEBookModel.value.data!.result![index].sale ?? 0
                                  );
                                })
                                : GridView.builder(
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
                                itemCount: _getController.productAudioBookModel.value.data!.result!.length,
                                itemBuilder: (context, index) {
                                  return ProductItem(
                                      id: _getController.productAudioBookModel.value.data!.result![index].sId!,
                                      title: _getController.productAudioBookModel.value.data!.result![index].name!,
                                      deck: _getController.productAudioBookModel.value.data!.result![index].slug!,
                                      price: _getController.productAudioBookModel.value.data!.result![index].price!.toString(),
                                      imageUrl: _getController.productAudioBookModel.value.data!.result![index].image ?? '',
                                      count: _getController.productAudioBookModel.value.data!.result![index].count ?? 0,
                                      function: () {
                                        _getController.clearProductDetailModel();
                                        _getController.clearProductDetailList();
                                        Get.to(() => DetailPage(slug: _getController.productAudioBookModel.value.data!.result![index].slug!, pageIndex: 0));},
                                      sale: _getController.productAudioBookModel.value.data!.result![index].sale ?? 0
                                  );
                                })
                        )
                    )
                )
            ]
        )
            : Column(
            children: [
              if (_getController.eBookLibraryList.value.data == null || _getController.eBookLibraryList.value.data!.result == null || _getController.eBookLibraryList.value.data!.result!.isEmpty && _getController.eBookLibraryList.value.data == null || _getController.eBookLibraryList.value.data!.result == null || _getController.eBookLibraryList.value.data!.result!.isEmpty)
                if (_getController.onLoading.value == true)
                  Expanded(child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500))))
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
              //if (_getController.onLoading.value == true && _getController.productEBookModel.value.data?.result!.isNotEmpty == true)
              if (_getController.onLoading.value == true && _getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result!.isNotEmpty || _getController.audioLibraryList.value.data != null &&  _getController.audioLibraryList.value.data!.result!.isNotEmpty)
                Expanded(
                    child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: const CustomRefreshHeader(),
                        footer: const CustomRefreshFooter(),
                        onRefresh: () async {
                          if (isEbook == true) {
                            if (sale == false) {
                              ApiController().getEBookLibraryList().then((value) => _refreshController.refreshCompleted());
                            } else {
                              ApiController().getEBookLibraryList().then((value) => _refreshController.refreshCompleted());
                            }
                          }
                          else {
                            if (sale == false) {
                              ApiController().getAudioLibraryList().then((value) => _refreshController.refreshCompleted());
                            } else {
                              ApiController().getAudioLibraryList().then((value) => _refreshController.refreshCompleted());
                            }
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: _refreshController,
                        child: Container(
                            margin: EdgeInsets.only(left: Get.width * 0.04),
                            child: isEbook == true
                                ? GridView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (Get.width < 460) ? 2 : (Get.width < 800) ? 3 : 4, childAspectRatio: (Get.width < 460) ? 0.6 : (Get.width < 800) ? 0.7 : 0.8, mainAxisExtent: 385.h, mainAxisSpacing: Get.width * 0.018, crossAxisSpacing: Get.width * 0.03),
                                itemCount: _getController.eBookLibraryList.value.data!.result == null ? 0 : _getController.eBookLibraryList.value.data!.result!.length ,
                                itemBuilder: (context, index) {
                                  return ProductItem(
                                      //id: _getController.eBookLibraryList.value.data!.result![index].product?.sId ?? '',
                                      id: _getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result != null ? _getController.eBookLibraryList.value.data!.result![index].product?.sId ?? 'ok' : 'ok',
                                      title: _getController.eBookLibraryList.value.data!.result![index].product!.name?.oz ?? '',
                                      deck: _getController.eBookLibraryList.value.data!.result![index].product!.name?.oz ?? '',
                                      //price: _getController.eBookLibraryList.value.data!.result![index].product!.ebookPrice.toString(),
                                      price: '0',
                                      imageUrl: _getController.eBookLibraryList.value.data!.result![index].product?.image ?? '',
                                      count: 1,
                                      function: () {
                                        //_openEpubReader(context,_getController.eBookLibraryList.value.data!.result![index].product?.ebook).then((value) => Get.back());
                                        Get.dialog(barrierDismissible: true, AlertDialog(backgroundColor: Colors.transparent, insetPadding: EdgeInsets.zero, content: SizedBox(width: Get.width, height: Get.height * 0.8, child: const Center(child: CircularProgressIndicator(color: AppColors.primaryColor3, strokeWidth: 2)))));
                                      },
                                      sale: 0,
                                    sold: true,
                                  );
                                })
                                : GridView.builder(
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
                                itemCount: _getController.audioLibraryList.value.data!.result!.length,
                                itemBuilder: (context, index) {
                                  return ProductItem(
                                    id: _getController.audioLibraryList.value.data!.result![index].product?.sId!,
                                    title: _getController.audioLibraryList.value.data!.result![index].product!.name?.uz,
                                    deck: _getController.audioLibraryList.value.data!.result![index].product!.name?.uz,
                                    price: _getController.audioLibraryList.value.data!.result![index].product!.audioPrice.toString(),
                                    imageUrl: _getController.audioLibraryList.value.data!.result![index].product?.image ?? '',
                                    count: 1,
                                    function: () {
                                      /*Get.to(() => AudioPage(
                                        sId: _getController.audioLibraryList.value.data!.result![index].sId!,
                                        title: _getController.audioLibraryList.value.data!.result![index].product!.name!.uz!,
                                      ));*/
                                    },
                                    sale: 0,
                                    sold: true
                                  );
                                }
                            )
                        )
                    )
                )
            ]
        )
        )
    );
  }
}
