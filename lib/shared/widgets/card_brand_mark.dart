import 'package:flutter/material.dart';

/// Renders a payment network's brand mark in its official visual style:
/// Mastercard's interlocking circles, the Visa wordmark, or the American
/// Express badge. Falls back to an uppercase text label for unknown brands.
///
/// Designed to sit on a dark card surface — see [CreditCardWidget].
class CardBrandMark extends StatelessWidget {
  const CardBrandMark({super.key, required this.brand, this.height = 34});

  final String brand;
  final double height;

  @override
  Widget build(BuildContext context) {
    switch (brand.trim().toLowerCase()) {
      case 'mastercard':
      case 'master':
      case 'mc':
        return _Mastercard(height: height);
      case 'visa':
        return _Visa(height: height);
      case 'amex':
      case 'american express':
      case 'americanexpress':
        return _Amex(height: height);
      default:
        return Text(
          brand.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            fontSize: height * 0.5,
          ),
        );
    }
  }
}

class _Mastercard extends StatelessWidget {
  const _Mastercard({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    // The interlocking circles have a ~1.55 width:height ratio.
    return SizedBox(
      height: height,
      width: height * 1.55,
      child: CustomPaint(painter: _MastercardPainter()),
    );
  }
}

class _MastercardPainter extends CustomPainter {
  // Official Mastercard palette.
  static const _red = Color(0xFFEB001B);
  static const _amber = Color(0xFFF79E1B);
  static const _overlap = Color(0xFFFF5F00);

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.height / 2;
    final cy = size.height / 2;
    final leftC = Offset(size.width / 2 - r * 0.55, cy);
    final rightC = Offset(size.width / 2 + r * 0.55, cy);

    canvas.drawCircle(leftC, r, Paint()..color = _red);
    canvas.drawCircle(rightC, r, Paint()..color = _amber);

    // The lens-shaped intersection painted in the brand's overlap orange.
    final leftPath = Path()
      ..addOval(Rect.fromCircle(center: leftC, radius: r));
    canvas.save();
    canvas.clipPath(leftPath);
    canvas.drawCircle(rightC, r, Paint()..color = _overlap);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Visa extends StatelessWidget {
  const _Visa({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    // Approximates the Visa wordmark: bold, slightly italic, tight tracking,
    // with the signature gold understroke on the "V".
    return Text(
      'VISA',
      style: TextStyle(
        color: Colors.white,
        fontSize: height * 0.82,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        letterSpacing: height * 0.04,
        height: 1,
        shadows: const [
          Shadow(color: Color(0x55000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
    );
  }
}

class _Amex extends StatelessWidget {
  const _Amex({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    // American Express blue badge with the wordmark.
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: height * 0.28),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF006FCF),
        borderRadius: BorderRadius.circular(height * 0.16),
      ),
      child: Text(
        'AMEX',
        style: TextStyle(
          color: Colors.white,
          fontSize: height * 0.42,
          fontWeight: FontWeight.w800,
          letterSpacing: height * 0.04,
          height: 1,
        ),
      ),
    );
  }
}
