import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'content_page.dart';

class EpubReaderPage extends StatefulWidget {
  final String epubUrl;
  final String bookTitle;

  const EpubReaderPage({
    super.key,
    required this.epubUrl,
    this.bookTitle = 'Kitob',
  });

  @override
  _EpubReaderPageState createState() => _EpubReaderPageState();
}

class _EpubReaderPageState extends State<EpubReaderPage> {
  bool _isLoading = true;
  String? _errorMessage;
  Timer? _loadingTimer;
  bool _isFullscreen = false; // To‘liq ekran holatini kuzatish
  final GetController _getController = Get.put(GetController());
  String _bookTitle = 'Kitob'; // Dastlabki kitob nomi
  final String _bookAuthor = 'Muallif'; // Dastlabki muallif nomi
  bool _isMetadataLoading = true; // Metama'lumotlar yuklanayotganini kuzatish

  @override
  void initState() {
    super.initState();
    // Maksimal 30 soniya kutish uchun taymer
    _getController.textSize;
    _getController.themeColor;
    _getController.orientation;
    _getController.epubController.setFontSize(fontSize: _getController.fontSize.value);
    _getController.epubController.setFlow(flow: _getController.isVertical.value ? EpubFlow.scrolled : EpubFlow.paginated);
    _getController.epubController.setSpread(spread: EpubSpread.auto);

    _loadingTimer = Timer(const Duration(seconds: 30), () {
      if (mounted && _isLoading) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Yuklash vaqti tugadi. Iltimos, qayta urinib ko‘ring.';
        });
      }
    });
    _loadMetadata();
  }

  void _reloadEpub() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _getController.epubController = EpubController(); // Yangi kontroller yaratish
      // Taymer qayta boshlash
      _loadingTimer?.cancel();
      _loadingTimer = Timer(const Duration(seconds: 30), () {
        if (mounted && _isLoading) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Yuklash vaqti tugadi. Iltimos, qayta urinib ko‘ring.';
          });
        }
      });
    });
  }

  void _toggleFullscreen() {
    print('To‘liq ekran rejimi o‘zgartirildi: $_isFullscreen -> ${!_isFullscreen}');
    setState(() {
      _isFullscreen = !_isFullscreen; // To‘liq ekran holatini o‘zgartirish
    });
  }

  Future<void> _loadMetadata() async {
    try {
      final metadata = await _getController.getEpubMetadata(widget.epubUrl);
      setState(() {
        _bookTitle = metadata['title'] ?? widget.bookTitle;
        _isMetadataLoading = false;
      });
    } catch (e) {
      setState(() {
        _bookTitle = widget.bookTitle; // Xato bo'lsa, standart nom ishlatiladi
        _isMetadataLoading = false;
      });
    }
  }

  Widget elevatedButtonWidget(index, color) => ElevatedButton(
      onPressed: () {
        _getController.saveThemeColor(index);
        _getController.epubController.updateTheme(theme: EpubTheme.custom(backgroundColor: _getController.backgroundColor.value, foregroundColor: _getController.textColor.value));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(40, 40),
          maximumSize: const Size(40, 40),
          shape: const CircleBorder(side: BorderSide(color: AppColors.grey, width: 1)),
          padding: const EdgeInsets.all(20)
      ),
      child: const Text('', style: TextStyle(color: AppColors.black))
  );

  bottomSheetBookSettings(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0), left: Radius.circular(10.0))),
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: _getController.backgroundColor.value,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Obx(() => Container(
                height: Get.height * 0.45,
                decoration: BoxDecoration(color: _getController.backgroundColor.value, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.01, top: Get.height * 0.01),
                          child: Center(
                              child: Container(
                                  width: Get.width * 0.1,
                                  height: 5,
                                  margin: EdgeInsets.only(top: 5, bottom: Get.height * 0.01),
                                  decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.5) : Theme.of(context).colorScheme.surface.withOpacity(0.5), borderRadius: BorderRadius.circular(10.r))
                              )
                          )
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                          child: Row(
                              children: [
                                Icon(TablerIcons.sun, color: _getController.textColor.value),
                                Expanded(
                                    child: SliderTheme(
                                      data: SliderThemeData(thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.r), trackHeight: 10.h),
                                      child: Slider(
                                        value: _getController.brightness.value,
                                        activeColor: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.8) : Theme.of(context).colorScheme.surface.withOpacity(0.8),
                                        overlayColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surface.withOpacity(0.2)),
                                        inactiveColor: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.5) : Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                        thumbColor: Theme.of(context).colorScheme.surface,
                                        max: 1.0,
                                        min: 0.0,
                                        onChanged: (value) {
                                          _getController.brightness.value = value;
                                          _getController.setBrightness(value);
                                        },
                                      ),
                                    )
                                ),
                                Icon(TablerIcons.sun_high, color: _getController.textColor.value)
                              ]
                          )
                      ),
                      Container(
                          width: Get.width,
                          height: 55.h,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
                          decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.2) : Theme.of(context).colorScheme.surface.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                    child: IconButton(
                                        color: Theme.of(context).colorScheme.surface,
                                        splashColor: Theme.of(context).colorScheme.surface,
                                        onPressed: () {
                                          _getController.decreaseTextSize();
                                          _getController.epubController.setFontSize(fontSize: _getController.fontSize.value);
                                        },
                                        icon: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(TablerIcons.letter_a_small, color: AppColors.black, size: 30),
                                              TextSmall(text: '-', color: AppColors.black)
                                            ]
                                        )
                                    )
                                ),
                                Text(' ${_getController.fontSize.value.toString().split('.').first} px', style: TextStyle(color: _getController.textColor.value, fontFamily: _getController.selectedFont.value)),
                                Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                    child: IconButton(
                                        color: Theme.of(context).colorScheme.surface,
                                        splashColor: Theme.of(context).colorScheme.surface,
                                        onPressed: () {
                                          _getController.increaseTextSize();
                                          _getController.epubController.setFontSize(fontSize: _getController.fontSize.value);
                                        },
                                        icon: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(TablerIcons.letter_a_small, color: AppColors.black, size: 30),
                                              TextSmall(text: '+', color: AppColors.black)
                                            ]
                                        )
                                    )
                                )
                              ]
                          )
                      ),
                      Container(
                          width: Get.width,
                          height: 55.h,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
                          decoration: BoxDecoration(color: _getController.backgroundColor.value != AppColors.grey ? AppColors.grey.withOpacity(0.2) : Theme.of(context).colorScheme.surface.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                    child: IconButton(
                                      color: Theme.of(context).colorScheme.surface,
                                      splashColor: Theme.of(context).colorScheme.surface,
                                      onPressed: () {
                                        if (_getController.fontNames.indexOf(_getController.font) == 0) {
                                          _getController.changeSelectedFont(_getController.fontNames.length - 1);
                                        } else {
                                          _getController.changeSelectedFont(_getController.fontNames.indexOf(_getController.font) - 1);
                                        }
                                      },
                                      icon: const Icon(TablerIcons.caret_left_filled, color: AppColors.black, size: 20),
                                    )
                                ),
                                Text(_getController.selectedFont.value, style: TextStyle(color: _getController.textColor.value, fontFamily: _getController.selectedFont.value)),
                                Container(
                                    width: 60,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: Theme.of(context).colorScheme.surface),
                                    child: IconButton(
                                      color: Theme.of(context).colorScheme.surface,
                                      splashColor: Theme.of(context).colorScheme.surface,
                                      onPressed: () {
                                        if (_getController.fontNames.indexOf(_getController.font) == _getController.fontNames.length - 1) {
                                          _getController.changeSelectedFont(0);
                                        } else {
                                          _getController.changeSelectedFont(_getController.fontNames.indexOf(_getController.font) + 1);
                                        }
                                      },
                                      icon: const Icon(TablerIcons.caret_right_filled, color: AppColors.black, size: 20),
                                    )
                                )
                              ]
                          )
                      ),
/*                      const SizedBox(height: 5),
                      Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextSmall(text: 'Vertical', color: _getController.textColor.value, fontWeight: FontWeight.w400, fontFamily: _getController.selectedFont.value),
                                SizedBox(
                                    width: Get.width * 0.2,
                                    height: Get.height * 0.05,
                                    child: CupertinoSwitch(
                                        value: _getController.isVertical.value,
                                        onChanged: (value) {
                                          _getController.epubController.setFlow(flow: value ? EpubFlow.scrolled : EpubFlow.paginated);
                                          _getController.saveOrientation(value);
                                        },
                                        activeColor: Theme.of(context).colorScheme.primary)
                                )
                              ]
                          )
                      ),*/
                      const SizedBox(height: 50),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            elevatedButtonWidget(0, AppColors.white),
                            elevatedButtonWidget(1, AppColors.trueToneColor),
                            elevatedButtonWidget(2, AppColors.grey),
                            elevatedButtonWidget(3, AppColors.midnightBlack),
                            elevatedButtonWidget(4, AppColors.black)
                          ]
                      )
                    ]
                )
            ));
          })
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: _getController.backgroundColor.value,
      appBar: _isFullscreen ? null : AppBar(
        backgroundColor: _getController.backgroundColor.value,
        title: _isMetadataLoading
            ? TextSmall(text: 'Yuklanmoqda...', color: _getController.textColor.value, fontFamily: _getController.selectedFont.value)
            : TextSmall(
          text: _bookTitle,
          color: _getController.textColor.value,
          fontFamily: _getController.selectedFont.value,
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: false,
      ),
      bottomNavigationBar: _isFullscreen ? null : BottomAppBar(
        color: _getController.backgroundColor.value,
        height: 65,
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(TablerIcons.menu_deep, size: 24.sp, color: _getController.textColor.value),
              onPressed: () {
                Get.to(ContentPage(bookName: _bookTitle, author: _bookAuthor));
              },
            ),
            IconButton(
              icon: Icon(TablerIcons.settings, size: 24.sp, color: _getController.textColor.value),
              onPressed: () {
                bottomSheetBookSettings(context);
              },
            ),
            IconButton(
              icon: Icon(TablerIcons.bookmark, size: 24.sp, color: _getController.textColor.value),
              onPressed: () {
              },
            ),
            Spacer(),
            //previous
            IconButton(
              icon: Icon(TablerIcons.caret_left_filled, size: 24.sp, color: _getController.textColor.value),
              onPressed: () {
                _getController.epubController.prev();
              },
            ),
            //next
            IconButton(
              icon: Icon(TablerIcons.caret_right_filled, size: 24.sp, color: _getController.textColor.value),
              onPressed: () {
                _getController.epubController.next();
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: _getController.backgroundColor.value,
        padding: EdgeInsets.only(top: _isFullscreen ? 20 : 0, bottom: _isFullscreen ? 20 : 0),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand, // Stack butun ekranni egallashi uchun
          children: [
            EpubViewer(
              epubSource: EpubSource.fromUrl(widget.epubUrl),
              //epubSource: EpubSource.fromUrl('https://github.com/IDPF/epub3-samples/releases/download/20230704/accessible_epub_3.epub'),
              epubController: _getController.epubController,
              displaySettings: EpubDisplaySettings(
                useSnapAnimationAndroid: Platform.isAndroid, // Android uchun snap animatsiyasi
                flow: EpubFlow.paginated, // Vertical rejimi
                allowScriptedContent: true,
                manager: EpubManager.continuous, // Continuous rejimi
                spread: EpubSpread.auto,
                snap: true, // Snap yoqilgan, iOS’da scrollni tiklash uchun
                fontSize: _getController.fontSize.value.toInt(),
                theme: EpubTheme.custom(backgroundColor: _getController.backgroundColor.value, foregroundColor: _getController.textColor.value),
              ),
              onEpubLoaded: () {
                print('EPUB yuklandi: ${widget.epubUrl}');
                _getController.epubController.updateTheme(theme: EpubTheme.custom(backgroundColor: _getController.backgroundColor.value, foregroundColor: _getController.textColor.value));
                setState(() {
                  _isLoading = false;
                  _errorMessage = null;
                  _loadingTimer?.cancel(); // Taymer to‘xtatiladi
                });
              },
              onTextSelected: (epubTextSelection) {
                print('Tanlangan matn: ${epubTextSelection.selectedText}');
              },
            ),
            // To‘liq ekran uchun GestureDetector
            IgnorePointer(
              ignoring: _isLoading || _errorMessage != null, // Yuklash yoki xato paytida bosishni o‘chirish
              child: GestureDetector(
                onTap: () {
                  if (Platform.isIOS) {
                    print('iOS: Bosish aniqlandi');
                  }
                  _toggleFullscreen(); // Faqat bitta bosish
                },
                behavior: Platform.isIOS ? HitTestBehavior.opaque : HitTestBehavior.translucent, // iOS uchun opaque, Android uchun translucent
                child: Container(), // Bo‘sh konteyner, faqat hodisalarni ushlash uchun
              ),
            ),
            // Yuklash indikatori
            if (_isLoading) Container(
              color: _getController.backgroundColor.value,
              alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator()),
            ),
            // Xato xabari
            if (_errorMessage != null && !_isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSmall(text: _errorMessage!, color: Colors.red, textAlign: TextAlign.center, fontSize: 16, maxLines: 10, fontFamily: _getController.selectedFont.value),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadEpub,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      child: TextSmall(text: 'Xatolik', color: Colors.white),
                    )
                  ]
                )
              )
          ]
        )
      )
    ));
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }
}