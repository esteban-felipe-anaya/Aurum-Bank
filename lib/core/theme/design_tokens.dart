import 'package:flutter/widgets.dart';

/// Design tokens — the single source of truth for spacing, radii, motion and
/// layout breakpoints. Widgets must never hardcode these values inline.
abstract final class Spacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const EdgeInsets pageH = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets page = EdgeInsets.all(lg);
}

abstract final class Radii {
  static const Radius xs = Radius.circular(8);
  static const Radius sm = Radius.circular(12);
  static const Radius md = Radius.circular(16);
  static const Radius lg = Radius.circular(24);
  static const Radius xl = Radius.circular(32);

  static const BorderRadius cardSm = BorderRadius.all(sm);
  static const BorderRadius card = BorderRadius.all(md);
  static const BorderRadius cardLg = BorderRadius.all(lg);
  static const BorderRadius pill = BorderRadius.all(Radius.circular(999));
}

abstract final class Motion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

/// Responsive breakpoints (in logical pixels / dp) following Material 3
/// window size classes.
abstract final class Breakpoints {
  /// Below this width → compact (phone): bottom NavigationBar.
  static const double medium = 600;

  /// Below this → medium (tablet): NavigationRail.
  /// At or above → expanded (desktop/web): extended NavigationRail + multipane.
  static const double expanded = 840;

  static bool isCompact(double width) => width < medium;
  static bool isMedium(double width) => width >= medium && width < expanded;
  static bool isExpanded(double width) => width >= expanded;
}

/// Maximum content width on very large screens so layouts don't stretch.
const double kMaxContentWidth = 1200;
