import 'package:get/get.dart';

import '../controllers/audio_controller.dart';
import '../data/models/ayah_model.dart';
import '../data/models/surah_model.dart';
import '../data/services/ayah_service.dart';

class AyahController extends GetxController {
  final _ayahService = Get.find<AyahService>();

  final ayahList = <AyahModel>[].obs;
  final isLoading = false.obs;

  final searchQuery = ''.obs;

  late final SurahModel surah;

  @override
  void onInit() {
    super.onInit();

    surah = Get.arguments as SurahModel;
    fetchAyahList(surah.number);
  }

  @override
  void onClose() {
    stopAudio();
    super.onClose();
  }

  void stopAudio() {
    Get.find<AudioController>().stop();
  }

  Future<void> fetchAyahList(int surahNumber) async {
    stopAudio();

    if (ayahList.isNotEmpty) {
      return;
    }

    try {
      isLoading.value = true;
      final response = await _ayahService.getAyahList(surahNumber);
      if (response.isSuccess) {
        ayahList.value = response.data ?? [];
      } else {
        Get.snackbar('Error', response.status ?? 'Failed to load ayah list');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
