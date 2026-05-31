import 'package:get/get.dart';

import '../views/ayah_page.dart';
import '../views/surah_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.surah, page: () => SurahPage()),
    GetPage(name: AppRoutes.ayah, page: () => AyahPage()),
  ];
}
