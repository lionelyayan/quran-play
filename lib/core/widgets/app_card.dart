import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

enum AppCardVariant { solid, gradient, outlined, flat }

class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Widget? header;
  final Widget? footer;

  // ── Solid (default) ──────────────────────────────────────
  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.border,
    this.boxShadow,
    this.header,
    this.footer,
  }) : variant = AppCardVariant.solid,
       gradientColors = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight;

  // ── Gradient ─────────────────────────────────────────────
  const AppCard.gradient({
    super.key,
    required this.child,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.border,
    this.boxShadow,
    this.header,
    this.footer,
  }) : variant = AppCardVariant.gradient,
       backgroundColor = null;

  // ── Outlined ─────────────────────────────────────────────
  const AppCard.outlined({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.border,
    this.header,
    this.footer,
  }) : variant = AppCardVariant.outlined,
       gradientColors = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       elevation = 0,
       boxShadow = null;

  // ── Flat (tanpa elevasi / shadow) ────────────────────────
  const AppCard.flat({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.header,
    this.footer,
  }) : variant = AppCardVariant.flat,
       gradientColors = null,
       gradientBegin = Alignment.topLeft,
       gradientEnd = Alignment.bottomRight,
       elevation = 0,
       border = null,
       boxShadow = null;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = borderRadius ?? AppDimens.radiusMd;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: _buildDecoration(context, isDark, radius),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(radius),
          splashColor: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : AppColors.primary.withValues(alpha: 0.08),
          highlightColor: isDark
              ? Colors.white.withValues(alpha: 0.04)
              : AppColors.primary.withValues(alpha: 0.04),
          child: Padding(
            padding: padding ?? EdgeInsets.all(AppDimens.md.w),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (header == null && footer == null) return child;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) ...[header!, SizedBox(height: AppDimens.sm.h)],
        child,
        if (footer != null) ...[SizedBox(height: AppDimens.sm.h), footer!],
      ],
    );
  }

  BoxDecoration _buildDecoration(
    BuildContext context,
    bool isDark,
    double radius,
  ) {
    switch (variant) {
      case AppCardVariant.solid:
        return BoxDecoration(
          color:
              backgroundColor ?? (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(radius),
          border: border,
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.06),
                  blurRadius: elevation ?? AppDimens.elevationSm,
                  offset: const Offset(0, 2),
                ),
              ],
        );

      case AppCardVariant.gradient:
        final colors =
            gradientColors ??
            (isDark
                ? [AppColors.darkPrimary, AppColors.darkPrimaryDark]
                : [AppColors.primary, AppColors.primaryDark]);
        return BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: gradientBegin,
            end: gradientEnd,
          ),
          borderRadius: BorderRadius.circular(radius),
          border: border,
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: colors.first.withValues(alpha: isDark ? 0.3 : 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
        );

      case AppCardVariant.outlined:
        return BoxDecoration(
          color:
              backgroundColor ?? (isDark ? AppColors.darkCard : Colors.white),
          borderRadius: BorderRadius.circular(radius),
          border:
              border ??
              Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.border,
                width: 1.5,
              ),
        );

      case AppCardVariant.flat:
        return BoxDecoration(
          color:
              backgroundColor ??
              (isDark ? AppColors.darkCard : AppColors.surface),
          borderRadius: BorderRadius.circular(radius),
        );
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  PRESET FACTORY CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════

  /// Card info/banner bergradient brand color + ikon + teks putih
  static Widget banner({
    Key? key,
    required String title,
    String? subtitle,
    IconData? icon,
    List<Color>? gradientColors,
    VoidCallback? onTap,
    Widget? trailing,
    EdgeInsetsGeometry? margin,
  }) {
    return _AppBannerCard(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      gradientColors: gradientColors,
      onTap: onTap,
      trailing: trailing,
      margin: margin,
    );
  }

  /// Card statistik dengan angka besar + label
  static Widget stat({
    Key? key,
    required String value,
    required String label,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    VoidCallback? onTap,
    EdgeInsetsGeometry? margin,
  }) {
    return _AppStatCard(
      key: key,
      value: value,
      label: label,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      onTap: onTap,
      margin: margin,
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  PRESET: Banner Card (Gradient)
// ═══════════════════════════════════════════════════════════
class _AppBannerCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;

  const _AppBannerCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.gradientColors,
    this.onTap,
    this.trailing,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppCard.gradient(
      gradientColors: gradientColors,
      onTap: onTap,
      margin: margin,
      padding: EdgeInsets.all(AppDimens.md.w),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isDark ? 0.15 : 0.2),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            SizedBox(width: AppDimens.md.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: AppDimens.xxs.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[SizedBox(width: AppDimens.sm.w), trailing!],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  PRESET: Stat Card (Solid)
// ═══════════════════════════════════════════════════════════
class _AppStatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const _AppStatCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        iconColor ?? (isDark ? AppColors.darkPrimary : AppColors.primary);

    return AppCard(
      backgroundColor: backgroundColor,
      onTap: onTap,
      margin: margin,
      padding: EdgeInsets.all(AppDimens.md.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(AppDimens.radiusSm),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
          if (icon != null) SizedBox(height: AppDimens.sm.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimens.xxs.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
