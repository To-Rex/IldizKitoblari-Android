import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/chashe_image.dart';
import '../../companents/detail_child_item.dart';
import '../../companents/detail_element.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/product_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../resource/component_size.dart';
import '../auth/login_page.dart';
import '../library/ebooks.dart';
import '../shop/audio_page_preview.dart';

class DetailPage extends StatelessWidget {
  final String slug;
  final int pageIndex;

  DetailPage({super.key, required this.slug, required this.pageIndex});

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final GetController _getController = Get.put(GetController());


  @override
  Widget build(BuildContext context) {
    //ApiController().getProductDetail('aldanganlar');
    ApiController().getProductDetail(slug);
    _getController.fullIndex.value = 0;
    return Scaffold(
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const CustomRefreshHeader(),
            footer: const CustomRefreshFooter(),
            onLoading: () async {
              _refreshController.loadComplete();
              },
            onRefresh: () async {
              _getController.fullIndex.value = 0;
              _getController.productDetailList.clear();
              _getController.productRateList.clear();
              ApiController().getProductDetail(slug).then((value) => _refreshController.refreshCompleted());
              },
            controller: _refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(() => _getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex
                    ? Column(
                    children: [
                      AppBar(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () {Navigator.pop(context);}),
                        actions: [
                          IconButton(icon: Icon(TablerIcons.share, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).iconTheme.fill), onPressed: () {}),
                          IconButton(icon: Icon(TablerIcons.bookmark, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).iconTheme.fill), onPressed: () {})],
                      ),
                      if (_getController.productDetailList[pageIndex].data?.images != null)
                        Container(
                          height: Get.height * 0.427,
                          width: Get.width,
                          margin: EdgeInsets.only(top: Get.height * 0.01, left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Swiper(
                            onIndexChanged: (index) {
                              _getController.fullIndex.value = index;
                            },
                            onTap: (index) {
                              Get.to(() => Container(
                                color: Theme.of(context).colorScheme.surface,
                                width: Get.width,
                                height: Get.height,
                                child: PhotoViewGallery(
                                  pageOptions: List.generate(
                                    _getController.productDetailList[pageIndex].data!.images!.isEmpty
                                        ? 1
                                        : _getController.productDetailList[pageIndex].data!.images!.length,
                                        (index) => PhotoViewGalleryPageOptions(
                                        imageProvider: _getController.productDetailList[pageIndex].data!.images!.isEmpty
                                            ? const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png')
                                            : NetworkImage(_getController.productDetailList[pageIndex].data!.images![index].file ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'
                                        ),
                                        initialScale: PhotoViewComputedScale.contained,
                                        heroAttributes: PhotoViewHeroAttributes(tag: index),
                                      ),
                                  ),
                                  backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                                  pageController: PageController(initialPage: _getController.fullIndex.value),
                                ),
                              ));
                            },
                            controller: _getController.swiperController,
                            itemCount: _getController.productDetailList[pageIndex].data!.images!.isEmpty ? 1 : _getController.productDetailList[pageIndex].data!.images!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                    image: _getController.productDetailList[pageIndex].data!.images!.isEmpty ? const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png') : NetworkImage(_getController.productDetailList[pageIndex].data!.images![index].file ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                    fit: BoxFit.cover
                                  )
                                ),
                                /*child: FadeInImage(
                                  image: _getController.productDetailList[pageIndex].data!.images!.isEmpty
                                      ? const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png')
                                      : NetworkImage(_getController.productDetailList[pageIndex].data!.images![index].file ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'
                                  ),
                                  placeholder: const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Container(decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), image: DecorationImage(image: NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover)));
                                  },
                                  fit: BoxFit.cover
                                )*/
                                child: CacheImage(
                                  keys: _getController.productDetailList[pageIndex].data!.images!.isEmpty
                                      ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'
                                      : _getController.productDetailList[pageIndex].data!.images![index].file ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  url: _getController.productDetailList[pageIndex].data!.images!.isEmpty
                                      ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'
                                      : _getController.productDetailList[pageIndex].data!.images![index].file ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                )
                              );
                            }
                          )
                        ),
                      Container(
                        height: Get.height * 0.061,
                        width: Get.width,
                        margin: EdgeInsets.only(top: Get.height * 0.007),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _getController.productDetailList[pageIndex].data?.images?.length ?? 0,
                          itemBuilder: (context, index) {
                            final imageUrl = _getController.productDetailList[pageIndex].data?.images?[index].file ?? '';
                            return InkWell(
                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                              onTap: () {
                                _getController.fullIndex.value = index;
                                _getController.swiperController.move(index);
                              },
                              child: Obx(() => Container(
                                margin: EdgeInsets.only(left: Get.width * 0.03),
                                width: Get.width * 0.14,
                                height: Get.height * 0.06,
                                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(4)), border: _getController.fullIndex.value == index ? Border.all(color: AppColors.primaryColor3, width: 1) : null, image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                                /*child: FadeInImage(
                                  image: NetworkImage(imageUrl),
                                  placeholder: const NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'),
                                  imageErrorBuilder: (context, error, stackTrace) {return Container(decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), image: DecorationImage(image: NetworkImage('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'), fit: BoxFit.cover)));},
                                  fit: BoxFit.cover
                                )*/
                                child: CacheImage(keys: imageUrl, url: imageUrl)
                              ))
                            );
                          }
                        )
                      ),
                      Container(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, top: Get.height * 0.017, bottom: Get.height * 0.03),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextLarge(text: 'uz_UZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.name?.uz ?? '' : 'ru_RU' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.name?.ru ?? '' : 'oz_OZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.name?.oz ?? '' : '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                SizedBox(height: Get.height * 0.018),
                                if (_getController.productDetailList[pageIndex].data != null)
                                  Row(
                                      children: [
                                        if (_getController.productRateList.length > pageIndex)
                                          DetailElement(title: _getController.productRateList[pageIndex].data!.result!.average == null
                                              ? '0.0'
                                              : _getController.productRateList[pageIndex].data!.result!.average.toString().length > 3
                                              ? _getController.productRateList[pageIndex].data!.result!.average.toString().substring(0, 3)
                                              : _getController.productRateList[pageIndex].data!.result!.average.toString(),
                                              subTitle: '', icon: Icons.star),
                                        if (_getController.productRateList.length > pageIndex)
                                          DetailElement(title: _getController.productRateList[pageIndex].data!.result!.total.toString(), subTitle: 'ta izoh'.tr, icon: TablerIcons.message_circle),
                                        DetailElement(title: _getController.productDetailList[pageIndex].data?.views.toString() ?? '', subTitle: 'ta ko‘rilgan'.tr, icon: TablerIcons.eye)
                                      ]
                                  ),
                                if (_getController.productDetailList[pageIndex].data?.ebookPreview?.toString() != '' || _getController.productDetailList[pageIndex].data!.hasAudio == true)
                                InkWell(
                                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                                    onTap: () {_getController.paymentTypeIndex.value = 0;},
                                    child: Container(
                                      height: Get.height * 0.08,
                                      width: Get.width,
                                      margin: EdgeInsets.only(top: Get.height * 0.024),
                                      padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                      decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 0 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2), border: Border.all(color: _getController.paymentTypeIndex.value == 0 ? AppColors.primaryColor3 : AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextSmall(text: 'Qog‘ozli kitob', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                                TextSmall(text: '${_getController.getMoneyFormat(_getController.productDetailList[pageIndex].data?.price)} ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w400)
                                              ]
                                          ),
                                          Icon(TablerIcons.book_2, color: AppColors.primaryColor3, size: 25.sp)
                                        ]
                                      )
                                    )
                                ),
                                if (_getController.productDetailList[pageIndex].data?.ebookPreview?.toString() != '')
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        InkWell(
                                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                                            onTap: () {
                                              _getController.paymentTypeIndex.value = 1;
                                            },
                                            child: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width * 0.45,
                                                margin: EdgeInsets.only(top: Get.height * 0.012),
                                                padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                                decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 1 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2), border: Border.all(color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor3 : AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          width: Get.width * 0.32,
                                                          child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                TextSmall(text: 'Elektron kitob', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                                                TextSmall(text: '${_getController.getMoneyFormat(_getController.productDetailList[pageIndex].data?.ebookPrice)} ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w400)
                                                              ]
                                                          )
                                                      ),
                                                      Icon(TablerIcons.book, color: AppColors.primaryColor3, size: 25.sp)
                                                    ]
                                                )
                                            )
                                        ),
                                        InkWell(
                                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                                            onTap: () {
                                              _getController.whileApi.value = false;
                                              _getController.fontSize.value = Get.height * 0.017;
                                              //_openEpubReader(context, 'https://github.com/Mamasodikov/cosmos_epub/raw/refs/heads/master/example/assets/book.epub').then((value) => Get.back());
                                              //_openEpubReader(context, 'https://github.com/ikrukov/epub/raw/refs/heads/master/books/GNU%20make/make.epub').then((value) => Get.back());
                                              //_openEpubReader(context, _getController.productDetailList[pageIndex].data!.ebookPreview.toString()).then((value) => Get.back());

                                              Get.to(EpubReaderPage(epubUrl: _getController.productDetailList[pageIndex].data!.ebookPreview.toString()));

                                            },
                                            child: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width * 0.45,
                                                margin: EdgeInsets.only(top: Get.height * 0.012),
                                                padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                                decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2), border: Border.all(color: AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      TextSmall(text: 'Fragmentni o‘qish', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)
                                                    ]
                                                )
                                            )
                                        )
                                    ]
                                ),
                                if (_getController.productDetailList[pageIndex].data!.hasAudio == true)
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                                            onTap: () {
                                              _getController.paymentTypeIndex.value = 2;
                                              },
                                            child: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width * 0.45,
                                                margin: EdgeInsets.only(top: Get.height * 0.012),
                                                padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                                decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 2 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2), border: Border.all(color: _getController.paymentTypeIndex.value == 2 ? AppColors.primaryColor3 : AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            TextSmall(text: 'Audio kitob', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                                                            //TextSmall(text: '${_getController.productDetailList[pageIndex].data?.audioPrice.toString() == 'null' ? 0 : _getController.productDetailList[pageIndex].data?.audioPrice.toString() } ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w400)
                                                            TextSmall(text: '${_getController.productDetailList[pageIndex].data?.audioPrice.toString() == 'null' ? 0 : _getController.getMoneyFormat(_getController.productDetailList[pageIndex].data?.audioPrice) } ${'so‘m'.tr}', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w400)
                                                          ]
                                                      ),
                                                      Icon(TablerIcons.headphones, color: AppColors.primaryColor3, size: 25.sp)
                                                    ]
                                                )
                                            )
                                        ),
                                        InkWell(
                                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                                            onTap: () {
                                              Get.to(() => AudioPagePreview(
                                                sId: _getController.productDetailList[pageIndex].data!.sId!,
                                                title: _getController.productDetailList[pageIndex].data!.name!.uz!,
                                              ));
                                              },
                                            child: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width * 0.45,
                                                margin: EdgeInsets.only(top: Get.height * 0.012),
                                                padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                                decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2), border: Border.all(color: AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      TextSmall(text: 'Fragmentni eshitish', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)
                                                    ]
                                                )
                                            )
                                        )
                                      ]
                                  )
                              ]
                          )
                      ),
                      DetailChildItem(title: 'Tafsilotlar'.tr, function: (){}, check: false),
                      Container(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.005),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height * 0.02),
                                if (_getController.productDetailList[pageIndex].data?.options != null)
                                  for (int i = 0; i < _getController.productDetailList[pageIndex].data!.options!.length; i++)
                                    Container(
                                        width: Get.width, margin: EdgeInsets.only(bottom: Get.height * 0.013),
                                        child: Row(
                                            children: [
                                              LimitedBox(maxWidth: Get.width * 0.25, child: TextSmall(text: 'uz_UZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.uz ?? '' : 'ru_RU' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.ru ?? '' : 'oz_OZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.oz ?? '' : '', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w500)),
                                              Expanded(child: TextSmall(text: '  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  ', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w400,overflow: TextOverflow.fade)),
                                              LimitedBox(maxWidth: Get.width * 0.7, child: TextSmall(text: 'uz_UZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.uz ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : 'ru_RU' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.ru ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : 'oz_OZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.oz ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500))
                                            ]
                                        )
                                    ),
                                SizedBox(height: Get.height * 0.02)
                              ]
                          )
                      ),
                      if ('uz_UZ' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.uz != '' || 'ru_RU' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.ru != '' || 'oz_OZ' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.oz != '')
                        DetailChildItem(title: 'Tavsif'.tr, function: (){}, check: false),
                      Container(padding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
                          child: Column(
                            children: [
                              if ('uz_UZ' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.uz != '' || 'ru_RU' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.ru != '' || 'oz_OZ' == _getController.getLocale() && _getController.productDetailList[pageIndex].data?.content?.oz != '')
                                Html(
                                  style: {
                                    'p': Style(
                                        textDecorationColor: Theme.of(context).colorScheme.error,
                                        padding: HtmlPaddings.symmetric(vertical: 0, horizontal: 0),
                                        fontSize: FontSize(ComponentSize.textSmall(context)!), fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onSurface
                                    )
                                  },
                                  data: 'uz_UZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.content?.uz ?? '' : 'ru_RU' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.content?.ru ?? '' : 'oz_UZ' == _getController.getLocale() ? _getController.productDetailList[pageIndex].data?.content?.oz ?? '' : '',)
                            ]
                        )
                    ),
                    DetailChildItem(title: 'Tavsiya etiladi'.tr, function: (){}, check: false),
                    Container(
                      height: 375.h,
                      width: Get.width,
                      margin: EdgeInsets.only(top: Get.height * 0.008),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: Get.width * 0.03),
                        itemCount: _getController.productDetailList[pageIndex].data?.simularProducts!.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            id: _getController.productDetailList[pageIndex].data?.simularProducts![index].slug ?? '',
                            title: _getController.productDetailList[pageIndex].data?.simularProducts![index].name ?? '',
                            deck: _getController.productDetailList[pageIndex].data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                            price: _getController.productDetailList[pageIndex].data?.simularProducts![index].price.toString() ?? '',
                            imageUrl: _getController.productDetailList[pageIndex].data?.simularProducts![index].image ?? '',
                            function: () {
                              _getController.fullIndex.value = 0;
                              _getController.swiperController.move(0);
                              _getController.removeProductDetailModel(pageIndex+1);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(slug: _getController.productDetailList[pageIndex].data?.simularProducts![index].slug ?? '', pageIndex: pageIndex+1)));
                            }, count: _getController.productDetailList[pageIndex].data?.simularProducts![index].count ?? 0,
                            sale: _getController.productDetailList[pageIndex].data?.simularProducts![index].sale ?? 0
                          );
                        }
                      )
                    ),
                    DetailChildItem(title: 'Sizning fikringiz'.tr, function: (){}, check: false),
                      Container(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03, bottom: Get.height * 0.025),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * 0.015),
                              if (_getController.productRateList.length > pageIndex)
                                TextSmall(text: 'Baholang', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
                              if (_getController.productRateList.length > pageIndex)
                                SizedBox(height: Get.height * 0.008),
                              if (_getController.productRateList.length > pageIndex)
                                RatingBar.builder(
                                    initialRating: _getController.productRateList[pageIndex].data!.result!.average == null ? 0 : double.parse(_getController.productRateList[pageIndex].data!.result!.average.toString()),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: ComponentSize.starIcons(context),
                                    itemPadding: EdgeInsets.symmetric(horizontal: 5.sp),
                                    unratedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                    itemBuilder: (context, _) =>
                                    const Icon(TablerIcons.star_filled, color: AppColors.primaryColor),
                                    onRatingUpdate: (rating) {
                                      _getController.ratingController.text = rating.toString();
                                    }
                                ),
                              SizedBox(height: Get.height * 0.02),
                              TextSmall(text: '${'Izoh'.tr}:', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500),
                              SizedBox(height: Get.height * 0.01),
                              Container(
                                  width: Get.width,
                                  padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1)),
                                  child: TextField(minLines: 1, maxLines: 3, controller: _getController.commentController, style: TextStyle(fontSize: ComponentSize.textSmall(context), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface), decoration: InputDecoration(hintText: 'Kiriting'.tr, labelStyle: TextStyle(fontSize: ComponentSize.textSmall(context), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)), hintStyle: TextStyle(fontSize: ComponentSize.textSmall(context), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)), border: InputBorder.none))
                              ),
                              SizedBox(height: Get.height * 0.02),
                              SizedBox(width: Get.width, child: ElevatedButton(onPressed: () {
                                        if (_getController.commentController.text.isEmpty) {
                                          ApiController().showToast(context, 'Xatolik', 'Ma‘lumotlar yo‘q!', true, 3);
                                        } else {
                                          ApiController().createComment(
                                              _getController.commentController.text,
                                              _getController.productDetailList[pageIndex].data!.sId.toString(),
                                              _getController.ratingController.text
                                          ).then((value) => {
                                            _getController.fullIndex.value = 0,
                                            _getController.productDetailList.clear(),
                                            _getController.productRateList.clear(),
                                            ApiController().getProductDetail(slug)
                                          });
                                        }
                                      }, style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Get.height * 0.016), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: TextSmall(text: 'Jo‘natish', color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold)))
                            ]
                        )
                    ),
                    DetailChildItem(title: 'Izohlar'.tr, function: (){}, check: true),
                    _getController.productDetailList[pageIndex].data!.comments!.isNotEmpty
                        ? Container(padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                        child: Column(
                          children: [
                            for (int i = 0; i < _getController.productDetailList[pageIndex].data!.comments!.length; i++)
                              Container(
                                  margin: EdgeInsets.only(bottom: Get.height * 0.02),
                                  padding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02, top: Get.height * 0.01, bottom: Get.height * 0.01),
                                  decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1)),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            if (_getController.productDetailList[pageIndex].data?.comments![i].user?.avatar != '')
                                              Container(
                                                  width: Get.width * 0.12,
                                                  height: Get.width * 0.12,
                                                  margin: EdgeInsets.only(right: Get.width * 0.03),
                                                  decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(_getController.productDetailList[pageIndex].data?.comments![i].user?.avatar ?? '',), fit: BoxFit.cover))
                                              )
                                            else
                                              Container(
                                                width: Get.width * 0.12,
                                                height: Get.width * 0.12,
                                                margin: EdgeInsets.only(right: Get.width * 0.03),
                                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                                                child: Icon(Icons.person, color: Theme.of(context).colorScheme.surface, size: Get.width * 0.06)
                                              ),
                                            SizedBox(
                                              width: Get.width * 0.6,
                                              child: TextSmall(text: _getController.productDetailList[pageIndex].data?.comments![i].user?.fullName ?? '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500,maxLines: 100)
                                            )
                                          ]
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: Get.width * 0.32,
                                                  child: RatingBar.builder(
                                                      initialRating: _getController.productDetailList[pageIndex].data?.comments![i].rate?.toDouble() ?? 0,
                                                      minRating: 0,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: Get.width * 0.06,
                                                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                                      onRatingUpdate: (rating) {}
                                                  )
                                              ),
                                              TextSmall(text: DateTime.parse(_getController.productDetailList[pageIndex].data?.comments![i].createdAt ?? '').toString().substring(0, 10), color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w500,maxLines: 100,)
                                            ]
                                        ),
                                        SizedBox(height: Get.height * 0.01),
                                        TextSmall(text: _getController.productDetailList[pageIndex].data?.comments![i].description ?? '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500,maxLines: 300)
                                      ]
                                  )
                              )
                          ]))
                        : Container(
                        width: Get.width,
                        padding: EdgeInsets.only(top: Get.height * 0.025, bottom: Get.height * 0.025),
                        margin: EdgeInsets.only(top: Get.height * 0.015,left: Get.width * 0.03, right: Get.width * 0.03),
                        decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(TablerIcons.message_circle_cancel, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), size: ComponentSize.starIcons(context)),
                              TextSmall(text: 'Izohlar yo‘q', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w500)
                            ]
                        )
                    ),
                    SizedBox(height: Get.height * 0.214)
                  ]
              )
                  : Column(children: [
                    AppBar(
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {Navigator.pop(context);}),
                      actions: [
                        IconButton(icon: Icon(TablerIcons.share, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {}),
                        IconButton(icon: Icon(TablerIcons.bookmark, color: Theme.of(context).colorScheme.onSurface, size: ComponentSize.backIcons(context)), onPressed: () {})]
                    ),
                Skeletonizer(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: Get.width,
                              height: Get.height * 0.427,
                              margin: EdgeInsets.only(top: Get.height * 0.015,left: Get.width * 0.03, right: Get.width * 0.03),
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), image: DecorationImage(image: NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740'), fit: BoxFit.cover))),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: Get.width * 0.03),
                                  width: Get.width * 0.14,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1),
                                      image: const DecorationImage(image:NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740'), fit: BoxFit.cover)
                                  )
                              )
                            ]
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Container(padding: EdgeInsets.only(left: Get.width * 0.03), child: TextSmall(text: 'hello'.tr, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold))
                        ]
                    )
                )
              ]))
          )
        ),
        //category.shopProductModel!.data!.result![index].sId,
        bottomNavigationBar: BottomAppBar(
          height: 70.h,
          surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.surface,
          child: Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                  Expanded(child: _getController.productDetailList[pageIndex].data != null
                      ? TextLarge(
                      text: '${_getController.getMoneyFormat('${_getController.paymentTypeIndex.value == 0 ? _getController.productDetailList[pageIndex].data!.price : _getController.paymentTypeIndex.value == 1 ? _getController.productDetailList[pageIndex].data?.ebookPrice.toString() : _getController.productDetailList[pageIndex].data?.audioPrice.toString()}')} ${'so‘m'.tr}',
                      color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold,fontSize: 20.sp)
                      : const SizedBox())
                else
                  Expanded(
                      child: Skeletonizer(
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.surface),
                          child: TextSmall(text: 'hello', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                        )
                      )
                  ),
                if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                  SizedBox(
                    width: Get.width * 0.35,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_getController.meModel.value.data != null) {
                            if (_getController.paymentTypeIndex.value == 0){
                              ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'active', 'book').then((value) => _getController.index.value = 3);
                            } else if (_getController.paymentTypeIndex.value == 1){
                              ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'ebook', 'ebook').then((value) => _getController.index.value = 3);
                            } else if (_getController.paymentTypeIndex.value == 2){
                              ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'audio', 'audio').then((value) => _getController.index.value = 3);
                            }
                            Get.back();
                          }
                          else {Get.to(LoginPage());}
                        },
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 10.h), backgroundColor: AppColors.primaryColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: TextSmall(text: 'Xarid', color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 15.sp)
                    )
                  )
                else
                  SizedBox(
                    width: Get.width * 0.35,
                    child: Skeletonizer(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Get.height * 0.013), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: TextSmall(text: 'Xarid', color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold)
                      )
                    )
                  ),
                SizedBox(width: Get.width * 0.02),
                if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                  IconButton(
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.width * 0.02), backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      icon: Icon(TablerIcons.shopping_bag, color: Theme.of(context).colorScheme.surface, size: ComponentSize.starIcons(context)),
                      onPressed: () {
                        if (_getController.meModel.value.data != null) {
                          if (_getController.paymentTypeIndex.value == 0){
                            ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'active', 'book');
                          } else if (_getController.paymentTypeIndex.value == 1){
                            ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'ebook', 'ebook');
                          } else if (_getController.paymentTypeIndex.value == 2){
                            ApiController().addToBasket('1', _getController.productDetailList[pageIndex].data!.sId.toString(),'audio', 'audio');
                          }
                          Get.back();
                        }
                        else {Get.to(LoginPage());}
                      }
                  )
                else
                  Skeletonizer(
                    child:SizedBox(
                        width: Get.width * 0.13,
                        child: IconButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: Get.height * 0.017), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            icon: Icon(TablerIcons.shopping_bag, color: Theme.of(context).colorScheme.surface, size: ComponentSize.starIcons(context)),
                            onPressed: () {}
                        )
                    )
                  )
              ]
          ))
        )
    );
  }
}