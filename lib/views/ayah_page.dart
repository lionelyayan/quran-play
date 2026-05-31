import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/audio_controller.dart';
import '../controllers/ayah_controller.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/app_card.dart';
import '../core/widgets/app_no_data.dart';
import '../core/widgets/app_shimmer.dart';
import '../core/widgets/app_text.dart';
import '../core/widgets/surah_number.dart';
import '../data/models/surah_model.dart';

class AyahPage extends GetView<AyahController> {
  AyahPage({super.key});

  final _scrollController = ScrollController();
  final _audio = Get.find<AudioController>();

  final SurahModel surah = Get.arguments as SurahModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.bodyLarge(
          surah.englishName,
          color: Colors.white,
          bold: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
        child: Column(
          children: [
            AppCard.gradient(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.bodyLarge(
                    surah.englishName,
                    color: Colors.white,
                    bold: true,
                  ),
                  AppText.body(
                    surah.englishNameTranslation,
                    color: Colors.white70,
                  ),
                  Divider(
                    color: Colors.white54,
                    height: 20.h,
                    indent: 90.w,
                    endIndent: 90.w,
                  ),
                  AppText.body(
                    '${surah.revelationType} • ${surah.numberOfAyahs} Ayahs',
                    color: Colors.white70,
                  ),
                  SizedBox(height: 20.h),
                  Obx(() {
                    final total = _audio.totalTracks.value;
                    final idx = _audio.currentIndex.value;
                    final isPlaylistActive = total > 0;
                    final playing = isPlaylistActive && _audio.isPlaying.value;
                    final loading =
                        isPlaylistActive && _audio.isBuffering.value;
                    final current = idx + 1;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: _audio.hasPrevious
                                  ? _audio.previous
                                  : null,
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                color: _audio.hasPrevious
                                    ? Colors.white
                                    : Colors.white30,
                                size: 28.sp,
                              ),
                            ),

                            SizedBox(width: 8.w),

                            GestureDetector(
                              onTap: () => _audio.togglePlaylist(
                                controller.ayahList
                                    .map((a) => a.audio)
                                    .toList(),
                              ),
                              child: Container(
                                width: 52.w,
                                height: 52.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.2,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: loading
                                    ? Padding(
                                        padding: EdgeInsets.all(14.w),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: AppColors.primary,
                                        ),
                                      )
                                    : Icon(
                                        playing
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: AppColors.primary,
                                        size: 30.sp,
                                      ),
                              ),
                            ),

                            SizedBox(width: 8.w),

                            IconButton(
                              onPressed: _audio.hasNext ? _audio.next : null,
                              icon: Icon(
                                Icons.skip_next_rounded,
                                color: _audio.hasNext
                                    ? Colors.white
                                    : Colors.white30,
                                size: 28.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        if (isPlaylistActive) ...[
                          AppText.caption(
                            'Ayah $current of $total',
                            color: Colors.white70,
                          ),
                          SizedBox(height: 4.h),
                          Obx(() {
                            final pos = _audio.position.value;
                            final dur = _audio.duration.value;
                            final maxMs = dur.inMilliseconds.toDouble();
                            final valMs = maxMs > 0
                                ? (pos.inMilliseconds.toDouble()).clamp(
                                    0.0,
                                    maxMs,
                                  )
                                : 0.0;

                            String fmt(Duration d) {
                              final m = d.inMinutes
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, '0');
                              final s = d.inSeconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, '0');
                              return '$m:$s';
                            }

                            return Column(
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 3,
                                    activeTrackColor: Colors.white,
                                    inactiveTrackColor: Colors.white30,
                                    thumbColor: Colors.white,
                                    overlayColor: Colors.white24,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 5,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 12,
                                    ),
                                  ),
                                  child: Slider(
                                    value: valMs,
                                    min: 0,
                                    max: maxMs > 0 ? maxMs : 1,
                                    onChanged: maxMs > 0
                                        ? (v) => _audio.seek(
                                            Duration(milliseconds: v.toInt()),
                                          )
                                        : null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText.caption(
                                        fmt(pos),
                                        color: Colors.white70,
                                      ),
                                      AppText.caption(
                                        fmt(dur),
                                        color: Colors.white70,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ],
                    );
                  }),
                ],
              ),
            ),
            Obx(() {
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchAyahList(surah.number),
                  color: Theme.of(context).colorScheme.primary,
                  child: Scrollbar(
                    controller: _scrollController,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsetsGeometry.all(15.h),
                      child: controller.isLoading.value
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 10.h,
                              ),
                              child: AppShimmer.ayahList(itemCount: 8),
                            )
                          : controller.ayahList.isEmpty
                          ? AppNoData(
                              message: 'No Ayah data available.',
                              actionLabel: 'Reload',
                              onAction: () =>
                                  controller.fetchAyahList(surah.number),
                            )
                          : Column(
                              children: [
                                if (surah.number != 1)
                                  AppText.h2(
                                    'بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                    bold: true,
                                  ),
                                if (surah.number != 1) SizedBox(height: 20.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.ayahList.length,
                                  itemBuilder: (context, index) {
                                    final ayah = controller.ayahList[index];

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15.h,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    SurahNumberWidget.circleOutline(
                                                      number:
                                                          ayah.numberInSurah,
                                                      size: 30.w,
                                                    ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Obx(() {
                                                    final isActive = _audio
                                                        .isCurrentTrack(
                                                          ayah.audio,
                                                        );
                                                    return AppText.h3(
                                                      ayah.textArabic,
                                                      bold: true,
                                                      align: TextAlign.right,
                                                      color: isActive
                                                          ? AppColors.primary
                                                          : null,
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          AppText.body(
                                            '${ayah.translation} • (${ayah.numberInSurah})',
                                            color: Colors.grey[700],
                                            italic: true,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
