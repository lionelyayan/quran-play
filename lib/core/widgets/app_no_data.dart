import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import 'app_text.dart';

class AppNoData extends StatelessWidget {
  final String? title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showImage;
  final double? imageSize;
  final String imagePath;

  const AppNoData({
    super.key,
    this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.showImage = true,
    this.imageSize,
    this.imagePath = 'assets/icons/no_data.png',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;
    final imgSize = imageSize ?? 180.w;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Gambar ─────────────────────────────────────
            if (showImage) ...[
              Image.asset(
                imagePath,
                width: imgSize,
                height: imgSize,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.inbox_rounded,
                  size: 80.sp,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textHint,
                ),
              ),
              SizedBox(height: AppDimens.md.h),
            ],

            // ── Judul ──────────────────────────────────────
            AppText.h4(title ?? 'No Data', align: TextAlign.center),
            SizedBox(height: AppDimens.xs.h),

            // ── Pesan ──────────────────────────────────────
            AppText.body(
              message ?? 'No data available at the moment.',
              color: secondaryColor,
              align: TextAlign.center,
              maxLines: 3,
            ),

            // ── Tombol Aksi (opsional) ─────────────────────
            if (onAction != null) ...[
              SizedBox(height: AppDimens.lg.h),
              SizedBox(
                width: 160.w,
                child: FilledButton.icon(
                  onPressed: onAction,
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(actionLabel ?? 'Reload'),
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark
                        ? AppColors.darkPrimary
                        : AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.md.w,
                      vertical: AppDimens.sm.h,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
