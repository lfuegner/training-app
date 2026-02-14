/// The type of a training session.
enum TrainingType {
  personal('Personal'),
  coachClub('Coach / Club');

  final String displayName;

  const TrainingType(this.displayName);
}
