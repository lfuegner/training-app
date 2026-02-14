import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/battle/presentation/screens/all_future_games_screen.dart';
import 'package:frontend/features/battle/presentation/screens/battle_screen.dart';
import 'package:frontend/features/battle/presentation/screens/game_detail_screen.dart';
import 'package:frontend/features/battle/presentation/screens/game_history_screen.dart';
import 'package:frontend/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:frontend/features/groups/presentation/screens/groups_screen.dart';
import 'package:frontend/features/home/presentation/screens/home_screen.dart';
import 'package:frontend/features/profile/presentation/screens/profile_screen.dart';
import 'package:frontend/features/training/presentation/screens/training_detail_screen.dart';
import 'package:frontend/features/training/presentation/screens/training_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: BattleRoute.page),
            AutoRoute(page: TrainingRoute.page),
            AutoRoute(page: CalendarRoute.page),
            AutoRoute(page: GroupsRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: GameDetailRoute.page, path: '/game/:gameId'),
        AutoRoute(page: TrainingDetailRoute.page, path: '/training/:trainingId'),
        AutoRoute(page: AllFutureGamesRoute.page, path: '/games/upcoming'),
        AutoRoute(page: GameHistoryRoute.page, path: '/games/history'),
      ];
}
