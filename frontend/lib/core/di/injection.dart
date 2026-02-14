import 'package:get_it/get_it.dart';

/// Global service locator instance.
final GetIt getIt = GetIt.instance;

/// Initializes all dependency injection bindings.
void configureDependencies() {
  // Repositories (mock for now, will be swapped for real implementations)
  // getIt.registerLazySingleton<BattleRepository>(() => BattleMockRepository());
  // getIt.registerLazySingleton<TrainingRepository>(() => TrainingMockRepository());
}
