import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';

/// Wraps [child] in an animated shimmer sweep. Place [SkeletonBox]es inside as
/// placeholders while content loads.
class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest;
    final highlight = Color.alphaBlend(
      scheme.onSurface.withValues(alpha: 0.06),
      base,
    );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.1, 0.5, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: _SlideTransform(_controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlideTransform extends GradientTransform {
  const _SlideTransform(this.percent);
  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dx = (percent * 2 - 1) * bounds.width;
    return Matrix4.translationValues(dx, 0, 0);
  }
}

/// A neutral placeholder block; tint comes from the enclosing [Shimmer].
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.width, this.height = 16, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// A ready-made shimmering list of generic rows.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: List.generate(
          itemCount,
          (_) => Padding(
            padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
            child: Row(
              children: [
                const SkeletonBox(width: 44, height: 44, radius: 14),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SkeletonBox(width: 160, height: 14),
                      SizedBox(height: Spacing.sm),
                      SkeletonBox(width: 90, height: 12),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.md),
                const SkeletonBox(width: 60, height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
