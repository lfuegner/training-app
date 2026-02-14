import 'package:frontend/features/battle/domain/entities/game_structure.dart';
import 'package:frontend/features/battle/domain/entities/player.dart';
import 'package:frontend/shared/models/game_result.dart';
import 'package:frontend/shared/models/game_type.dart';
import 'package:frontend/shared/models/sport.dart';

/// Represents a single game/match.
class Game {
  final String id;
  final Sport sport;
  final GameType gameType;
  final DateTime dateTime;
  final GameResult result;
  final String? score;
  final int? eloChange;
  final Player opponent;
  final String? location;
  final GameStructure? gameStructure;

  const Game({
    required this.id,
    required this.sport,
    required this.gameType,
    required this.dateTime,
    required this.result,
    this.score,
    this.eloChange,
    required this.opponent,
    this.location,
    this.gameStructure,
  });

  bool get isFuture => dateTime.isAfter(DateTime.now());
  bool get isPast => dateTime.isBefore(DateTime.now());
}
