import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/core/router/app_router.dart';
import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/features/battle/presentation/controllers/battle_controller.dart';
import 'package:frontend/features/battle/presentation/widgets/game_card.dart';
import 'package:frontend/shared/widgets/add_button.dart';
import 'package:frontend/shared/widgets/sport_selector_dropdown.dart';
import 'package:frontend/shared/widgets/summary_card.dart';

@RoutePage()
class BattleScreen extends ConsumerStatefulWidget {
  const BattleScreen({super.key});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BattleState battleState = ref.watch(battleControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: SportSelectorDropdown(
          selectedSport: battleState.selectedSport,
          onChanged: (sport) =>
              ref.read(battleControllerProvider.notifier).selectSport(sport),
        ),
      ),
      body: _buildBody(battleState),
      floatingActionButton: AddButton(
        onPressed: _onAddGame,
        tooltip: 'Add Game',
      ),
    );
  }

  Widget _buildBody(BattleState battleState) {
    if (battleState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (battleState.errorMessage != null) {
      return Center(child: Text(battleState.errorMessage!));
    }
    final List<Widget> items = _buildScrollItems(battleState);
    if (items.isEmpty) {
      return const Center(child: Text('No games yet'));
    }
    // Find the index of the "next game" card (first future game or center)
    final int centerIndex = _findCenterIndex(battleState, items);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ListView.builder(
          controller: ScrollController(
            initialScrollOffset: centerIndex * 200.0,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) => items[index],
        );
      },
    );
  }

  List<Widget> _buildScrollItems(BattleState battleState) {
    final List<Widget> items = <Widget>[];
    final List<Game> futureGames = battleState.futureGames;
    final List<Game> pastGames = battleState.pastGames;
    // Future summary card (if more than 2 future games)
    if (futureGames.length > AppConstants.cardsBeforeSummary) {
      items.add(SummaryCard(
        title: '${futureGames.length - AppConstants.cardsBeforeSummary} more upcoming',
        subtitle: 'Tap to see all upcoming games',
        onTap: () => context.router.push(const AllFutureGamesRoute()),
      ));
      // Show only the nearest 2 future games
      for (int i = futureGames.length - 1;
          i >= futureGames.length - AppConstants.cardsBeforeSummary;
          i--) {
        items.add(_buildGameCard(futureGames[i]));
      }
    } else {
      // Show all future games, farthest first
      for (int i = futureGames.length - 1; i >= 0; i--) {
        items.add(_buildGameCard(futureGames[i]));
      }
    }
    // Past games
    if (pastGames.length > AppConstants.cardsBeforeSummary) {
      // Show only the most recent 2 past games
      for (int i = 0; i < AppConstants.cardsBeforeSummary; i++) {
        items.add(_buildGameCard(pastGames[i]));
      }
      items.add(SummaryCard(
        title: '${pastGames.length - AppConstants.cardsBeforeSummary} older games',
        subtitle: 'Tap to see game history',
        onTap: () => context.router.push(const GameHistoryRoute()),
      ));
    } else {
      for (final Game game in pastGames) {
        items.add(_buildGameCard(game));
      }
    }
    return items;
  }

  int _findCenterIndex(BattleState battleState, List<Widget> items) {
    final int futureCount = battleState.futureGames.length;
    if (futureCount > AppConstants.cardsBeforeSummary) {
      // Summary + 2 future cards; center is the nearest future (index 2)
      return AppConstants.cardsBeforeSummary;
    }
    return futureCount > 0 ? futureCount - 1 : 0;
  }

  Widget _buildGameCard(Game game) {
    return GameCard(
      game: game,
      onTap: () => context.router.push(GameDetailRoute(gameId: game.id)),
    );
  }

  void _onAddGame() {
    // TODO: Navigate to add game screen or show bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add game coming soon')),
    );
  }
}
