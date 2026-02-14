import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/training/data/repositories/training_mock_repository.dart';
import 'package:frontend/features/training/domain/entities/training_session.dart';
import 'package:frontend/features/training/domain/repositories/training_repository.dart';
import 'package:frontend/shared/models/rsvp_status.dart';

/// Filter options for training list.
enum TrainingFilter {
  all('All Trainings'),
  group('Group Trainings');

  final String displayName;
  const TrainingFilter(this.displayName);
}

/// Holds the current training state.
class TrainingState {
  final TrainingFilter filter;
  final List<TrainingSession> sessions;
  final bool isLoading;
  final String? errorMessage;

  const TrainingState({
    this.filter = TrainingFilter.all,
    this.sessions = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  TrainingState copyWith({
    TrainingFilter? filter,
    List<TrainingSession>? sessions,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TrainingState(
      filter: filter ?? this.filter,
      sessions: sessions ?? this.sessions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  List<TrainingSession> get pastSessions => sessions
      .where((TrainingSession s) => s.isPast)
      .toList()
    ..sort((TrainingSession a, TrainingSession b) =>
        b.dateTime.compareTo(a.dateTime));

  List<TrainingSession> get futureSessions => sessions
      .where((TrainingSession s) => s.isFuture)
      .toList()
    ..sort((TrainingSession a, TrainingSession b) =>
        a.dateTime.compareTo(b.dateTime));

  TrainingSession? get nextSession =>
      futureSessions.isNotEmpty ? futureSessions.first : null;
}

/// Controller for the Training feature.
class TrainingController extends StateNotifier<TrainingState> {
  final TrainingRepository _repository;

  TrainingController(this._repository) : super(const TrainingState());

  Future<void> loadSessions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final List<TrainingSession> sessions =
          await _repository.fetchTrainingSessions(
        groupOnly: state.filter == TrainingFilter.group,
      );
      state = state.copyWith(sessions: sessions, isLoading: false);
    } catch (err) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: err.toString(),
      );
    }
  }

  void selectFilter(TrainingFilter filter) {
    state = state.copyWith(filter: filter);
    loadSessions();
  }

  void updateRsvp(String sessionId, RsvpStatus status) {
    final List<TrainingSession> updated = state.sessions.map((TrainingSession s) {
      if (s.id == sessionId) {
        return TrainingSession(
          id: s.id,
          sport: s.sport,
          trainingType: s.trainingType,
          dateTime: s.dateTime,
          duration: s.duration,
          title: s.title,
          description: s.description,
          location: s.location,
          coachName: s.coachName,
          groupName: s.groupName,
          rsvpStatus: status,
        );
      }
      return s;
    }).toList();
    state = state.copyWith(sessions: updated);
  }
}

/// Provider for the TrainingController.
final trainingControllerProvider =
    StateNotifierProvider<TrainingController, TrainingState>((Ref ref) {
  final TrainingController controller =
      TrainingController(TrainingMockRepository());
  controller.loadSessions();
  return controller;
});
