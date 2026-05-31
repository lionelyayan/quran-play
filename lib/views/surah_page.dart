import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/surah_controller.dart';
import '../core/widgets/app_card.dart';
import '../core/widgets/app_no_data.dart';
import '../core/widgets/app_shimmer.dart';
import '../core/widgets/app_text.dart';
import '../core/widgets/app_text_field.dart';
import '../core/widgets/surah_number.dart';
import '../routes/app_routes.dart';

class SurahPage extends GetView<SurahController> {
  SurahPage({super.key});

  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.bodyLarge('Quran Play', color: Colors.white, bold: true),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AppCard.gradient(
                    width: double.infinity,
                    child: SizedBox(
                      height: 50.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.bodyLarge(
                            'Begin Your Quran Journey',
                            color: Colors.white,
                            bold: true,
                          ),
                          const Spacer(),
                          AppText.bodySmall(
                            'Explore and listen to ${controller.surahList.length} Surahs',
                            color: Colors.white70,
                            italic: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    bottom: -30.h,
                    child: Transform.rotate(
                      angle: 0.15,
                      child: Image.asset(
                        'assets/icons/quran.png',
                        width: 110.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              AppTextField(
                controller: _searchController,
                hint: 'Search name or translation of Surah',
                prefixIcon: Icons.search,
                onChanged: (value) {
                  controller.filterSurahList(value);
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchSurahList(),
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
                              child: AppShimmer.list(itemCount: 10),
                            )
                          : controller.surahList.isEmpty
                          ? AppNoData(
                              message: 'No Surah data available.',
                              actionLabel: 'Reload',
                              onAction: controller.fetchSurahList,
                            )
                          : controller.filteredSurahList.isEmpty
                          ? AppNoData(
                              message:
                                  'No results found for "${controller.searchQuery.value}".',
                              actionLabel: 'Reset Search',
                              onAction: () {
                                _searchController.clear();
                                controller.filterSurahList('');
                                controller.isLoading.value = true;
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.filteredSurahList.length,
                              itemBuilder: (context, index) {
                                final surah =
                                    controller.filteredSurahList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.ayah,
                                      arguments: surah,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 12.h,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SurahNumberWidget(
                                          number: surah.number,
                                          size: 30.w,
                                        ),
                                        SizedBox(width: 20.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText.h4(surah.englishName),
                                              AppText.bodySmall(
                                                '${surah.englishNameTranslation} • ${surah.numberOfAyahs} Ayahs',
                                                color: Colors.grey,
                                                italic: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        AppText.bodyLarge(surah.name, bold: true,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
