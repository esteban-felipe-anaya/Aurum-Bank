import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';

/// Centers and constrains content on large screens so layouts don't stretch
/// edge-to-edge on desktop/web.
class MaxWidthBody extends StatelessWidget {
  const MaxWidthBody({
    super.key,
    required this.child,
    this.maxWidth = kMaxContentWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
