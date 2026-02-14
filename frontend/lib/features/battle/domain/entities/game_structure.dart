/// Base class for sport-specific game structures.
sealed class GameStructure {
  const GameStructure();
}

/// Tennis match structure with sets and games.
class TennisGameStructure extends GameStructure {
  final List<TennisSet> sets;

  const TennisGameStructure({required this.sets});
}

/// A single set in a tennis match.
class TennisSet {
  final int playerGames;
  final int opponentGames;
  final String? tiebreak;

  const TennisSet({
    required this.playerGames,
    required this.opponentGames,
    this.tiebreak,
  });

  @override
  String toString() => '$playerGames-$opponentGames';
}

/// Beach volleyball match structure with sets.
class BeachVolleyballGameStructure extends GameStructure {
  final List<BeachVolleyballSet> sets;

  const BeachVolleyballGameStructure({required this.sets});
}

/// A single set in a beach volleyball match.
class BeachVolleyballSet {
  final int playerPoints;
  final int opponentPoints;

  const BeachVolleyballSet({
    required this.playerPoints,
    required this.opponentPoints,
  });

  @override
  String toString() => '$playerPoints-$opponentPoints';
}

/// Paddle match structure (similar to tennis).
class PaddleGameStructure extends GameStructure {
  final List<PaddleSet> sets;

  const PaddleGameStructure({required this.sets});
}

/// A single set in a paddle match.
class PaddleSet {
  final int playerGames;
  final int opponentGames;

  const PaddleSet({
    required this.playerGames,
    required this.opponentGames,
  });

  @override
  String toString() => '$playerGames-$opponentGames';
}
