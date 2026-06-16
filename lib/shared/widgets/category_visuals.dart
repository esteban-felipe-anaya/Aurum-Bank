import 'package:flutter/material.dart';

/// Maps a transaction category key to an icon + accent color. Centralised so
/// the same visual language is used across transactions, insights and details.
class CategoryVisual {
  const CategoryVisual(this.icon, this.color, this.label);
  final IconData icon;
  final Color color;
  final String label;
}

const Map<String, CategoryVisual> _categoryVisuals = {
  'groceries': CategoryVisual(
    Icons.local_grocery_store_rounded,
    Color(0xFF00B894),
    'Groceries',
  ),
  'dining': CategoryVisual(
    Icons.restaurant_rounded,
    Color(0xFFE17055),
    'Dining',
  ),
  'subscriptions': CategoryVisual(
    Icons.subscriptions_rounded,
    Color(0xFF6C5CE7),
    'Subscriptions',
  ),
  'transport': CategoryVisual(
    Icons.directions_car_rounded,
    Color(0xFF0984E3),
    'Transport',
  ),
  'shopping': CategoryVisual(
    Icons.shopping_bag_rounded,
    Color(0xFFE84393),
    'Shopping',
  ),
  'utilities': CategoryVisual(
    Icons.bolt_rounded,
    Color(0xFFFDCB6E),
    'Utilities',
  ),
  'entertainment': CategoryVisual(
    Icons.movie_rounded,
    Color(0xFFA29BFE),
    'Entertainment',
  ),
  'health': CategoryVisual(Icons.favorite_rounded, Color(0xFFD63031), 'Health'),
  'travel': CategoryVisual(
    Icons.flight_takeoff_rounded,
    Color(0xFF00CEC9),
    'Travel',
  ),
  'income': CategoryVisual(
    Icons.arrow_downward_rounded,
    Color(0xFF00B894),
    'Income',
  ),
  'transfers': CategoryVisual(
    Icons.swap_horiz_rounded,
    Color(0xFF636E72),
    'Transfers',
  ),
};

CategoryVisual visualForCategory(String category) {
  return _categoryVisuals[category.toLowerCase()] ??
      CategoryVisual(
        Icons.receipt_long_rounded,
        const Color(0xFF636E72),
        _titleCase(category),
      );
}

String categoryLabel(String category) => visualForCategory(category).label;

String _titleCase(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
