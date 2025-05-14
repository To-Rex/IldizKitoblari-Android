import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class ContentPage extends StatefulWidget {
  final String bookName;
  final String author;

  const ContentPage({super.key, required this.bookName, required this.author});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final GetController _getController = Get.find<GetController>();
  Future<List<EpubChapter>>? _chaptersFuture;

  @override
  void initState() {
    super.initState();
    print('ContentPage initState: bookName=${widget.bookName}, author=${widget.author}');
    _loadChapters();
  }

  void _loadChapters() {
    setState(() {
      _chaptersFuture = _getController.epubController.parseChapters().then((chapters) {
        print('Boblar soni: ${chapters.length}');
        print('Boblar JSON: ${jsonEncode(chapters.map((e) => e.toJson()).toList())}');
        return chapters;
      }).catchError((e) {
        print('Boblar yuklash xatosi: $e');
        throw e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppColors.element,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Padding(
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              TextSmall(
                text: widget.bookName,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: _getController.textColor.value,
                fontFamily: _getController.selectedFont.value,
              ),
              TextSmall(
                text: widget.author == 'Unknown' ? 'Noma’lum'.tr : widget.author,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: _getController.textColor.value.withAlpha(100),
                fontFamily: _getController.selectedFont.value,
              ),
              SizedBox(height: 15.h),
              FutureBuilder<List<EpubChapter>>(
                future: _chaptersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('AppBar FutureBuilder: Yuklanmoqda...');
                    return TextSmall(
                      text: 'Yuklanmoqda...',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: _getController.textColor.value,
                      fontFamily: _getController.selectedFont.value,
                    );
                  } else if (snapshot.hasError) {
                    print('AppBar FutureBuilder: Xato: ${snapshot.error}');
                    return TextSmall(
                      text: '0 ${'ta qism'.tr}'.tr,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: _getController.textColor.value,
                      fontFamily: _getController.selectedFont.value,
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print('AppBar FutureBuilder: Ma‘lumot yo‘q');
                    return TextSmall(
                      text: '0 ${'ta qism'.tr}'.tr,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: _getController.textColor.value,
                      fontFamily: _getController.selectedFont.value,
                    );
                  } else {
                    print('AppBar FutureBuilder: Boblar soni: ${snapshot.data!.length}');
                    return TextSmall(
                      text: '${snapshot.data!.length} ${'ta qism'.tr}'.tr,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: _getController.textColor.value,
                      fontFamily: _getController.selectedFont.value,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
        child: FutureBuilder<List<EpubChapter>>(
          future: _chaptersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Body FutureBuilder: Yuklanmoqda...');
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Body FutureBuilder: Xato: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSmall(
                      text: '${'Ma‘lumotlar yo‘q!'.tr}\n${snapshot.error}',
                      color: Colors.red,
                      fontSize: 16.sp,
                      textAlign: TextAlign.center,
                      fontFamily: _getController.selectedFont.value,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print('Qayta yuklash bosildi');
                        _loadChapters();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: TextSmall(
                        text: 'Qayta urinish',
                        color: Colors.white,
                        fontFamily: _getController.selectedFont.value,
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              print('Body FutureBuilder: Ma‘lumot yo‘q');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSmall(
                      text: 'Mundarija topilmadi!',
                      color: _getController.textColor.value,
                      fontSize: 16.sp,
                      fontFamily: _getController.selectedFont.value,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        print('Qayta yuklash bosildi');
                        _loadChapters();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: TextSmall(
                        text: 'Qayta urinish',
                        color: Colors.white,
                        fontFamily: _getController.selectedFont.value,
                      ),
                    ),
                  ],
                ),
              );
            }

            final chapters = snapshot.data!;
            print('ListView.builder: Boblar soni: ${chapters.length}');
            return ListView.builder(
              padding: EdgeInsets.only(top: 16.h, bottom: 60.h, left: 16.w, right: 16.w),
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return ChapterTile(
                  chapter: chapters[index],
                  depth: 0,
                  isLast: index == chapters.length - 1,
                );
              },
            );
          },
        ),
      ),
    ));
  }
}

class ChapterTile extends StatelessWidget {
  final EpubChapter chapter;
  final int depth;
  final bool isLast;

  ChapterTile({
    super.key,
    required this.chapter,
    required this.depth,
    required this.isLast,
  });

  final GetController _getController = Get.put(GetController());
  // Title ni tozalash funksiyasi
  String _cleanTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'Noma’lum bob';
    }
    // Bo‘sh joylar, \n, \t va boshqa maxsus belgilarni olib tashlash
    return title
        .trim()
        .replaceAll(RegExp(r'[\n\t\r]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  Widget build(BuildContext context) {
    final cleanedTitle = _cleanTitle(chapter.title);
    print('ChapterTile: title="$cleanedTitle", rawTitle="${chapter.title}", depth=$depth, href=${chapter.href}, subitems=${chapter.subitems.length}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 16.w * depth),
          title: TextSmall(
            text: cleanedTitle,
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16.sp,
            fontFamily: _getController.selectedFont.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            print('Bob tanlandi: $cleanedTitle, href=${chapter.href}');
            _getController.epubController.display(cfi: chapter.href);
            Get.back();
          },
        ),
        if (chapter.subitems.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              children: chapter.subitems.asMap().entries.map((entry) => ChapterTile(chapter: entry.value, depth: depth + 1, isLast: entry.key == chapter.subitems.length - 1,)).toList(),
            ),
          ),
        if (!isLast && chapter.subitems.isEmpty)
          Divider(
            //color: _getController.textColor.value.withOpacity(0.3),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            thickness: 1,
            indent: 16.w * depth,
            endIndent: 16.w,
          ),
      ],
    );
  }
}