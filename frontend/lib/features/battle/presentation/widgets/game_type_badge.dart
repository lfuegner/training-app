import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/shared/models/game_type.dart';

/// A pill-shaped badge showing the game type with dark green border and font
/// on white background.
class GameTypeBadge extends StatelessWidget {
  final GameType gameType;

  const GameTypeBadge({super.key, required this.gameType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.headerDarkGreen, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        gameType.displayName,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.headerDarkGreen,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
