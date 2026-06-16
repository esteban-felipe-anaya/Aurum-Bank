import 'package:intl/intl.dart';

/// Centralised currency/date formatting. Values are never rendered raw in the
/// UI — always go through these helpers.
abstract final class Formatters {
  static final Map<String, NumberFormat> _currencyCache = {};

  static NumberFormat _currency(String code) {
    return _currencyCache.putIfAbsent(
      code,
      () => NumberFormat.simpleCurrency(name: code),
    );
  }

  /// e.g. 8240.55 USD -> "$8,240.55"
  static String money(double amount, String currencyCode) =>
      _currency(currencyCode).format(amount);

  /// Signed amount for transactions, e.g. -9.99 -> "-$9.99", 12.0 -> "+$12.00".
  static String signedMoney(double amount, String currencyCode) {
    final formatted = _currency(currencyCode).format(amount.abs());
    if (amount > 0) return '+$formatted';
    if (amount < 0) return '-$formatted';
    return formatted;
  }

  /// Compact form for headline figures, e.g. 12500 -> "$12.5K".
  static String compactMoney(double amount, String currencyCode) {
    final symbol = NumberFormat.simpleCurrency(
      name: currencyCode,
    ).currencySymbol;
    return '$symbol${NumberFormat.compact().format(amount)}';
  }

  static String date(DateTime date) =>
      DateFormat.yMMMd().format(date.toLocal());

  static String dateTime(DateTime date) =>
      DateFormat.yMMMd().add_jm().format(date.toLocal());

  static String dayMonth(DateTime date) =>
      DateFormat.MMMd().format(date.toLocal());

  /// Section header for grouped lists, e.g. "Today", "Yesterday" or a date.
  static String relativeDay(DateTime date, {DateTime? now}) {
    final today = now ?? DateTime.now();
    final d = DateTime(date.year, date.month, date.day);
    final t = DateTime(today.year, today.month, today.day);
    final diff = t.difference(d).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat.yMMMd().format(date.toLocal());
  }

  /// "08/28" expiry passthrough (already formatted by API) but trims spaces.
  static String maskedExpiry(String expiry) => expiry.trim();
}
