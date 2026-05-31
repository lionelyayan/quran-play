import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle baseStyle;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool bold;
  final bool italic;
  final bool underline;
  final bool strike;
  final double? letterSpacing;
  final double? height;
  final double? fontSize;
  final TextDecoration? decoration;
  final VoidCallback? onTap;

  const AppText(
    this.text, {
    super.key,
    required this.baseStyle,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.strike = false,
    this.letterSpacing,
    this.height,
    this.fontSize,
    this.decoration,
    this.onTap,
  });

  // ── Display ───────────────────────────────────────────────
  factory AppText.displayLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    double? letterSpacing,
    double? height,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h1.copyWith(fontSize: 36),
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      letterSpacing: letterSpacing,
      height: height,
      onTap: onTap,
    );
  }

  factory AppText.displayMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h1.copyWith(fontSize: 30),
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  // ── Headings ──────────────────────────────────────────────
  factory AppText.h1(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    double? letterSpacing,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h1,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      letterSpacing: letterSpacing,
      onTap: onTap,
    );
  }

  factory AppText.h2(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h2,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  factory AppText.h3(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h3,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  factory AppText.h4(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.h4,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  // ── Body ──────────────────────────────────────────────────
  factory AppText.bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.bodyLarge,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  /// Alias untuk bodyMedium — variant paling sering dipakai
  factory AppText.body(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    bool underline = false,
    bool strike = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.bodyMedium,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      underline: underline,
      strike: strike,
      onTap: onTap,
    );
  }

  factory AppText.bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool bold = false,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.bodySmall,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      bold: bold,
      italic: italic,
      onTap: onTap,
    );
  }

  // ── Label ─────────────────────────────────────────────────
  factory AppText.label(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.labelMedium,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      italic: italic,
      onTap: onTap,
    );
  }

  factory AppText.labelSmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.labelSmall,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      onTap: onTap,
    );
  }

  // ── Caption ───────────────────────────────────────────────
  factory AppText.caption(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    bool italic = false,
    VoidCallback? onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.caption,
      color: color,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      italic: italic,
      onTap: onTap,
    );
  }

  // ── Overline ──────────────────────────────────────────────
  factory AppText.overline(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    VoidCallback? onTap,
  }) {
    return AppText(
      text.toUpperCase(),
      key: key,
      baseStyle: AppTextStyles.overline,
      color: color,
      align: align,
      onTap: onTap,
    );
  }

  // ── Link ─────────────────────────────────────────────────
  factory AppText.link(
    String text, {
    Key? key,
    Color? color,
    TextAlign? align,
    int? maxLines,
    required VoidCallback onTap,
  }) {
    return AppText(
      text,
      key: key,
      baseStyle: AppTextStyles.bodyMedium,
      color: color,
      align: align,
      maxLines: maxLines,
      underline: true,
      onTap: onTap,
    );
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Resolusi warna default berdasarkan dark/light mode
    final defaultColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;

    // Resolusi warna link
    final resolvedColor =
        color ??
        (underline
            ? (isDark ? AppColors.darkPrimary : AppColors.primary)
            : defaultColor);

    // Resolusi dekorasi
    TextDecoration resolvedDecoration = TextDecoration.none;
    if (decoration != null) {
      resolvedDecoration = decoration!;
    } else if (underline && strike) {
      resolvedDecoration = TextDecoration.combine([
        TextDecoration.underline,
        TextDecoration.lineThrough,
      ]);
    } else if (underline) {
      resolvedDecoration = TextDecoration.underline;
    } else if (strike) {
      resolvedDecoration = TextDecoration.lineThrough;
    }

    final style = baseStyle.copyWith(
      color: resolvedColor,
      fontWeight: bold ? FontWeight.w700 : baseStyle.fontWeight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: resolvedDecoration,
      decorationColor: resolvedColor,
      letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
      height: height ?? baseStyle.height,
      fontSize: fontSize ?? baseStyle.fontSize,
    );

    final textWidget = Text(
      text,
      style: style,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: textWidget);
    }

    return textWidget;
  }
}
