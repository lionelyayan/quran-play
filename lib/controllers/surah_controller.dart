import 'package:get/get.dart';

import '../data/models/surah_model.dart';
import '../data/services/surah_service.dart';

class SurahController extends GetxController {
  final _surahService = Get.find<SurahService>();

  final surahList = <SurahModel>[].obs;
  final filteredSurahList = <SurahModel>[].obs;
  final isLoading = false.obs;

  final searchQuery = ''.obs;

  late Worker _debounceWorker;

  @override
  void onInit() {
    super.onInit();

    fetchSurahList();

    _debounceWorker = debounce(
      searchQuery,
      (value) => _applyFilter(value),
      time: const Duration(milliseconds: 100),
    );
  }

  @override
  void onClose() {
    _debounceWorker.dispose();
    super.onClose();
  }

  Future<void> fetchSurahList() async {
    try {
      isLoading.value = true;
      final response = await _surahService.getSurahList();
      if (response.isSuccess) {
        surahList.value = response.data ?? [];
        filteredSurahList.value = response.data ?? [];
      } else {
        Get.snackbar('Error', response.status ?? 'Failed to load surah list');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterSurahList(String query) {
    searchQuery.value = query;
  }

  void _applyFilter(String query) {
    isLoading.value = false;

    if (query.isEmpty) {
      filteredSurahList.value = List.from(surahList);
      return;
    }

    filteredSurahList.value = surahList.where((surah) {
      final keyword = query.toLowerCase();

      return surah.name.toLowerCase().contains(keyword) ||
          surah.englishName.toLowerCase().contains(keyword) ||
          surah.englishNameTranslation.toLowerCase().contains(keyword);
    }).toList();
  }
}
