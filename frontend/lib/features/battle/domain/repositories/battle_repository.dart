import 'package:frontend/features/battle/domain/entities/game.dart';
import 'package:frontend/shared/models/sport.dart';

/// Abstract contract for fetching game data.
abstract class BattleRepository {
  Future<List<Game>> fetchGames({required Sport sport});
}
