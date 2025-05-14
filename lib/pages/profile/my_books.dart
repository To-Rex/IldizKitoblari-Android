import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/child_item.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../shop/audio_page.dart';

class MyBooks extends StatelessWidget{
  MyBooks({super.key});
  final GetController _getController = Get.put(GetController());

//  Future<void> _openEpubReader(BuildContext context, url) async => await CosmosEpub.openURLBook(urlPath: url, context: context, bookId: '3', accentColor: Colors.transparent, onPageFlip: (int currentPage, int totalPages) {debugPrint(currentPage.toString());}, onLastPage: (int lastPageIndex) {debugPrint('We arrived to the last widget');});

  @override
  Widget build(BuildContext context) {
    _getController.clearEBookLibraryList();
    _getController.clearAudioLibraryList();
    ApiController().getEBookLibraryList();
    ApiController().getAudioLibraryList();
    return Scaffold(
      appBar: AppBar(
        title: TextLarge(text: 'Mening kitoblarim'.tr),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp), onPressed: () {Get.back();})
      ),
      body: Obx(() {
        final eBooksAvailable = _getController.eBookLibraryList.value.data?.result?.isNotEmpty ?? false;
        final audioBooksAvailable = _getController.audioLibraryList.value.data?.result?.isNotEmpty ?? false;
        if (!eBooksAvailable && !audioBooksAvailable) {
          return Center(child: TextSmall(text: 'Ma‘lumotlar yo‘q!', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: 15.sp));
        }
        return Column(
          children: [
            SizedBox(height: 15.h),
            if (eBooksAvailable)
              ...[
                ChildItem(title: 'O‘qilayotgan kitoblar'.tr, function: () {}, isAll: false),
                ListView.builder(
                  padding: EdgeInsets.only(left: 15.w, top: 20.h),
                  itemCount: _getController.eBookLibraryList.value.data!.result!.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final book = _getController.eBookLibraryList.value.data!.result![index].product!;
                    return InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () {
                        _getController.whileApi.value = false;
                        _getController.fontSize.value = Get.height * 0.017;
                        //_openEpubReader(context, book.ebook.toString()).then((value) => Get.back());
                        Get.dialog(barrierDismissible: true, AlertDialog(backgroundColor: Colors.transparent, insetPadding: EdgeInsets.zero, content: SizedBox(width: Get.width, height: Get.height * 0.8, child: const Center(child: CircularProgressIndicator(color: AppColors.primaryColor3, strokeWidth: 2)))));
                      },
                      child: Container(
                        width: Get.width * 0.9,
                        margin: EdgeInsets.only(right: 15.sp),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                        child: Row(
                          children: [
                            Container(
                              width: 100.sp,
                              height: 105.sp,
                              margin: EdgeInsets.only(right: 15.sp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  book.image ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : SizedBox(width: _getController.width.value * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: Get.height * 0.205, color: AppColors.grey))),
                                  errorBuilder: (context, error, stackTrace) => Center(child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png'))
                                )
                              )
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextSmall(text: book.name?.uz ?? '', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                                SizedBox(height: 8.sp),
                                TextSmall(text: book.sId ?? '', color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 11.sp),
                              ]
                            )
                          ]
                        )
                      )
                    );
                  }
                )
              ],
            if (eBooksAvailable) SizedBox(height: 15.h),
            if (audioBooksAvailable)
              ...[
                ChildItem(title: 'Tinglanayotgan kitoblar'.tr, function: () {}, isAll: false),
                ListView.builder(
                    padding: EdgeInsets.only(left: 15.w, top: 20.h),
                  itemCount: _getController.audioLibraryList.value.data!.result!.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final audio = _getController.audioLibraryList.value.data!.result![index].product!;
                    return InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      //onTap: () => Get.to(() => AudioPage(sId: _getController.audioLibraryList.value.data!.result![index].sId!, title: audio.name!.uz!)),
                      child: Container(
                        width: Get.width * 0.9,
                        margin: EdgeInsets.only(right: 15.sp),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.r), boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.3), blurRadius: 2, spreadRadius: 1)]),
                        child: Row(
                          children: [
                            Container(
                              width: 100.sp,
                              height: 105.sp,
                              margin: EdgeInsets.only(right: 15.sp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  audio.image ?? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : SizedBox(width: _getController.width.value * 0.44, height: Get.height * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: Get.height * 0.205, color: AppColors.grey))),
                                  errorBuilder: (context, error, stackTrace) => Center(child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png')))
                                )
                              ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextSmall(text: audio.name?.uz ?? '', fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface),
                                SizedBox(height: 5.h),
                                TextSmall(text: audio.sId ?? '', fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontSize: 11.sp)
                              ]
                            )
                          ]
                        )
                      )
                    );
                  })
              ]
          ]
        );
      })
    );
  }
}