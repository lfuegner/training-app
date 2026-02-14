/// The type/category of a game.
enum GameType {
  training('Training'),
  rated('Rated');

  final String displayName;

  const GameType(this.displayName);
}
