import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/features/battle/domain/entities/game_structure.dart';
import 'package:frontend/features/battle/domain/entities/player.dart';
import 'package:frontend/features/battle/domain/repositories/battle_repository.dart';
import 'package:frontend/shared/models/game_result.dart';
import 'package:frontend/shared/models/game_type.dart';
import 'package:frontend/shared/models/sport.dart';

/// Mock implementation of [BattleRepository] returning sample data.
class BattleMockRepository implements BattleRepository {
  @override
  Future<List<Game>> fetchGames({required Sport sport}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final DateTime now = DateTime.now();
    return [
      // Past games (oldest first)
      Game(
        id: 'g1',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.subtract(const Duration(days: 14)),
        result: GameResult.win,
        score: '6-3, 7-5',
        eloChange: 25,
        opponent: const Player(
          id: 'p1',
          name: 'Carlos Martinez',
          countryCode: 'ES',
          elo: 1450,
        ),
        location: 'Club Deportivo Madrid',
        gameStructure: const TennisGameStructure(sets: [
          TennisSet(playerGames: 6, opponentGames: 3),
          TennisSet(playerGames: 7, opponentGames: 5),
        ]),
      ),
      Game(
        id: 'g2',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.subtract(const Duration(days: 10)),
        result: GameResult.loss,
        score: '4-6, 6-7',
        eloChange: -18,
        opponent: const Player(
          id: 'p2',
          name: 'Lucas Dupont',
          countryCode: 'FR',
          elo: 1520,
        ),
        location: 'Roland Garros Amateur',
        gameStructure: const TennisGameStructure(sets: [
          TennisSet(playerGames: 4, opponentGames: 6),
          TennisSet(playerGames: 6, opponentGames: 7, tiebreak: '5-7'),
        ]),
      ),
      Game(
        id: 'g3',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.subtract(const Duration(days: 5)),
        result: GameResult.win,
        score: '6-2, 6-4',
        eloChange: 20,
        opponent: const Player(
          id: 'p3',
          name: 'Liam O\'Brien',
          countryCode: 'IE',
          elo: 1380,
        ),
        location: 'Dublin Tennis Centre',
        gameStructure: const TennisGameStructure(sets: [
          TennisSet(playerGames: 6, opponentGames: 2),
          TennisSet(playerGames: 6, opponentGames: 4),
        ]),
      ),
      Game(
        id: 'g4',
        sport: sport,
        gameType: GameType.training,
        dateTime: now.subtract(const Duration(days: 2)),
        result: GameResult.draw,
        score: '6-4, 4-6',
        eloChange: 0,
        opponent: const Player(
          id: 'p4',
          name: 'Max Mueller',
          countryCode: 'DE',
          elo: 1470,
        ),
        location: 'TC Rot-Weiss Berlin',
      ),
      // Future games
      Game(
        id: 'g5',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.add(const Duration(days: 2)),
        result: GameResult.pending,
        opponent: const Player(
          id: 'p5',
          name: 'Marco Rossi',
          countryCode: 'IT',
          elo: 1500,
        ),
        location: 'Circolo Tennis Roma',
      ),
      Game(
        id: 'g6',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.add(const Duration(days: 7)),
        result: GameResult.pending,
        opponent: const Player(
          id: 'p6',
          name: 'Kenji Tanaka',
          countryCode: 'JP',
          elo: 1550,
        ),
        location: 'Tokyo Open Amateur',
      ),
      Game(
        id: 'g7',
        sport: sport,
        gameType: GameType.rated,
        dateTime: now.add(const Duration(days: 14)),
        result: GameResult.pending,
        opponent: const Player(
          id: 'p7',
          name: 'Andreas Svensson',
          countryCode: 'SE',
          elo: 1480,
        ),
        location: 'Stockholm Tennis Club',
      ),
      Game(
        id: 'g8',
        sport: sport,
        gameType: GameType.training,
        dateTime: now.add(const Duration(days: 21)),
        result: GameResult.pending,
        opponent: const Player(
          id: 'p8',
          name: 'Joao Silva',
          countryCode: 'PT',
          elo: 1420,
        ),
        location: 'Lisbon Sports Arena',
      ),
    ];
  }
}
