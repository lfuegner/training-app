import 'package:flutter/material.dart';
import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/features/battle/presentation/widgets/game_type_badge.dart';
import 'package:frontend/shared/models/game_result.dart';
import 'package:frontend/shared/widgets/nationality_flag.dart';
import 'package:frontend/shared/widgets/result_triangle.dart' show ResultIndicator;
import 'package:intl/intl.dart';

/// A card displaying a single game summary.
class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String formattedDate = DateFormat('EEE, d MMM yyyy').format(game.dateTime);
    final String formattedTime = DateFormat('HH:mm').format(game.dateTime);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(colorScheme, textTheme),
              const SizedBox(height: 12),
              _buildOpponentRow(colorScheme, textTheme),
              const SizedBox(height: 8),
              _buildDateRow(colorScheme, textTheme, formattedDate, formattedTime),
              const SizedBox(height: 8),
              _buildResultRow(colorScheme, textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GameTypeBadge(gameType: game.gameType),
        ResultIndicator(result: game.result),
      ],
    );
  }

  Widget _buildOpponentRow(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        NationalityFlag(countryCode: game.opponent.countryCode, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            game.opponent.name,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          'Elo ${game.opponent.elo}',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(
    ColorScheme colorScheme,
    TextTheme textTheme,
    String date,
    String time,
  ) {
    return Row(
      children: [
        Text(
          date,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          time,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          game.score ?? 'TBD',
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: game.result == GameResult.pending
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurface,
          ),
        ),
        if (game.eloChange != null)
          Text(
            '${game.eloChange! > 0 ? '+' : ''}${game.eloChange}',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: game.eloChange! > 0
                  ? Colors.green
                  : game.eloChange! < 0
                      ? Colors.red
                      : colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
