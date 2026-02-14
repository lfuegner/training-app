import 'package:flutter/material.dart';
import 'package:frontend/features/battle/domain/entities/game_structure.dart';

/// Renders the sport-specific game structure (sets, games, points).
class GameStructureView extends StatelessWidget {
  final GameStructure gameStructure;

  const GameStructureView({super.key, required this.gameStructure});

  @override
  Widget build(BuildContext context) {
    return switch (gameStructure) {
      TennisGameStructure(:final sets) => _buildTennisView(context, sets),
      BeachVolleyballGameStructure(:final sets) =>
        _buildBeachVolleyballView(context, sets),
      PaddleGameStructure(:final sets) => _buildPaddleView(context, sets),
    };
  }

  Widget _buildTennisView(BuildContext context, List<TennisSet> sets) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tennis Match', style: textTheme.titleSmall),
        const SizedBox(height: 8),
        _buildSetTable(
          context,
          headers: ['Set', 'You', 'Opp', 'Tiebreak'],
          rows: sets.asMap().entries.map((MapEntry<int, TennisSet> entry) {
            return [
              '${entry.key + 1}',
              '${entry.value.playerGames}',
              '${entry.value.opponentGames}',
              entry.value.tiebreak ?? '-',
            ];
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBeachVolleyballView(
    BuildContext context,
    List<BeachVolleyballSet> sets,
  ) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Beach Volleyball Match', style: textTheme.titleSmall),
        const SizedBox(height: 8),
        _buildSetTable(
          context,
          headers: ['Set', 'You', 'Opp'],
          rows: sets
              .asMap()
              .entries
              .map((MapEntry<int, BeachVolleyballSet> entry) {
            return [
              '${entry.key + 1}',
              '${entry.value.playerPoints}',
              '${entry.value.opponentPoints}',
            ];
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPaddleView(BuildContext context, List<PaddleSet> sets) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Paddle Match', style: textTheme.titleSmall),
        const SizedBox(height: 8),
        _buildSetTable(
          context,
          headers: ['Set', 'You', 'Opp'],
          rows: sets.asMap().entries.map((MapEntry<int, PaddleSet> entry) {
            return [
              '${entry.key + 1}',
              '${entry.value.playerGames}',
              '${entry.value.opponentGames}',
            ];
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSetTable(
    BuildContext context, {
    required List<String> headers,
    required List<List<String>> rows,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Table(
      border: TableBorder.all(
        color: colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
          ),
          children: headers
              .map((String h) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      h,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ))
              .toList(),
        ),
        ...rows.map((List<String> row) => TableRow(
              children: row
                  .map((String cell) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          cell,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ))
                  .toList(),
            )),
      ],
    );
  }
}
