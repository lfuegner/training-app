import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/shared/models/game_result.dart';

/// A square split diagonally from bottom-left to top-right.
/// The bottom-left half is transparent (card background shows through),
/// the top-right half is colored: green for win, red for loss, yellow for draw.
class ResultIndicator extends StatelessWidget {
  final GameResult result;
  final double size;

  const ResultIndicator({
    super.key,
    required this.result,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    if (result == GameResult.pending) {
      return SizedBox(width: size, height: size);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CustomPaint(
        size: Size(size, size),
        painter: _SplitSquarePainter(result: result),
      ),
    );
  }
}

class _SplitSquarePainter extends CustomPainter {
  final GameResult result;

  _SplitSquarePainter({required this.result});

  Color get _resultColor {
    switch (result) {
      case GameResult.win:
        return AppColors.winGreen;
      case GameResult.loss:
        return AppColors.lossRed;
      case GameResult.draw:
        return AppColors.undecidedAmber;
      case GameResult.pending:
        return Colors.transparent;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw border for the full square
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      borderPaint,
    );
    // Draw the diagonal line from bottom-left to top-right
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      borderPaint,
    );
    // Fill the top-right triangle with the result color
    final Paint fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _resultColor;
    final Path topRight = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(topRight, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _SplitSquarePainter oldDelegate) =>
      result != oldDelegate.result;
}
