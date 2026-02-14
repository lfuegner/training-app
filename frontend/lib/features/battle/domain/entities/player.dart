/// Represents a player in a game.
class Player {
  final String id;
  final String name;
  final String countryCode;
  final int elo;

  const Player({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.elo,
  });
}
