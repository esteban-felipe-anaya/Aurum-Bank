import 'package:flutter/material.dart';

/// Parses API color strings ("#RRGGBB", "#AARRGGBB" or "0xFFRRGGBB") into a
/// [Color]. Falls back to [fallback] for malformed input so the UI never
/// crashes on bad backend data.
Color colorFromHex(String? hex, {Color fallback = const Color(0xFF6C5CE7)}) {
  if (hex == null || hex.isEmpty) return fallback;
  var value = hex.trim();
  if (value.startsWith('#')) value = value.substring(1);
  if (value.startsWith('0x') || value.startsWith('0X')) {
    value = value.substring(2);
  }
  if (value.length == 6) value = 'FF$value'; // assume opaque
  final parsed = int.tryParse(value, radix: 16);
  return parsed == null ? fallback : Color(parsed);
}
