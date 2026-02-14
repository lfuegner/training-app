/// Supported sports in the app. Extensible by adding new enum values.
enum Sport {
  tennis('Tennis'),
  beachVolleyball('Beach Volleyball'),
  paddle('Paddle');

  final String displayName;

  const Sport(this.displayName);
}
