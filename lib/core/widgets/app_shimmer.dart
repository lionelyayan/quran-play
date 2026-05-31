import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppShimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AppShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
  });

  // ── Preset: Box ──────────────────────────────────────────
  static Widget box({
    Key? key,
    double? width,
    double? height,
    bool isCircle = false,
    double? borderRadius,
  }) {
    return AppShimmer(
      key: key,
      child: _ShimmerBox(
        width: width,
        height: height,
        isCircle: isCircle,
        borderRadius: borderRadius,
      ),
    );
  }

  // ── Preset: Line (teks) ───────────────────────────────────
  static Widget line({Key? key, double? width, double height = 14}) {
    return AppShimmer(
      key: key,
      child: _ShimmerBox(
        width: width,
        height: height,
        borderRadius: AppDimens.radiusSm,
      ),
    );
  }

  // ── Preset: Card ─────────────────────────────────────────
  static Widget card({Key? key, double? width, double height = 120}) {
    return AppShimmer(
      key: key,
      child: _ShimmerBox(
        width: width ?? double.infinity,
        height: height,
        borderRadius: AppDimens.radiusMd,
      ),
    );
  }

  // ── Preset: List Item (avatar + dua baris teks) ──────────
  static Widget listItem({Key? key}) {
    return AppShimmer(
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Nomor surah (diamond box)
            _ShimmerBox(width: 30.w, height: 30.w),
            SizedBox(width: 16.w),
            // Teks kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(
                    width: double.infinity,
                    height: 14,
                    borderRadius: AppDimens.radiusSm,
                  ),
                  SizedBox(height: 6.h),
                  _ShimmerBox(
                    width: 160.w,
                    height: 11,
                    borderRadius: AppDimens.radiusSm,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Arabic text placeholder
            _ShimmerBox(
              width: 50.w,
              height: 16,
              borderRadius: AppDimens.radiusSm,
            ),
          ],
        ),
      ),
    );
  }

  // ── Preset: List (banyak item) ────────────────────────────
  static Widget list({
    Key? key,
    int itemCount = 6,
    Widget Function(int index)? itemBuilder,
  }) {
    return Column(
      key: key,
      children: List.generate(
        itemCount,
        (i) => itemBuilder?.call(i) ?? AppShimmer.listItem(),
      ),
    );
  }

  // ── Preset: Ayah Item ─────────────────────────────────────
  // Cocok untuk layout di ayah_page:
  //   1. Play button (right-aligned)
  //   2. Circle nomor + teks Arab (right-aligned, panjang)
  //   3. Dua baris terjemahan
  static Widget ayahItem({Key? key}) {
    return AppShimmer(
      key: key,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Play button placeholder (right-aligned)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ShimmerBox(
                    width: 22.w,
                    height: 22.w,
                    isCircle: true,
                  ),
                  SizedBox(width: 6.w),
                  _ShimmerBox(
                    width: 32.w,
                    height: 12,
                    borderRadius: AppDimens.radiusSm,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Nomor circle + teks arab
            Row(
              children: [
                _ShimmerBox(
                  width: 30.w,
                  height: 30.w,
                  isCircle: true,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _ShimmerBox(
                          width: double.infinity,
                          height: 18,
                          borderRadius: AppDimens.radiusSm,
                        ),
                        SizedBox(height: 6.h),
                        _ShimmerBox(
                          width: 200.w,
                          height: 18,
                          borderRadius: AppDimens.radiusSm,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Terjemahan — 2 baris
            _ShimmerBox(
              width: double.infinity,
              height: 12,
              borderRadius: AppDimens.radiusSm,
            ),
            SizedBox(height: 5.h),
            _ShimmerBox(
              width: 220.w,
              height: 12,
              borderRadius: AppDimens.radiusSm,
            ),
          ],
        ),
      ),
    );
  }

  // ── Preset: Ayah List (banyak ayah item) ─────────────────
  static Widget ayahList({Key? key, int itemCount = 6}) {
    return Column(
      key: key,
      children: List.generate(itemCount, (_) => AppShimmer.ayahItem()),
    );
  }

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final base = isDark ? AppColors.darkShimmerBase : AppColors.shimmerBase;
    final highlight = isDark
        ? AppColors.darkShimmerHighlight
        : AppColors.shimmerHighlight;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(_animation.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(base, BlendMode.srcIn),
        child: widget.child,
      ),
    );
  }
}

/// Transform untuk menggeser gradient secara horizontal
class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

/// Box kosong sebagai placeholder shape
class _ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isCircle;
  final double? borderRadius;

  const _ShimmerBox({
    this.width,
    this.height,
    this.isCircle = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white, // akan di-override ShaderMask
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle
            ? null
            : BorderRadius.circular(borderRadius ?? AppDimens.radiusXs),
      ),
    );
  }
}
