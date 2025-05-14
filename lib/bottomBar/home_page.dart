import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/appbar/custom_header.dart';
import '../companents/author_item.dart';
import '../companents/chashe_image.dart';
import '../companents/child_item.dart';
import '../companents/filds/text_small.dart';
import '../companents/product_item.dart';
import '../companents/scleton_item.dart';
import '../companents/search_fild.dart';
import '../companents/skleton_child_item.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../pages/home/author_category.dart';
import '../pages/home/author_detail.dart';
import '../pages/home/cat_detail_page.dart';
import '../pages/home/category.dart';
import '../pages/home/category_page.dart';
import '../pages/home/detail_page.dart';
import '../pages/library/e_book_page.dart';
import '../resource/colors.dart';

class HomePage extends StatelessWidget {

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  HomePage({super.key});

  void _getData() {
    ApiController().getQuotation(1);
    ApiController().getTopProduct(1,false,_getController.searchController.text);
    ApiController().getAuthors(30,1,_getController.searchController.text,false);
    ApiController().getBook();
    ApiController().getAudio();
  }

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner(1,1);
    ApiController().getQuotation(1);
    ApiController().getTopProduct(1,false,'');
    ApiController().getAuthors(30,1,'',false);
    ApiController().getBook();
    ApiController().getAudio();
    _getController.scrollController.addListener(() {
      if (_getController.scrollController.position.userScrollDirection != ScrollDirection.idle) {
        Get.focusScope!.unfocus();
      }
    });

    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const CustomRefreshHeader(),
        footer: const CustomRefreshFooter(),
        onLoading: () async {_refreshController.loadComplete();},
        onRefresh: () async {_refreshController.refreshCompleted();},
        controller: _refreshController,
        scrollController: _getController.scrollController,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 50.h),
                      child:  SearchFields(onChanged: (String value) {
                        if (value.isEmpty && _getController.searchController.text == '') {
                          _getData();
                        }
                        if (value.isNotEmpty && _getController.menuModel.value.data != null && value.length >= 3 ) {
                          _getController.changeItemPage(0);
                          _getData();
                        }}
                      )
                  ),
                  Container(
                      width: Get.width,
                      constraints: BoxConstraints(
                          minHeight: Get.height * 0.5
                      ),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                      child: Column(
                          children: [
                            if (_getController.bannerModel.value.data != null)
                              Container(
                                  margin: EdgeInsets.only(top: 18.h, bottom: 25.h),
                                  height: Get.height * 0.17,
                                  width: Get.width,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Theme.of(context).colorScheme.surface),
                                  child: CarouselSlider(
                                      options: CarouselOptions(
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          autoPlayInterval: const Duration(seconds: 5),
                                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: true,
                                          scrollDirection: Axis.horizontal
                                      ),
                                      items: [
                                        for (var i in _getController.bannerModel.value.data!.result!)
                                          if ('uz_UZ' == _getController.getLocale() && i.imageUz != '')
                                            InkWell(
                                                onTap: () {
                                                  _getController.page.value = 1;
                                                  _getController.productModelLength.value = 0;
                                                  _getController.clearProductDetailModel();
                                                  _getController.clearProductDetailList();
                                                  Get.to(() => DetailPage(
                                                    slug: _getController.bannerModel.value.data!.result![_getController.bannerModel.value.data!.result!.indexOf(i)].product!.slug!,
                                                    pageIndex: 0,
                                                  ));
                                                },
                                                child: Container(
                                                    width: Get.width * 0.93,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFE8E8E8)),
                                                    child: CacheImage(radius: 16, keys: i.imageUz ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png', url: i.imageUz ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png', fit: BoxFit.fill)
                                                )
                                            )
                                          else if ('oz_OZ' == _getController.getLocale() && i.imageOz != '')
                                            InkWell(
                                                onTap: () {
                                                  _getController.page.value = 1;
                                                  _getController.productModelLength.value = 0;
                                                  _getController.clearProductDetailModel();
                                                  _getController.clearProductDetailList();
                                                  Get.to(() => DetailPage(
                                                    slug: _getController.bannerModel.value.data!.result![_getController.bannerModel.value.data!.result!.indexOf(i)].product!.slug!,
                                                    pageIndex: 0,
                                                  ));
                                                },
                                                child: Container(
                                                    width: Get.width * 0.93,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFFE8E8E8)),
                                                    child: CacheImage(
                                                        radius: 16,
                                                        keys: i.imageOz ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                                        url: i.imageOz ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                                        fit: BoxFit.fill
                                                    )
                                                )
                                            )
                                          else if ('ru_RU' == _getController.getLocale() && i.imageRu != '')
                                              InkWell(
                                                  onTap: () {
                                                    _getController.page.value = 1;
                                                    _getController.productModelLength.value = 0;
                                                    _getController.clearProductDetailModel();
                                                    _getController.clearProductDetailList();
                                                    Get.to(() => DetailPage(
                                                      slug: _getController.bannerModel.value.data!.result![_getController.bannerModel.value.data!.result!.indexOf(i)].product!.slug!,
                                                      pageIndex: 0,
                                                    ));
                                                  },
                                                  child: Container(
                                                      width: Get.width * 0.93,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(16),
                                                        color: const Color(0xFFE8E8E8),
                                                        //image: DecorationImage(image: NetworkImage(i.imageRu ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.fill)
                                                      ),
                                                      child: CacheImage(
                                                          radius: 16,
                                                          keys: i.imageRu ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                                          url: i.imageRu ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                                          fit: BoxFit.fill
                                                      )
                                                  )
                                              )
                                      ]
                                  )
                              )
                            else
                              Container(
                                  margin: EdgeInsets.only(top: 18.h, bottom: 5.h),
                                  height: Get.height * 0.173,
                                  width: Get.width,
                                  padding: EdgeInsets.all(Get.width * 0.02),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                  child: Skeletonizer(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), image: const DecorationImage(image: AssetImage('assets/images/oo1.png'), fit: BoxFit.fill))))
                              ),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(
                                  title: _getController.fullCheck.value == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya'.tr,
                                  function: (){
                                    Get.to(() => Category());
                                  })
                            else
                              SkeletonChildItem(),
                            if (_getController.menuModel.value.data != null)
                              Container(
                                  width: Get.width,
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.01),
                                  child: Wrap(
                                      spacing: Get.width * 0.02,
                                      runSpacing: Get.height * 0.006,
                                      children: [
                                        for (var i in _getController.menuModel.value.data!.result!)
                                          InkWell(
                                              onTap: () {
                                                if (i.children == null) {
                                                  Get.to(() => CatDetailPage(
                                                    title: 'uz_UZ' == _getController.getLocale() ? i.title!.uz! : 'oz_OZ' == _getController.getLocale() ? i.title!.oz! : i.title!.ru!,
                                                    menuSlug: i.slug!,
                                                    parent: false,
                                                    menuIndex: _getController.menuModel.value.data!.result!.indexOf(i),
                                                  ));
                                                }else {
                                                  Get.to(() => CategoryPage(menuIndex: _getController.menuModel.value.data!.result!.indexOf(i)));
                                                }
                                              },
                                              child: Chip(
                                                  visualDensity: VisualDensity.compact,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                                  label: Text('uz_UZ' == _getController.getLocale() ? i.title!.uz! : 'oz_OZ' == _getController.getLocale() ? i.title!.oz! : i.title!.ru!),
                                                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                                                  labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                                  side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),
                                                  backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                                              )
                                          )
                                      ]
                                  )
                              )
                            else
                              Container(
                                  width: Get.width,
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.01),
                                  child: Wrap(
                                      spacing: Get.width * 0.02,
                                      runSpacing: Get.height * 0.006,
                                      children: [
                                        for (int i = 0; i < 10; i++)
                                          Skeletonizer(
                                              child: Chip(
                                                  visualDensity: VisualDensity.compact,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                                  label: Text('salom${i *  Random().nextInt(11)}'),
                                                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                                                  labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                                  side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 0),
                                                  backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w400)
                                              )
                                          )
                                      ]
                                  )
                              ),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty && _getController.productModel.value.data!.result!.length > 3)
                              SizedBox(height: Get.height * 0.026),
                            if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Do‘kon mahsulotlari'.tr, function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                  title: 'Kitoblar'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                  parent: true,
                                  menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![0]),
                                ));
                                /*_getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                //_getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                    title: 'Do‘kon mahsulotlari'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                    parent: true, menuIndex: 0
                                ));*/
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              SizedBox(
                                  height: 375.h,
                                  width: Get.width,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(left: Get.width * 0.04),
                                      itemCount: _getController.productModel.value.data!.result!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => ProductItem(
                                          imageUrl: _getController.productModel.value.data!.result![index].image,
                                          title: _getController.productModel.value.data!.result![index].name,
                                          price: _getController.productModel.value.data!.result![index].price.toString(),
                                          function: () {
                                            _getController.page.value = 1;
                                            _getController.productModelLength.value = 0;
                                            _getController.clearProductDetailModel();
                                            _getController.clearProductDetailList();
                                            Get.to(() => DetailPage(
                                                slug: _getController.productModel.value.data!.result![index].slug!,
                                                pageIndex: 0
                                            ));
                                          },
                                          id: _getController.productModel.value.data!.result![index].sId,
                                          deck: _getController.productModel.value.data!.result![index].name,
                                          count: _getController.productModel.value.data!.result![index].count,
                                          sale: _getController.productModel.value.data!.result![index].sale
                                      ))
                              ),
                            if (_getController.productEBookModel.value.data != null && _getController.productEBookModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Elektron kitoblar'.tr, function: () => Get.to(() => EBookPage())),
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
                            else if (_getController.productEBookModel.value.data == null)
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
                              ),
                            if (_getController.productAudioBookModel.value.data != null && _getController.productAudioBookModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Audio kitoblar'.tr, function: () => Get.to(() => EBookPage(isEbook: false))),
                            if (_getController.productAudioBookModel.value.data != null && _getController.productAudioBookModel.value.data!.result!.isNotEmpty)
                              SizedBox(
                                  height: 375.h,
                                  width: Get.width,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(left: Get.width * 0.04),
                                      itemCount: _getController.productAudioBookModel.value.data!.result!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => ProductItem(
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
                                      )
                                  )
                              )
                            else if (_getController.productAudioBookModel.value.data == null)
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
                              ),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(height: Get.height * 0.02),
                            if (_getController.quotesModel.value.data != null && _getController.quotesModel.value.data!.result!.isNotEmpty && _getController.searchController.text.length < 3)
                              ChildItem(title: 'Iqtiboslar'.tr, function: (){}),
                            if (_getController.quotesModel.value.data != null && _getController.quotesModel.value.data!.result!.isNotEmpty && _getController.searchController.text.length < 3)
                              Container(
                                  height: Get.height * 0.23,
                                  margin: EdgeInsets.only(top: Get.height * 0.01, bottom: Get.height * 0.02),
                                  width: Get.width,
                                  child: Swiper(
                                      itemCount: _getController.quotesModel.value.data != null ? _getController.quotesModel.value.data!.result!.length : 0,
                                      loop: true,
                                      layout: SwiperLayout.STACK,
                                      itemHeight: Get.height * 0.3,
                                      itemWidth: Get.width * 0.93,
                                      containerHeight: Get.height * 0.3,
                                      containerWidth: Get.width * 0.93,
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      axisDirection: AxisDirection.right,
                                      curve: Curves.decelerate,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: EdgeInsets.only(left: Get.width * 0.01,right: Get.width * 0.01),
                                            width: Get.width,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.surface, border: Border.all(color: AppColors.grey, width: 0.9)),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: Get.width * 0.03, top: Get.height * 0.01),
                                                    child: Text('uz_UZ' == _getController.getLocale() ? _getController.quotesModel.value.data!.result![index].name!.uz! : 'oz_OZ' == _getController.getLocale() ? _getController.quotesModel.value.data!.result![index].name!.oz! : _getController.quotesModel.value.data!.result![index].name!.ru!, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 17.sp, fontWeight: FontWeight.w600)),
                                                  ),
                                                  const Expanded(child: SizedBox()),
                                                  if (_getController.quotesModel.value.data!.result![index].product != null && _getController.quotesModel.value.data!.result![index].product!.name != null)
                                                    Padding(
                                                      padding: EdgeInsets.only(left: Get.width * 0.03, top: Get.height * 0.01,bottom: Get.height * 0.01),
                                                      child: Text('uz_UZ' == _getController.getLocale() ? _getController.quotesModel.value.data!.result![index].product!.name!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.quotesModel.value.data!.result![index].product!.name!.oz! : _getController.quotesModel.value.data!.result![index].product!.name!.ru!, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                                                    )
                                                ]
                                            )
                                        );
                                      })
                              ),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Mualliflar'.tr, function: (){
                                _getController.clearAuthorModel();
                                Get.to(() => AuthorCategory());
                              }),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              SizedBox(height: Get.height * 0.01),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              for (int i = 0; i < _getController.authorModel.value.data!.result!.length; i++)
                                if (i < 3)
                                  AuthorItem(
                                      sId: _getController.authorModel.value.data!.result![i].sId.toString(),
                                      title: 'uz_UZ' == _getController.getLocale() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(),
                                      subTitle: _getController.authorModel.value.data!.result![i].productCount!.toString(),
                                      image: _getController.authorModel.value.data!.result![i].image!.toString(),
                                      onTap: () {
                                        debugPrint(_getController.authorModel.value.data!.result![i].name!.uz.toString());
                                        _getController.clearAuthorDetailList();
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetail(title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(), sId: _getController.authorModel.value.data!.result![i].sId.toString(), index: 0)));
                                        Get.to(
                                                () => AuthorDetail(
                                                sId: _getController.authorModel.value.data!.result![i].sId.toString(),
                                                title: 'uz_UZ' == _getController.getLocale() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(),
                                                index: 0
                                            )
                                        );
                                      },
                                      index: 0
                                  ),
                            if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              SizedBox(height: Get.height * 0.015),
                            if (_getController.menuModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: '${'Top'.tr} ${'Kitoblar'.tr}', function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                    title: 'Kitoblar'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                    parent: true,
                                    menuIndex: 0
                                ));
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              InkWell(
                                  onTap: () {
                                    _getController.page.value = 1;
                                    _getController.productModelLength.value = 0;
                                    _getController.clearProductDetailModel();
                                    _getController.clearProductDetailList();
                                    Get.to(() => DetailPage(slug: _getController.productModel.value.data!.result![0].slug!, pageIndex: 0));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 8.h, bottom: 15.h, left: Get.width * 0.03, right: Get.width * 0.03),
                                      height: Get.height * 0.158,
                                      width: Get.width,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.onSurface),
                                      child: Stack(
                                          children: [
                                            Positioned(
                                                left: 0,
                                                width: Get.width * 0.6,
                                                height: Get.height * 0.158,
                                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)), color: AppColors.primaryColor))
                                            ),
                                            Positioned(
                                                right: 0,
                                                width: Get.width * 0.42,
                                                height: Get.height * 0.158,
                                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)), image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![0].image ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover)),
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
                                                        child: FadeInImage(
                                                            image: NetworkImage(_getController.productModel.value.data!.result![0].image ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                                            placeholder: const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                                            imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: BoxDecoration(image: const DecorationImage(image: NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover), borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r))));},
                                                            fit: BoxFit.cover
                                                        )
                                                    )
                                                )
                                            ),
                                            Positioned(
                                              left: Get.width * 0.47,
                                              width: Get.width * 0.1,
                                              height: Get.height * 0.158,
                                              child: Image.asset('assets/images/rectangle.png', fit: BoxFit.fill),
                                            ),
                                            Positioned(
                                                width: Get.width * 0.96,
                                                height: Get.height * 0.158,
                                                child: Center(
                                                    child: Container(
                                                        margin: EdgeInsets.only(left: Get.width * 0.08),
                                                        decoration: BoxDecoration(image: DecorationImage(image: Image.asset('assets/images/frame.png').image, fit: BoxFit.none)),
                                                        child: Center(child: Text('1', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.element)))
                                                    )
                                                )
                                            ),
                                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                                              Positioned(
                                                  left: Get.width * 0.03,
                                                  height: Get.height * 0.158,
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 20.h),
                                                        SizedBox(width: Get.width * 0.44, child: Text(maxLines: 1, overflow: TextOverflow.ellipsis, _getController.productModel.value.data!.result![0].name!, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white)))
                                                      ]
                                                  )
                                              )
                                          ]
                                      )
                                  )
                              ),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty && _getController.productModel.value.data!.result!.length > 3)
                              for (var i in _getController.productModel.value.data!.result!.sublist(1, 3))
                                InkWell(
                                    onTap: () {
                                      _getController.page.value = 1;
                                      _getController.productModelLength.value = 0;
                                      _getController.clearProductDetailModel();
                                      _getController.clearProductDetailList();
                                      Get.to(() => DetailPage(
                                          slug: _getController.productModel.value.data!.result![_getController.productModel.value.data!.result!.indexOf(i)].slug!,
                                          pageIndex: 0
                                      ));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: Get.width * 0.03,
                                            right: Get.width * 0.03,
                                            bottom: Get.height * 0.015),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.surface, boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), offset: const Offset(1, 2), blurRadius: 3, spreadRadius: 1)]),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            if (i.image != null)
                                              SizedBox(
                                                  width: Get.width * 0.2,
                                                  height: Get.height * 0.095,
                                                  child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          width: Get.width * 0.2,
                                                          height: Get.height * 0.09,
                                                          child: SizedBox(
                                                              width: Get.width * 0.2,
                                                              height: Get.height * 0.09,
                                                              child: Image.asset('assets/images/rectangle.png', fit: BoxFit.none)
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            width: Get.width * 0.2,
                                                            height: Get.height * 0.09,
                                                            child: Center(
                                                                child: Container(
                                                                    padding: EdgeInsets.all(Get.height * 0.01),
                                                                    child: Image.asset('assets/images/frame.png', fit: BoxFit.cover)
                                                                )
                                                            )
                                                        ),
                                                        Positioned(
                                                            width: Get.width * 0.2,
                                                            height: Get.height * 0.086,
                                                            //child: Center(child: Text('${_getController.productModel.value.data!.result!.indexOf(i) + 1}', style: TextStyle(fontSize: Get.width * 0.03, fontWeight: FontWeight.w600, color: AppColors.element)))
                                                            child: Center(child: TextSmall(text: '${_getController.productModel.value.data!.result!.indexOf(i) + 1}', color: AppColors.element, fontSize: 13.sp, fontWeight: FontWeight.w600))
                                                        )
                                                      ]
                                                  )
                                              ),
                                            Expanded(
                                              child: Text(
                                                  i.name.toString(),
                                                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                            )
                                          ],
                                        )
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