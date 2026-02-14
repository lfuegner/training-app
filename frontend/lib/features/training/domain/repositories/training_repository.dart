import 'package:frontend/features/training/domain/entities/training_session.dart';

/// Abstract contract for fetching training data.
abstract class TrainingRepository {
  Future<List<TrainingSession>> fetchTrainingSessions({
    required bool groupOnly,
  });
}
