import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/theme/app_theme.dart';
import '../routes/app_pages.dart';
import '../routes/app_routes.dart';
import 'app_bindings.dart';
import 'app_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // ── App Info ─────────────────────────────────────
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // ── Theme ────────────────────────────────────────
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          // ── Routing ──────────────────────────────────────
          initialRoute: AppRoutes.surah,
          getPages: AppPages.pages,
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),

          // ── Dependency Injection ─────────────────────────
          initialBinding: AppBindings(),

          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
