import 'package:frontend/features/training/domain/entities/training_session.dart';
import 'package:frontend/features/training/domain/repositories/training_repository.dart';
import 'package:frontend/shared/models/rsvp_status.dart';
import 'package:frontend/shared/models/sport.dart';
import 'package:frontend/shared/models/training_type.dart';

/// Mock implementation of [TrainingRepository].
class TrainingMockRepository implements TrainingRepository {
  @override
  Future<List<TrainingSession>> fetchTrainingSessions({
    required bool groupOnly,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final DateTime now = DateTime.now();
    final List<TrainingSession> all = [
      TrainingSession(
        id: 't1',
        sport: Sport.tennis,
        trainingType: TrainingType.personal,
        dateTime: now.subtract(const Duration(days: 12)),
        duration: const Duration(hours: 1, minutes: 30),
        title: 'Serve Practice',
        description: 'Focus on second serve consistency',
        location: 'Local Tennis Club',
      ),
      TrainingSession(
        id: 't2',
        sport: Sport.tennis,
        trainingType: TrainingType.coachClub,
        dateTime: now.subtract(const Duration(days: 7)),
        duration: const Duration(hours: 2),
        title: 'Group Drills',
        description: 'Footwork and volley drills with Coach Becker',
        location: 'TC Rot-Weiss',
        coachName: 'Coach Becker',
        groupName: 'Advanced Group A',
        rsvpStatus: RsvpStatus.attending,
      ),
      TrainingSession(
        id: 't3',
        sport: Sport.tennis,
        trainingType: TrainingType.personal,
        dateTime: now.subtract(const Duration(days: 3)),
        duration: const Duration(hours: 1),
        title: 'Backhand Improvement',
        location: 'City Sports Centre',
      ),
      TrainingSession(
        id: 't4',
        sport: Sport.tennis,
        trainingType: TrainingType.coachClub,
        dateTime: now.subtract(const Duration(days: 1)),
        duration: const Duration(hours: 2),
        title: 'Match Simulation',
        coachName: 'Coach Navarro',
        groupName: 'Advanced Group A',
        location: 'National Tennis Arena',
        rsvpStatus: RsvpStatus.attending,
      ),
      // Future
      TrainingSession(
        id: 't5',
        sport: Sport.tennis,
        trainingType: TrainingType.coachClub,
        dateTime: now.add(const Duration(days: 1)),
        duration: const Duration(hours: 2),
        title: 'Tactical Training',
        coachName: 'Coach Becker',
        groupName: 'Advanced Group A',
        location: 'TC Rot-Weiss',
      ),
      TrainingSession(
        id: 't6',
        sport: Sport.tennis,
        trainingType: TrainingType.personal,
        dateTime: now.add(const Duration(days: 4)),
        duration: const Duration(hours: 1, minutes: 30),
        title: 'Cardio & Agility',
        location: 'Gym Fitness Plus',
      ),
      TrainingSession(
        id: 't7',
        sport: Sport.tennis,
        trainingType: TrainingType.coachClub,
        dateTime: now.add(const Duration(days: 8)),
        duration: const Duration(hours: 2),
        title: 'Weekend Intensive',
        coachName: 'Coach Navarro',
        groupName: 'Advanced Group A',
        location: 'National Tennis Arena',
      ),
      TrainingSession(
        id: 't8',
        sport: Sport.tennis,
        trainingType: TrainingType.personal,
        dateTime: now.add(const Duration(days: 15)),
        duration: const Duration(hours: 1),
        title: 'Return of Serve Session',
        location: 'Local Tennis Club',
      ),
    ];
    if (groupOnly) {
      return all
          .where((TrainingSession s) => s.trainingType == TrainingType.coachClub)
          .toList();
    }
    return all;
  }
}
