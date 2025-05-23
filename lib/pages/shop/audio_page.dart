import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:just_audio/just_audio.dart';
import '../../companents/appbar/custom_header.dart';
import '../../companents/basket/audio_skleton.dart';
import '../../companents/filds/text_large.dart';
import '../../companents/filds/text_small.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import '../../resource/component_size.dart';

class AudioPage extends StatefulWidget {
  final String sId;
  final String title;

  const AudioPage({super.key, required this.sId, required this.title});

  @override
  AudioPlayerBackgroundPlaylistState createState() => AudioPlayerBackgroundPlaylistState();
}

class AudioPlayerBackgroundPlaylistState extends State<AudioPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  bool isPlaying = false;
  bool isLoading = true; // Yuklanish holatini kuzatish
  String? audioUrl;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  Duration bufferedPosition = Duration.zero; // Buferlangan qism
  int selectedAudio = 0;
  ConcatenatingAudioSource? playlist;

  // Yangilashdan oldingi holatni saqlash uchun o'zgaruvchilar
  bool _wasPlaying = false;
  Duration _savedPosition = Duration.zero;
  int _savedIndex = 0;

  Future<void> _loadAudio({bool isRefresh = false}) async {
    try {
      debugPrint('loadAudio boshlandi: ${DateTime.now()}');
      setState(() {
        isLoading = true;
      });

      // Yangilashdan oldin joriy holatni saqlash
      if (isRefresh) {
        _wasPlaying = isPlaying;
        _savedPosition = currentPosition;
        _savedIndex = selectedAudio;
        await audioPlayer.pause();
        debugPrint('Audio pauza qilindi: isPlaying=$isPlaying');
      }

      // API chaqiruvi va pleylist sozlash
      debugPrint('API chaqiruvi boshlandi: ${DateTime.now()}');
      await ApiController().getFragmentLibraryList(widget.sId);
      debugPrint('API chaqiruvi tugadi: ${DateTime.now()}');
      await setupPlaylist();

      // Yangilashdan keyin holatni tiklash
      if (isRefresh && _wasPlaying && playlist != null && playlist!.length > 0) {
        debugPrint('Holatni tiklash boshlandi: index=$_savedIndex, position=$_savedPosition');
        await audioPlayer.seek(_savedPosition, index: _savedIndex);
        await audioPlayer.play();
        setState(() {
          isPlaying = true;
          selectedAudio = _savedIndex;
          currentPosition = _savedPosition;
        });
        debugPrint('Holatni tiklash tugadi: isPlaying=$isPlaying');
      }

      setState(() {
        audioUrl = _getController.audioReviewModel.value.data?.result?.isNotEmpty == true
            ? _getController.audioReviewModel.value.data!.result![0].file?.path
            : null;
        isLoading = false;
      });
    } catch (e) {
      //ApiController().showToast(context, title, message, error, sec)
      ApiController().showToast(context, 'Xatolik', 'Audio yuklashda xato yuz berdi!', true, 3);
      debugPrint('Audio yuklash xatosi: $e');
      setState(() {
        audioUrl = null;
        isPlaying = false;
        isLoading = false;
      });
      if (isRefresh) {
        _refreshController.refreshFailed();
      }
    } finally {
      if (isRefresh) {
        _refreshController.refreshCompleted();
        Future.microtask(() {
          setState(() {});
          debugPrint('SmartRefresher holati yangilandi: ${DateTime.now()}');
        });
      }
      debugPrint('loadAudio tugadi: ${DateTime.now()}');
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAudio();
    audioPlayer.positionStream.listen((position) {
      setState(() {
        currentPosition = position;
        if (currentPosition > totalDuration) {
          currentPosition = totalDuration;
        }
      });
    });

    audioPlayer.durationStream.listen((duration) {
      setState(() {
        totalDuration = duration ?? Duration.zero;
        isLoading = false; // Audio manbai yuklandi
      });
    });

    audioPlayer.bufferedPositionStream.listen((position) {
      setState(() {
        bufferedPosition = position;
      });
    });

    audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing && state.processingState != ProcessingState.completed;
      });
    });

    audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          selectedAudio = index;
        });
      }
    });

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed && selectedAudio < (playlist?.length ?? 0) - 1) {
        skipNext();
      } else if (state == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          currentPosition = Duration.zero;
        });
        audioPlayer.stop();
      }
    });
  }

  Future<void> setupPlaylist() async {
    try {
      final results = _getController.audioReviewModel.value.data?.result;
      debugPrint('API natijasi: ${results?.length ?? 0} element');
      if (results == null || results.isEmpty) {
        debugPrint('Audio ro‘yxati bo‘sh');
        setState(() {
          playlist = null;
          audioUrl = null;
          isLoading = false;
        });
        return;
      }

      List<AudioSource> sources = [];
      for (var result in results) {
        final path = result.file?.path;
        debugPrint('Audio URL: $path');
        if (path != null && path.isNotEmpty) {
          sources.add(AudioSource.uri(Uri.parse(path)));
        }
      }

      if (sources.isEmpty) {
        debugPrint('Hech qanday audio manbai topilmadi');
        setState(() {
          playlist = null;
          audioUrl = null;
          isLoading = false;
        });
        return;
      }

      final newPlaylist = ConcatenatingAudioSource(children: sources);
      setState(() {
        playlist = newPlaylist;
        audioUrl = sources.isNotEmpty ? sources[0].toString() : null;
      });

      await audioPlayer.setAudioSource(newPlaylist, initialIndex: 0, initialPosition: Duration.zero);
      await audioPlayer.stop();
      debugPrint('Pleylist muvaffaqiyatli sozlandi: ${sources.length} ta audio');
    } catch (e, stackTrace) {
      debugPrint('Pleylist sozlash xatosi: $e');
      debugPrint('Stack trace: $stackTrace');
      ApiController().showToast(context, 'Xatolik', 'Pleylist sozlash xatosi: $e', true, 3);
      setState(() {
        playlist = null;
        audioUrl = null;
        isLoading = false;
      });
    }
  }

  Future<void> playMusic() async {
    try {
      if (playlist == null || playlist!.length == 0) {
        debugPrint('Pleylist mavjud emas, o‘ynash imkonsiz');
        ApiController().showToast(context, 'Xatolik', 'Audio ro‘yxati mavjud emas1!', true, 3);
        return;
      }
      await audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
      debugPrint('Audio o‘ynatilmoqda');
    } catch (e) {
      debugPrint('Play xatosi: $e');
      setState(() {
        isPlaying = false;
      });
    }
  }

  Future<void> pauseMusic() async {
    try {
      await audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
      debugPrint('Audio to‘xtatildi');
    } catch (e) {
      debugPrint('Pause xatosi: $e');
    }
  }

  Future<void> skipPrevious() async {
    try {
      if (selectedAudio > 0) {
        setState(() {
          selectedAudio--;
          currentPosition = Duration.zero;
        });
        await audioPlayer.seek(Duration.zero, index: selectedAudio);
        await audioPlayer.play();
        setState(() {
          isPlaying = true;
        });
        debugPrint('Oldingi trekka o‘tildi: indeks $selectedAudio');
      }
    } catch (e) {
      debugPrint('Oldingi trek xatosi: $e');
    }
  }

  Future<void> skipNext() async {
    try {
      if (selectedAudio < (playlist?.length ?? 0) - 1) {
        setState(() {
          selectedAudio++;
          currentPosition = Duration.zero;
        });
        await audioPlayer.seek(Duration.zero, index: selectedAudio);
        await audioPlayer.play();
        setState(() {
          isPlaying = true;
        });
        debugPrint('Keyingi trekka o‘tildi: indeks $selectedAudio');
      } else {
        setState(() {
          isPlaying = false;
          currentPosition = Duration.zero;
        });
        await audioPlayer.stop();
      }
    } catch (e) {
      debugPrint('Keyingi trek xatosi: $e');
    }
  }

  Future<void> skipTo(int index) async {
    try {
      setState(() {
        selectedAudio = index;
        currentPosition = Duration.zero;
      });
      await audioPlayer.seek(Duration.zero, index: index);
      await audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
      debugPrint('Trekka o‘tildi: indeks $index');
    } catch (e) {
      debugPrint('Trekka o‘tish xatosi: $e');
    }
  }

  void _onSeek(double value) {
    try {
      final newPosition = Duration(seconds: value.toInt());
      if (newPosition <= totalDuration) {
        audioPlayer.seek(newPosition);
        setState(() {
          currentPosition = newPosition;
        });
      }
    } catch (e) {
      debugPrint('Seek xatosi: $e');
    }
  }

  void _skipForward() {
    try {
      final newPosition = currentPosition + const Duration(seconds: 15);
      if (newPosition <= totalDuration) {
        audioPlayer.seek(newPosition);
        setState(() {
          currentPosition = newPosition;
        });
      }
    } catch (e) {
      debugPrint('Oldinga o‘tish xatosi: $e');
    }
  }

  void _skipBackward() {
    try {
      final newPosition = currentPosition - const Duration(seconds: 15);
      if (newPosition >= Duration.zero) {
        audioPlayer.seek(newPosition);
        setState(() {
          currentPosition = newPosition;
        });
      } else {
        audioPlayer.seek(Duration.zero);
        setState(() {
          currentPosition = Duration.zero;
        });
      }
    } catch (e) {
      debugPrint('Orqaga o‘tish xatosi: $e');
    }
  }

  Future<void> _playSelectedAudio(int index) async {
    try {
      if (playlist == null || playlist!.length == 0) {
        debugPrint('Pleylist mavjud emas, audio o‘ynatilmaydi');
        ApiController().showToast(context, 'Xatolik', 'Audio ro‘yxati mavjud emas2!', true, 3);
        return;
      }
      if (selectedAudio != index) {
        await skipTo(index);
      } else {
        if (isPlaying) {
          await pauseMusic();
        } else {
          await playMusic();
        }
      }
    } catch (e) {
      ApiController().showToast(context, 'Xatolik', 'Audio ijro xatosi: $e', true, 3);
      debugPrint('Audio ijro xatosi: $e');
      ApiController().showToast(context, 'Xatolik', 'Audio ijro etishda xato yuz berdi!', true, 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const CustomRefreshHeader(),
        footer: const CustomRefreshFooter(),
        onLoading: () async {
          _refreshController.loadComplete();
        },
        onRefresh: () async {
          await _loadAudio(isRefresh: true);
        },
        controller: _refreshController,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: audioUrl != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColors.grey.withOpacity(0.2),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 25.sp,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      TablerIcons.share,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      TablerIcons.bookmark,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200.w,
                      height: 200.h,
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        image: DecorationImage(
                          image: NetworkImage(
                            _getController.audioReviewModel.value.data?.product?.image ??
                                'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        child: FadeInImage(
                          image: NetworkImage(
                            _getController.audioReviewModel.value.data?.product?.image ??
                                'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                          ),
                          placeholder: const NetworkImage(
                            'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                          ),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    TextLarge(
                      text: _getController.getLocale() == 'uz_UZ'
                          ? _getController.audioReviewModel.value.data?.product?.name?.uz ?? ''
                          : _getController.getLocale() == 'oz_OZ'
                          ? _getController.audioReviewModel.value.data?.product?.name?.oz ?? ''
                          : _getController.audioReviewModel.value.data?.product?.name?.ru ?? '',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        SizedBox(width: 15.w),
                        Expanded(
                          child: TextSmall(
                            text: _getController.audioReviewModel.value.data?.result?.isNotEmpty == true &&
                                selectedAudio < _getController.audioReviewModel.value.data!.result!.length
                                ? _getController.getLocale() == 'uz_UZ'
                                ? _getController.audioReviewModel.value.data!.result![selectedAudio].name?.uz ?? ''
                                : _getController.getLocale() == 'oz_OZ'
                                ? _getController.audioReviewModel.value.data!.result![selectedAudio].name?.oz ??
                                ''
                                : _getController.audioReviewModel.value.data!.result![selectedAudio].name?.ru ??
                                ''
                                : 'Noma’lum audio',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: currentPosition.inSeconds.toDouble().clamp(0.0, totalDuration.inSeconds.toDouble()),
                      min: 0,
                      max: totalDuration.inSeconds.toDouble() > 0 ? totalDuration.inSeconds.toDouble() : 1,
                      onChanged: isLoading ? null : (value) => _onSeek(value),
                      activeColor: AppColors.primaryColor2,
                      inactiveColor: Colors.grey.withOpacity(0.3),
                      secondaryTrackValue: bufferedPosition.inSeconds.toDouble().clamp(0.0, totalDuration.inSeconds.toDouble()),
                      secondaryActiveColor: Colors.grey.withOpacity(0.5), // Buferlangan qism rangi
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(isLoading ? '...' : _formatDuration(currentPosition)),
                          Text(isLoading ? '...' : _formatDuration(totalDuration)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, size: 30.sp),
                          onPressed: isLoading ? null : _skipBackward,
                        ),
                        IconButton(
                          color: AppColors.primaryColor,
                          icon: Icon(
                            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            size: 60.sp,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                            if (isPlaying) {
                              pauseMusic();
                            } else {
                              playMusic();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10, size: 30.sp),
                          onPressed: isLoading ? null : _skipForward,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(width: 15.w),
                  TextSmall(
                    text: 'Bo‘limlar'.tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              for (int index = 0; index < (_getController.audioReviewModel.value.data?.result?.length ?? 0); index++)
                Column(
                  children: [
                    InkWell(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: isLoading ? null : () => _playSelectedAudio(index),
                      child: Container(
                        width: Get.width,
                        height: 60.h,
                        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _getController.audioReviewModel.value.data?.product?.image ??
                                        'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: FadeInImage(
                                  image: NetworkImage(
                                    _getController.audioReviewModel.value.data?.product?.image ??
                                        'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  ),
                                  placeholder: const NetworkImage(
                                    'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                  ),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                            'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextSmall(
                                    text: _getController.audioReviewModel.value.data?.result?.isNotEmpty == true
                                        ? _getController.getLocale() == 'uz_UZ'
                                        ? _getController.audioReviewModel.value.data!.result![index].name?.uz ?? ''
                                        : _getController.getLocale() == 'oz_OZ'
                                        ? _getController.audioReviewModel.value.data!.result![index].name?.oz ??
                                        ''
                                        : _getController.audioReviewModel.value.data!.result![index].name?.ru ??
                                        ''
                                        : 'Noma’lum audio',
                                    color: selectedAudio == index
                                        ? AppColors.primaryColor
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5.h),
                                  if (_getController.audioReviewModel.value.data?.result?.isNotEmpty == true &&
                                      _getController.audioReviewModel.value.data!.result![index].file != null)
                                    TextSmall(
                                      text:
                                      '${(_getController.audioReviewModel.value.data!.result![index].file!.size! / 1024 / 1024).toStringAsFixed(2)} MB',
                                      color: selectedAudio == index
                                          ? AppColors.primaryColor
                                          : Theme.of(context).colorScheme.onSurface,
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: selectedAudio == index
                                    ? AppColors.primaryColor.withOpacity(0.2)
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  selectedAudio == index && isPlaying
                                      ? TablerIcons.player_pause_filled
                                      : TablerIcons.player_play_filled,
                                  color: selectedAudio == index
                                      ? AppColors.primaryColor
                                      : Theme.of(context).colorScheme.onSurface,
                                  size: Theme.of(context).iconTheme.size,
                                ),
                                onPressed: isLoading ? null : () => _playSelectedAudio(index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index != _getController.audioReviewModel.value.data!.result!.length - 1)
                      Divider(
                        thickness: 1,
                        color: AppColors.grey,
                        indent: 15.w,
                        endIndent: 15.w,
                      ),
                  ],
                ),
              SizedBox(height: 120.h),
            ],
          )
              : Column(
            children: [
              AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColors.grey.withOpacity(0.2),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: ComponentSize.backIcons(context),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      TablerIcons.share,
                      color: AppColors.grey.withOpacity(0.5),
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      TablerIcons.bookmark,
                      color: AppColors.grey.withOpacity(0.5),
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const AudioSkeleton(),
            ],
          ),
        ),
      ),
    );
  }
}