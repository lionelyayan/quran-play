import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

/// ============================================================
/// SurahNumberWidget
/// ============================================================
/// Widget nomor surah dengan 3 varian:
///
///   // Diamond (default) — kotak diputar 45°
///   SurahNumberWidget(number: 1)
///
///   // Circle — lingkaran solid dengan background
///   SurahNumberWidget.circle(number: 1)
///
///   // Circle Outline — lingkaran dengan border saja
///   SurahNumberWidget.circleOutline(number: 1)
///
/// Ukuran bisa dikustomisasi:
///   SurahNumberWidget(number: 1, size: 36.w)
///   SurahNumberWidget.circle(number: 1, size: 40.w)
///   SurahNumberWidget.circleOutline(number: 1, size: 36.w)
/// ============================================================
enum SurahNumberVariant { diamond, circle, circleOutline }

class SurahNumberWidget extends StatelessWidget {
  final int number;
  final double? size;
  final SurahNumberVariant variant;
  final double? borderWidth;

  // ── Diamond (default) ─────────────────────────────────────
  const SurahNumberWidget({
    super.key,
    required this.number,
    this.size,
    this.borderWidth,
  }) : variant = SurahNumberVariant.diamond;

  // ── Circle ────────────────────────────────────────────────
  const SurahNumberWidget.circle({
    super.key,
    required this.number,
    this.size,
    this.borderWidth,
  }) : variant = SurahNumberVariant.circle;

  // ── Circle Outline ────────────────────────────────────────
  const SurahNumberWidget.circleOutline({
    super.key,
    required this.number,
    this.size,
    this.borderWidth,
  }) : variant = SurahNumberVariant.circleOutline;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case SurahNumberVariant.diamond:
        return _DiamondNumber(number: number, size: size);
      case SurahNumberVariant.circle:
        return _CircleNumber(number: number, size: size);
      case SurahNumberVariant.circleOutline:
        return _CircleOutlineNumber(
          number: number,
          size: size,
          borderWidth: borderWidth,
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────
//  Variant: Diamond (kotak diputar 45°)
// ─────────────────────────────────────────────────────────────
class _DiamondNumber extends StatelessWidget {
  final int number;
  final double? size;

  const _DiamondNumber({required this.number, this.size});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkPrimary : AppColors.primary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;
    final boxSize = size ?? 36.w;

    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Center(
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Variant: Circle (lingkaran solid)
// ─────────────────────────────────────────────────────────────
class _CircleNumber extends StatelessWidget {
  final int number;
  final double? size;

  const _CircleNumber({required this.number, this.size});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? AppColors.darkPrimaryLight
        : AppColors.primaryLight.withValues(alpha: 0.25);
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;
    final boxSize = size ?? 36.w;

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Variant: Circle Outline (lingkaran dengan border saja)
// ─────────────────────────────────────────────────────────────
class _CircleOutlineNumber extends StatelessWidget {
  final int number;
  final double? size;
  final double? borderWidth;

  const _CircleOutlineNumber({
    required this.number,
    this.size,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkPrimary : AppColors.primary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;
    final boxSize = size ?? 36.w;

    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth ?? 1.2),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 12.sp,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
