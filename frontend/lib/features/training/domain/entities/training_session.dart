import 'package:frontend/shared/models/rsvp_status.dart';
import 'package:frontend/shared/models/sport.dart';
import 'package:frontend/shared/models/training_type.dart';

/// Represents a single training session.
class TrainingSession {
  final String id;
  final Sport sport;
  final TrainingType trainingType;
  final DateTime dateTime;
  final Duration duration;
  final String title;
  final String? description;
  final String? location;
  final String? coachName;
  final String? groupName;
  final RsvpStatus? rsvpStatus;

  const TrainingSession({
    required this.id,
    required this.sport,
    required this.trainingType,
    required this.dateTime,
    required this.duration,
    required this.title,
    this.description,
    this.location,
    this.coachName,
    this.groupName,
    this.rsvpStatus,
  });

  bool get isFuture => dateTime.isAfter(DateTime.now());
  bool get isPast => dateTime.isBefore(DateTime.now());
  bool get isCoachTraining => trainingType == TrainingType.coachClub;
}
