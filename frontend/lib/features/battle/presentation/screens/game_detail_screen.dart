import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/features/battle/presentation/controllers/battle_controller.dart';
import 'package:frontend/features/battle/presentation/widgets/game_structure_view.dart';
import 'package:frontend/features/battle/presentation/widgets/game_type_badge.dart';
import 'package:frontend/shared/widgets/nationality_flag.dart';
import 'package:frontend/shared/widgets/result_triangle.dart' show ResultIndicator;
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class GameDetailScreen extends ConsumerWidget {
  final String gameId;

  const GameDetailScreen({
    super.key,
    @PathParam('gameId') required this.gameId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BattleState state = ref.watch(battleControllerProvider);
    final Game? game = _findGame(state, gameId);
    if (game == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Game Details')),
        body: const Center(child: Text('Game not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(game.sport.displayName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(context, game),
            const SizedBox(height: 20),
            _buildOpponentSection(context, game),
            const SizedBox(height: 20),
            _buildDetailsSection(context, game),
            if (game.gameStructure != null) ...[
              const SizedBox(height: 20),
              GameStructureView(gameStructure: game.gameStructure!),
            ],
          ],
        ),
      ),
    );
  }

  Game? _findGame(BattleState state, String id) {
    final Iterable<Game> matches = state.games.where((Game g) => g.id == id);
    return matches.isNotEmpty ? matches.first : null;
  }

  Widget _buildHeaderSection(BuildContext context, Game game) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GameTypeBadge(gameType: game.gameType),
        ResultIndicator(result: game.result, size: 32),
      ],
    );
  }

  Widget _buildOpponentSection(BuildContext context, Game game) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        NationalityFlag(countryCode: game.opponent.countryCode, size: 48),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                game.opponent.name,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Elo: ${game.opponent.elo}',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context, Game game) {
    final String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(game.dateTime);
    final String formattedTime = DateFormat('HH:mm').format(game.dateTime);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _detailRow(
              context,
              icon: PhosphorIcons.calendarBlank(),
              label: 'Date',
              value: formattedDate,
            ),
            const SizedBox(height: 12),
            _detailRow(
              context,
              icon: PhosphorIcons.clock(),
              label: 'Time',
              value: formattedTime,
            ),
            if (game.location != null) ...[
              const SizedBox(height: 12),
              _detailRow(
                context,
                icon: PhosphorIcons.mapPin(),
                label: 'Location',
                value: game.location!,
              ),
            ],
            const SizedBox(height: 12),
            _detailRow(
              context,
              icon: PhosphorIcons.trophy(),
              label: 'Result',
              value: game.score ?? 'TBD',
            ),
            if (game.eloChange != null) ...[
              const SizedBox(height: 12),
              _detailRow(
                context,
                icon: PhosphorIcons.trendUp(),
                label: 'Elo Change',
                value: '${game.eloChange! > 0 ? '+' : ''}${game.eloChange}',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
    BuildContext context, {
    required PhosphorIconData icon,
    required String label,
    required String value,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        PhosphorIcon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
