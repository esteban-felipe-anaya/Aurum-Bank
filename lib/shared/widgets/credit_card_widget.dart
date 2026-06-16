import 'package:flutter/material.dart';

import '../../core/theme/design_tokens.dart';
import '../../core/utils/color_utils.dart';
import '../../data/models/bank_card.dart';

/// A polished, brand-styled payment card. Used in the dashboard carousel and
/// on the card detail screen. Shows a "frozen" overlay when applicable.
class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.card,
    this.balanceLabel,
    this.onTap,
    this.heroTag,
  });

  final BankCard card;
  final String? balanceLabel;
  final VoidCallback? onTap;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final base = colorFromHex(card.color);
    final gradientEnd = Color.lerp(base, Colors.black, 0.35)!;
    final onCard = Colors.white;

    Widget content = AspectRatio(
      aspectRatio: 1.586, // ISO/IEC 7810 ID-1 ratio
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Radii.cardLg,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [base, gradientEnd],
          ),
          boxShadow: [
            BoxShadow(
              color: base.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.contactless_rounded,
                    color: onCard.withValues(alpha: 0.9),
                  ),
                  Text(
                    card.brand.toUpperCase(),
                    style: TextStyle(
                      color: onCard,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (balanceLabel != null)
                Text(
                  balanceLabel!,
                  style: TextStyle(
                    color: onCard,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              const SizedBox(height: Spacing.sm),
              Text(
                '••••  ••••  ••••  ${card.last4}',
                style: TextStyle(
                  color: onCard.withValues(alpha: 0.95),
                  fontSize: 18,
                  letterSpacing: 2,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: Spacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CardField(
                    label: 'CARD HOLDER',
                    value: card.holder,
                    onCard: onCard,
                  ),
                  _CardField(
                    label: 'EXPIRES',
                    value: card.expiry,
                    onCard: onCard,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (card.frozen) {
      content = Stack(
        children: [
          content,
          Positioned.fill(
            child: ClipRRect(
              borderRadius: Radii.cardLg,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.ac_unit_rounded, color: Colors.white, size: 32),
                    SizedBox(height: Spacing.sm),
                    Text(
                      'Frozen',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (heroTag != null) {
      content = Hero(
        tag: heroTag!,
        child: Material(type: MaterialType.transparency, child: content),
      );
    }

    if (onTap != null) {
      content = GestureDetector(onTap: onTap, child: content);
    }

    return content;
  }
}

class _CardField extends StatelessWidget {
  const _CardField({
    required this.label,
    required this.value,
    required this.onCard,
  });
  final String label;
  final String value;
  final Color onCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: onCard.withValues(alpha: 0.7),
            fontSize: 9,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: onCard,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
