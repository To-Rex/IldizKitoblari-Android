import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/appbar/custom_header.dart';
import '../companents/child_item.dart';
import '../companents/filds/text_small.dart';
import '../companents/product_item.dart';
import '../companents/scleton_item.dart';
import '../companents/search_fild.dart';
import '../companents/skleton_child_item.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../pages/home/detail_page.dart';
import '../pages/library/e_book_page.dart';
import '../pages/library/ebooks.dart';
import '../pages/shop/audio_page.dart';
import '../resource/colors.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({super.key});

  final GetController _getController = Get.put(GetController());

  void _getData() {
    _getController.clearEBookLibraryList();
    _getController.clearAudioLibraryList();

    ApiController().getEBookLibraryList();
    ApiController().getAudioLibraryList();
    _getController.refreshLibController.refreshCompleted();
  }

  void _onLoading() async {
    _getController.refreshLibController.refreshCompleted();
    _getController.refreshLibController.loadComplete();
  }

/*  Future<void> _openEpubReader(BuildContext context, url) async {
    await CosmosEpub.openURLBook(urlPath: url, context: context, bookId: '3', accentColor: Colors.transparent, onPageFlip: (int currentPage, int totalPages) {debugPrint(currentPage.toString());}, onLastPage: (int lastPageIndex) {debugPrint('We arrived to the last widget');});
  }*/

  @override
  Widget build(BuildContext context) {
    _getController.tabController = TabController(length: 2, vsync: Navigator.of(context) as TickerProvider);
    _getController.scrollController.addListener(() {
      if (_getController.scrollController.position.userScrollDirection != ScrollDirection.idle) {
        Get.focusScope!.unfocus();
      }
    });
    _getController.clearEBookLibraryList();
    _getController.clearAudioLibraryList();

    ApiController().getEBookLibraryList();
    ApiController().getAudioLibraryList();

    return  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        physics: const BouncingScrollPhysics(),
        header: const CustomRefreshHeader(),
        footer: const CustomRefreshFooter(),
        onLoading: _onLoading,
        onRefresh: _getData,
        controller: _getController.refreshLibController,
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
                    child: Text('Kutubxona'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 27.sp, fontWeight: FontWeight.bold)),
                  ),
                  SearchFields(
                      onChanged: (String value) {
                        if (_getController.tabController.index == 0) {
                          if (value.isEmpty) {
                            ApiController().getBook();
                          } else if (_getController.searchController.text.length > 3) {
                            ApiController().getBook();
                          }
                        } else {
                          if (value.isEmpty) {
                            ApiController().getAudio();
                          } else if (_getController.searchController.text.length > 3) {
                            ApiController().getAudio();
                          }
                        }
                      }
                  ),
                  Container(
                      width: _getController.width.value,
                      padding: EdgeInsets.only(top: _getController.height.value * 0.01),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                      child: Column(
                          children: [
                            Container(
                                width: Get.width,
                                height: Get.height * 0.051,
                                margin: EdgeInsets.only(top: 16.h),
                                child: Container(
                                    constraints: BoxConstraints.expand(height:  Get.height * 0.06),
                                    margin: EdgeInsets.symmetric(horizontal: 15.sp),
                                    padding: EdgeInsets.all(5.sp),
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(11.r)),
                                    child: TabBar(
                                      onTap: (int index) {
                                        if (index == 0) {
                                          ApiController().getEBookLibraryList();
                                        } else {
                                          ApiController().getAudioLibraryList();
                                        }},
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        dividerColor: Colors.transparent,
                                        controller: _getController.tabController,
                                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                        indicator: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(9.r), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: const Offset(0, 2))]),
                                        tabs: [
                                          Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: TextSmall(text: 'Elektron kitoblar'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis)))),
                                          Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: TextSmall(text: 'Audio kitoblar'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis))))
                                        ]
                                    )
                                )
                            ),
                            SizedBox(
                              width: Get.width,
                              height: 710.h,
                              child: TabBarView(
                                  controller: _getController.tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 15.h),
                                        if (_getController.meModel.value.data != null && _getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result!.isNotEmpty)
                                          ChildItem(title: 'O‘qilayotgan kitoblar'.tr, function: (){
                                            Get.to(EBookPage(sale: true));
                                          })
                                        else if (_getController.meModel.value.data != null && _getController.eBookLibraryList.value.data == null)
                                          SkeletonChildItem(),
                                        if (_getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result!.isNotEmpty)
                                          SizedBox(
                                              height: 120.h,
                                              width: Get.width,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.only(left: Get.width * 0.04),
                                                  itemCount: _getController.eBookLibraryList.value.data!.result!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) => InkWell(
                                                      onTap: () {
                                                        _getController.whileApi.value = false;
                                                        _getController.fontSize.value = Get.height * 0.017;
                                                        //_openEpubReader(context, 'https://github.com/Mamasodikov/cosmos_epub/raw/refs/heads/master/example/assets/book.epub').then((value) => Get.back());
                                                        //_openEpubReader(context, 'https://github.com/ikrukov/epub/raw/refs/heads/master/books/GNU%20make/make.epub').then((value) => Get.back());
                                                        //_openEpubReader(context,_getController.eBookLibraryList.value.data!.result![index].product?.ebook).then((value) => Get.back());
                                                        Get.to(EpubReaderPage(epubUrl: _getController.eBookLibraryList.value.data!.result![index].product!.ebook!));
                                                        print(_getController.eBookLibraryList.value.data!.result![index].product?.ebook);
                                                      },
                                                      child: Container(
                                                          width: Get.width * 0.9,
                                                          margin: EdgeInsets.only(right: 15.sp),
                                                          padding: EdgeInsets.all(10.sp),
                                                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color:AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                                                          child: Row(
                                                              children: [
                                                                Container(
                                                                    width: 100.sp,
                                                                    height: 105.sp,
                                                                    margin: EdgeInsets.only(right: 15.sp),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        child: Image.network(
                                                                            _getController.eBookLibraryList.value.data!.result![index].product?.image == null ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : '${_getController.eBookLibraryList.value.data!.result![index].product!.image}',
                                                                            fit: BoxFit.cover,
                                                                            loadingBuilder: (context, child, loadingProgress) {
                                                                              if (loadingProgress == null) return child;
                                                                              return SizedBox(width: _getController.width.value * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: Get.height * 0.205, color: AppColors.grey)));
                                                                              },
                                                                            errorBuilder: (context, error, stackTrace) => Center(child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png')))
                                                                    )
                                                                ),
                                                                Expanded(child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      TextSmall(text: _getController.eBookLibraryList.value.data!.result![index].product!.name!.uz.toString(), color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                                                                      SizedBox(height: 8.sp),
                                                                      TextSmall(text: _getController.eBookLibraryList.value.data!.result![index].product!.sId!.toString(), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 11.sp),
                                                                    ]
                                                                ))
                                                              ]
                                                          )
                                                      )
                                                  )
                                              )
                                          )
                                        else
                                          Container(
                                            width: Get.width,
                                            height: 120.h,
                                            margin: EdgeInsets.only(top: 15.h, left: 15.sp, right: 15.sp, bottom: 15.h),
                                            padding: EdgeInsets.all(10.sp),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color:AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                                            child: TextSmall(text: 'Elektron kitoblar mavjud emas'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 15.sp),
                                          ),
                                        if (_getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result!.isNotEmpty)
                                          SizedBox(height: 15.h),
                                        if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                                          ChildItem(title: 'Elektron kitoblar'.tr, function: () => Get.to(() => EBookPage(sale: false)))
                                        else
                                          SkeletonChildItem(),
                                        if (_getController.eBookLibraryList.value.data != null && _getController.eBookLibraryList.value.data!.result!.isNotEmpty)
                                          SizedBox(height: 5.h),
                                        if (_getController.productEBookModel.value.data != null && _getController.productEBookModel.value.data!.result!.isNotEmpty)
                                          SizedBox(
                                              height: 375.h,
                                              width: Get.width,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.only(left: Get.width * 0.04),
                                                  itemCount: _getController.productEBookModel.value.data!.result!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return ProductItem(
                                                      imageUrl: _getController.productEBookModel.value.data!.result![index].image,
                                                      title: _getController.productEBookModel.value.data!.result![index].name,
                                                      price: _getController.productEBookModel.value.data!.result![index].price.toString(),
                                                      productType: _getController.productEBookModel.value.data!.result![index].productType,
                                                      function: () {
                                                        _getController.page.value = 1;
                                                        _getController.productModelLength.value = 0;
                                                        _getController.clearProductDetailModel();
                                                        _getController.clearProductDetailList();
                                                        Get.to(() => DetailPage(
                                                          slug: _getController.productEBookModel.value.data!.result![index].slug!,
                                                          pageIndex: 0,
                                                        ));
                                                      },
                                                      id: _getController.productEBookModel.value.data!.result![index].sId,
                                                      deck: _getController.productEBookModel.value.data!.result![index].name,
                                                      count: _getController.productEBookModel.value.data!.result![index].count,
                                                      sale: _getController.productEBookModel.value.data!.result![index].sale ?? 0,
                                                    );
                                                  }))
                                        else
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
                                      ]
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 15.h),
                                        if (_getController.audioLibraryList.value.data != null && _getController.audioLibraryList.value.data!.result!.isNotEmpty)
                                          ChildItem(title: 'Tinglanayotgan kitoblar'.tr, function: (){
                                            Get.to(EBookPage(isEbook: false, sale: true));
                                          })
                                        else if (_getController.meModel.value.data != null && _getController.audioLibraryList.value.data == null)
                                          SkeletonChildItem(),
                                        if (_getController.audioLibraryList.value.data != null && _getController.audioLibraryList.value.data!.result!.isNotEmpty)
                                          SizedBox(
                                              height: 120.h,
                                              width: Get.width,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.only(left: Get.width * 0.04),
                                                  itemCount: _getController.audioLibraryList.value.data!.result!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) => InkWell(
                                                      onTap: () {
                                                        Get.to(() => AudioPage(
                                                          sId: _getController.audioLibraryList.value.data!.result![index].sId!,
                                                          title: _getController.audioLibraryList.value.data!.result![index].product!.name!.uz!,
                                                        ));
                                                      },
                                                      child: Container(
                                                          width: Get.width * 0.9,
                                                          margin: EdgeInsets.only(right: 15.sp),
                                                          padding: EdgeInsets.all(10.sp),
                                                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color:AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  width: 100.sp,
                                                                  height: 105.sp,
                                                                  margin: EdgeInsets.only(right: 15.sp),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      child: Image.network(
                                                                          _getController.audioLibraryList.value.data!.result![index].product?.image == null ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : '${_getController.audioLibraryList.value.data!.result![index].product!.image}',
                                                                          fit: BoxFit.cover,
                                                                          loadingBuilder: (context, child, loadingProgress) {
                                                                            if (loadingProgress == null) {return child;}
                                                                            return SizedBox(width: _getController.width.value * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: Get.height * 0.205, color: AppColors.grey)));
                                                                          },
                                                                          errorBuilder: (context, error, stackTrace) => Center(child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'))
                                                                      )
                                                                  )
                                                              ),
                                                              Expanded(child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    TextSmall(text: _getController.audioLibraryList.value.data!.result![index].product!.name!.uz.toString(), fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
                                                                    SizedBox(height: 5.h),
                                                                    TextSmall(text: _getController.audioLibraryList.value.data!.result![index].sId!, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: 11.sp),
                                                                  ]
                                                              ))
                                                            ]
                                                          )
                                                      )
                                                  )
                                              )
                                          )
                                        else
                                          Container(
                                            width: Get.width,
                                            height: 120.h,
                                            margin: EdgeInsets.only(top: 15.h, left: 15.sp, right: 15.sp, bottom: 15.h),
                                            padding: EdgeInsets.all(10.sp),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color:AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                                            child: TextSmall(text: 'Audio kitoblar mavjud emas'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 15.sp)),
                                        if (_getController.audioLibraryList.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                                          SizedBox(height: 15.h),
                                        if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                                          ChildItem(title: 'Audio kitoblar'.tr, function: () => Get.to(() => EBookPage(isEbook: false)))
                                        else
                                          SkeletonChildItem(),
                                        if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                                          SizedBox(height: 5.h),
                                        if (_getController.productAudioBookModel.value.data != null && _getController.productAudioBookModel.value.data!.result!.isNotEmpty)
                                          SizedBox(
                                              height: 375.h,
                                              width: Get.width,
                                              child: ListView.builder(
                                                  padding: EdgeInsets.only(left: Get.width * 0.04),
                                                  itemCount: _getController.productAudioBookModel.value.data!.result!.length,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return ProductItem(
                                                        imageUrl: _getController.productAudioBookModel.value.data!.result![index].image,
                                                        title: _getController.productAudioBookModel.value.data!.result![index].name,
                                                        price: _getController.productAudioBookModel.value.data!.result![index].price.toString(),
                                                        productType: _getController.productAudioBookModel.value.data!.result![index].productType,
                                                        function: () {
                                                          _getController.page.value = 1;
                                                          _getController.productModelLength.value = 0;
                                                          _getController.clearProductDetailModel();
                                                          _getController.clearProductDetailList();
                                                          Get.to(() => DetailPage(slug: _getController.productAudioBookModel.value.data!.result![index].slug!, pageIndex: 0));
                                                        },
                                                        id: _getController.productAudioBookModel.value.data!.result![index].sId,
                                                        deck: _getController.productAudioBookModel.value.data!.result![index].name,
                                                        count: _getController.productAudioBookModel.value.data!.result![index].count,
                                                        sale: _getController.productAudioBookModel.value.data!.result![index].sale ?? 0
                                                    );
                                                  }
                                              )
                                          )
                                        else
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
                                      ]
                                    )
                                  ]
                              )
                            )
                          ]
                      )
                  )
                ]
            ))
        )
    );
  }
}
