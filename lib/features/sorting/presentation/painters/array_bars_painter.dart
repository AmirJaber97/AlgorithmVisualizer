import 'package:flutter/material.dart';

import '../../models/sort_element.dart';

class ArrayBarsPainter extends CustomPainter {
  final List<SortElement> elements;
  final double animationValue;

  ArrayBarsPainter({required this.elements, this.animationValue = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    if (elements.isEmpty) return;

    final barWidth = size.width / elements.length;
    final maxValue = elements.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < elements.length; i++) {
      final element = elements[i];
      final barHeight = (element.value / maxValue) * size.height * 0.9;

      final left = i * barWidth;
      final top = size.height - barHeight;

      final paint = Paint()
        ..color = element.color.withOpacity(animationValue)
        ..style = PaintingStyle.fill;

      final rect = Rect.fromLTWH(left + barWidth * 0.1, top, barWidth * 0.8, barHeight);

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

      canvas.drawRRect(rrect, paint);

      if (barWidth > 30) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: element.value.toString(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: barWidth * 0.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(left + (barWidth - textPainter.width) / 2, top + 8));
      }
    }
  }

  @override
  bool shouldRepaint(ArrayBarsPainter oldDelegate) {
    return oldDelegate.elements != elements || oldDelegate.animationValue != animationValue;
  }
}
