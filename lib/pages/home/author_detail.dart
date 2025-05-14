import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/author_item.dart';
import '../../companents/child_item.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../companents/product_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'author_category.dart';
import 'detail_page.dart';

class AuthorDetail extends StatelessWidget {
  final String sId;
  final String title;
  final int index;
  AuthorDetail({super.key, required this.sId, required this.index, required this.title});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (index == 0) _getController.clearAuthorDetailList();
    ApiController().getAuthorDetail(sId);
                                    //limit,page,search,add,id
    debugPrint('sId: $sId');
    ApiController().getAuthorsProducts(3, 1, '', false, sId);
    return Scaffold(
      appBar: AppBar(
          title: TextScroll(
              title,
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
              fadedBorder: false,
              textDirection: TextDirection.ltr,
              mode: TextScrollMode.endless,
              pauseBetween: const Duration(milliseconds: 7000),
              selectable: true,
              delayBefore: const Duration(milliseconds: 7000)
          ),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp),
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
          },
          controller: _refreshController,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() => _getController.authorDetailModelList.isNotEmpty
                  ? Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    if (_getController.authorDetailModelList[index].data!.image == null || _getController.authorDetailModelList[index].data!.image == '' || _getController.authorDetailModelList[index].data!.image == ' ')
                      Center(
                          child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: AppColors.grey,
                              //child: TextLarge(text: _getController.authorDetailModelList[index].data!.name!.uz!.contains(' ') ? _getController.authorDetailModelList[index].data!.name!.uz!.split(' ')[0].substring(0,1) + _getController.authorDetailModelList[index].data!.name!.uz!.split(' ')[1].substring(0,1) : _getController.authorDetailModelList[index].data!.name!.uz!.isNotEmpty ? _getController.authorDetailModelList[index].data!.name!.uz!.substring(0,1) : '😶', color: Theme.of(context).colorScheme.surface, fontSize: Get.width * 0.06, fontWeight: FontWeight.bold )
                              child: TextLarge(text: 'uz_UZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.name!.uz!.contains(' ') ? _getController.authorDetailModelList[index].data!.name!.uz!.split(' ')[0].substring(0,1) + _getController.authorDetailModelList[index].data!.name!.uz!.split(' ')[1].substring(0,1) : _getController.authorDetailModelList[index].data!.name!.uz!.isNotEmpty ? _getController.authorDetailModelList[index].data!.name!.uz!.substring(0,1) : 'M' : 'oz_OZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.name!.oz!.contains(' ') ? _getController.authorDetailModelList[index].data!.name!.oz!.split(' ')[0].substring(0,1) + _getController.authorDetailModelList[index].data!.name!.oz!.split(' ')[1].substring(0,1) : _getController.authorDetailModelList[index].data!.name!.oz!.isNotEmpty ? _getController.authorDetailModelList[index].data!.name!.oz!.substring(0,1) : 'm' : _getController.authorDetailModelList[index].data!.name!.ru!.contains(' ') ? _getController.authorDetailModelList[index].data!.name!.ru!.split(' ')[0].substring(0,1) + _getController.authorDetailModelList[index].data!.name!.ru!.split(' ')[1].substring(0,1) : _getController.authorDetailModelList[index].data!.name!.ru!.isNotEmpty ? _getController.authorDetailModelList[index].data!.name!.ru!.substring(0,1) : 'm', color: Theme.of(context).colorScheme.surface, fontSize: Get.width * 0.06, fontWeight: FontWeight.bold)
                        )
                      )
                    else
                      Center(
                          child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage: Image.network(
                                  _getController.authorDetailModelList[index].data!.image.toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                        width: 60.w,
                                        height: 60.h,
                                        child: Skeletonizer(child: Container(width: Get.width * 0.15, height: Get.width * 0.15, color: AppColors.grey))
                                    );
                                  }
                              ).image
                          )
                      ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                      child:  Center(
                          child: TextLarge(maxLines: 3, textAlign: TextAlign.center, text: 'uz_UZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.name!.uz! : 'oz_OZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.name!.oz! : _getController.authorDetailModelList[index].data!.name!.ru!, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onSurface)
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    if (_getController.authorDetailModelList[index].data!.content != null)
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.04),
                        child:  Center(
                            child: TextSmall(maxLines: 500, textAlign: TextAlign.start, text: 'uz_UZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.content!.uz! : 'oz_OZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.content!.oz! : _getController.authorDetailModelList[index].data!.content!.ru!, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onSurface)
                        )
                      ),
                    SizedBox(height: Get.height * 0.01),
                    if (_getController.menuModel.value.data != null)
                      if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailProductModelList[0].data!.result != null && _getController.authorDetailProductModelList[0].data!.result!.isNotEmpty)
                        ChildItem(title: 'Muallif kitoblari'.tr, function: (){
                          _getController.clearAuthorModel();
                          Get.to(() => AuthorCategory());
                        }),
                    if (_getController.authorDetailProductModelList.isNotEmpty && _getController.authorDetailProductModelList[0].data!.result != null && _getController.authorDetailProductModelList[0].data!.result!.isNotEmpty)
                      SizedBox(
                          height: 370.h,
                          width: Get.width,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: Get.width * 0.03),
                              itemCount: _getController.authorDetailProductModelList[0].data!.result?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ProductItem(
                                    imageUrl: _getController.authorDetailProductModelList[0].data!.result![index].image.toString(),
                                    title: _getController.authorDetailProductModelList[0].data!.result![index].name.toString(),
                                    price: _getController.authorDetailProductModelList[0].data!.result![index].price.toString(),
                                    function: () {
                                      _getController.page.value = 1;
                                      _getController.productModelLength.value = 0;
                                      _getController.clearProductDetailModel();
                                      _getController.clearProductDetailList();
                                      Get.to(() => DetailPage(
                                        slug: _getController.authorDetailProductModelList[0].data!.result![index].slug.toString(),
                                        pageIndex: 0,
                                      ));
                                    },
                                    id: _getController.authorDetailProductModelList[0].data!.result![index].sId.toString(),
                                    deck: _getController.authorDetailProductModelList[0].data!.result![index].name.toString(),
                                    count: _getController.authorDetailProductModelList[0].data!.count,
                                    sale: _getController.authorDetailProductModelList[0].data!.result![index].sale ?? 0
                                );
                              })),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      ChildItem(title: 'Mualliflar'.tr, function: (){
                        _getController.clearAuthorModel();
                        Get.to(() => AuthorCategory());
                      }),
                    if(index<1)
                      if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                        SizedBox(height: Get.height * 0.01),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      for (int i = 0; i < _getController.authorDetailModelList[index].data!.similarAuthors!.length; i++)
                        if (_getController.authorDetailModelList[index].data!.similarAuthors![i].productCount!.toString() != '0')
                        AuthorItem(
                            sId: _getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString(),
                            title: 'uz_UZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.uz.toString() : 'oz_OZ' == _getController.getLocale() ? _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.oz.toString() : _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.ru.toString(),
                            subTitle: _getController.authorDetailModelList[index].data!.similarAuthors![i].productCount!.toString(),
                            image: _getController.authorDetailModelList[index].data!.similarAuthors![i].image!.toString(),
                            onTap: () {
                              _getController.removeAuthorDetailModel(index + 1);
                              debugPrint('similarAuthors: ${_getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString()}');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetail(
                                  sId: _getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString(),
                                  title: _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.uz.toString(),
                                  index: index + 1
                              )));
                            },
                            index: index + 1
                        ),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      SizedBox(height: Get.height * 0.01),
                  ])
                  : const Center(child: CircularProgressIndicator()))
          )
      )
    );
  }
}