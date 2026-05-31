import 'package:get/get.dart';

import '../controllers/audio_controller.dart';
import '../controllers/ayah_controller.dart';
import '../controllers/surah_controller.dart';
import '../core/network/dio_client.dart';
import '../data/services/ayah_service.dart';
import '../data/services/surah_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // ── Network ───────────────────────────────────────────
    Get.put<DioClient>(DioClient(), permanent: true);

    // ── Services ──────────────────────────────────────────
    Get.lazyPut<SurahService>(() => SurahService(), fenix: true);
    Get.lazyPut<AyahService>(() => AyahService(), fenix: true);

    // ── Controllers ───────────────────────────────────────
    Get.put<AudioController>(AudioController(), permanent: true);
    Get.lazyPut<SurahController>(() => SurahController(), fenix: true);
    Get.lazyPut<AyahController>(() => AyahController(), fenix: true);
  }
}

