import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/battle/data/repositories/battle_mock_repository.dart';
import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/features/battle/domain/repositories/battle_repository.dart';
import 'package:frontend/shared/models/sport.dart';

/// Holds the current battle state: selected sport and list of games.
class BattleState {
  final Sport selectedSport;
  final List<Game> games;
  final bool isLoading;
  final String? errorMessage;

  const BattleState({
    this.selectedSport = Sport.tennis,
    this.games = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  BattleState copyWith({
    Sport? selectedSport,
    List<Game>? games,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BattleState(
      selectedSport: selectedSport ?? this.selectedSport,
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  /// Games sorted by date, past games descending then future ascending.
  List<Game> get pastGames => games
      .where((Game g) => g.isPast)
      .toList()
    ..sort((Game a, Game b) => b.dateTime.compareTo(a.dateTime));

  List<Game> get futureGames => games
      .where((Game g) => g.isFuture)
      .toList()
    ..sort((Game a, Game b) => a.dateTime.compareTo(b.dateTime));

  Game? get nextGame => futureGames.isNotEmpty ? futureGames.first : null;
}

/// Controller for the Battle feature.
class BattleController extends StateNotifier<BattleState> {
  final BattleRepository _repository;

  BattleController(this._repository) : super(const BattleState());

  Future<void> loadGames() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final List<Game> games =
          await _repository.fetchGames(sport: state.selectedSport);
      state = state.copyWith(games: games, isLoading: false);
    } catch (err) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: err.toString(),
      );
    }
  }

  void selectSport(Sport sport) {
    state = state.copyWith(selectedSport: sport);
    loadGames();
  }
}

/// Provider for the BattleController.
final battleControllerProvider =
    StateNotifierProvider<BattleController, BattleState>((Ref ref) {
  final BattleController controller =
      BattleController(BattleMockRepository());
  controller.loadGames();
  return controller;
});
