// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AllFutureGamesScreen]
class AllFutureGamesRoute extends PageRouteInfo<void> {
  const AllFutureGamesRoute({List<PageRouteInfo>? children})
    : super(AllFutureGamesRoute.name, initialChildren: children);

  static const String name = 'AllFutureGamesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllFutureGamesScreen();
    },
  );
}

/// generated route for
/// [BattleScreen]
class BattleRoute extends PageRouteInfo<void> {
  const BattleRoute({List<PageRouteInfo>? children})
    : super(BattleRoute.name, initialChildren: children);

  static const String name = 'BattleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BattleScreen();
    },
  );
}

/// generated route for
/// [CalendarScreen]
class CalendarRoute extends PageRouteInfo<void> {
  const CalendarRoute({List<PageRouteInfo>? children})
    : super(CalendarRoute.name, initialChildren: children);

  static const String name = 'CalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CalendarScreen();
    },
  );
}

/// generated route for
/// [GameDetailScreen]
class GameDetailRoute extends PageRouteInfo<GameDetailRouteArgs> {
  GameDetailRoute({
    Key? key,
    required String gameId,
    List<PageRouteInfo>? children,
  }) : super(
         GameDetailRoute.name,
         args: GameDetailRouteArgs(key: key, gameId: gameId),
         rawPathParams: {'gameId': gameId},
         initialChildren: children,
       );

  static const String name = 'GameDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GameDetailRouteArgs>(
        orElse: () =>
            GameDetailRouteArgs(gameId: pathParams.getString('gameId')),
      );
      return GameDetailScreen(key: args.key, gameId: args.gameId);
    },
  );
}

class GameDetailRouteArgs {
  const GameDetailRouteArgs({this.key, required this.gameId});

  final Key? key;

  final String gameId;

  @override
  String toString() {
    return 'GameDetailRouteArgs{key: $key, gameId: $gameId}';
  }
}

/// generated route for
/// [GameHistoryScreen]
class GameHistoryRoute extends PageRouteInfo<void> {
  const GameHistoryRoute({List<PageRouteInfo>? children})
    : super(GameHistoryRoute.name, initialChildren: children);

  static const String name = 'GameHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GameHistoryScreen();
    },
  );
}

/// generated route for
/// [GroupsScreen]
class GroupsRoute extends PageRouteInfo<void> {
  const GroupsRoute({List<PageRouteInfo>? children})
    : super(GroupsRoute.name, initialChildren: children);

  static const String name = 'GroupsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GroupsScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [TrainingDetailScreen]
class TrainingDetailRoute extends PageRouteInfo<TrainingDetailRouteArgs> {
  TrainingDetailRoute({
    Key? key,
    required String trainingId,
    List<PageRouteInfo>? children,
  }) : super(
         TrainingDetailRoute.name,
         args: TrainingDetailRouteArgs(key: key, trainingId: trainingId),
         rawPathParams: {'trainingId': trainingId},
         initialChildren: children,
       );

  static const String name = 'TrainingDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TrainingDetailRouteArgs>(
        orElse: () => TrainingDetailRouteArgs(
          trainingId: pathParams.getString('trainingId'),
        ),
      );
      return TrainingDetailScreen(key: args.key, trainingId: args.trainingId);
    },
  );
}

class TrainingDetailRouteArgs {
  const TrainingDetailRouteArgs({this.key, required this.trainingId});

  final Key? key;

  final String trainingId;

  @override
  String toString() {
    return 'TrainingDetailRouteArgs{key: $key, trainingId: $trainingId}';
  }
}

/// generated route for
/// [TrainingScreen]
class TrainingRoute extends PageRouteInfo<void> {
  const TrainingRoute({List<PageRouteInfo>? children})
    : super(TrainingRoute.name, initialChildren: children);

  static const String name = 'TrainingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TrainingScreen();
    },
  );
}
