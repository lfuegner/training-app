import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constants/app_constants.dart';
import 'package:frontend/core/router/app_router.dart';
import 'package:frontend/features/training/domain/entities/training_session.dart';
import 'package:frontend/features/training/presentation/controllers/training_controller.dart';
import 'package:frontend/features/training/presentation/widgets/training_card.dart';
import 'package:frontend/shared/widgets/add_button.dart';
import 'package:frontend/shared/widgets/header_dropdown.dart';
import 'package:frontend/shared/widgets/summary_card.dart';

@RoutePage()
class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TrainingState trainingState = ref.watch(trainingControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: HeaderDropdown<TrainingFilter>(
          selectedValue: trainingState.filter,
          items: TrainingFilter.values,
          labelBuilder: (TrainingFilter f) => f.displayName,
          onChanged: (TrainingFilter f) =>
              ref.read(trainingControllerProvider.notifier).selectFilter(f),
        ),
      ),
      body: _buildBody(context, ref, trainingState),
      floatingActionButton: AddButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add training coming soon')),
          );
        },
        tooltip: 'Add Training',
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    TrainingState trainingState,
  ) {
    if (trainingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (trainingState.errorMessage != null) {
      return Center(child: Text(trainingState.errorMessage!));
    }
    final List<Widget> items = _buildScrollItems(context, ref, trainingState);
    if (items.isEmpty) {
      return const Center(child: Text('No training sessions yet'));
    }
    final int centerIndex = _findCenterIndex(trainingState, items);
    return ListView.builder(
      controller: ScrollController(
        initialScrollOffset: centerIndex * 180.0,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => items[index],
    );
  }

  List<Widget> _buildScrollItems(
    BuildContext context,
    WidgetRef ref,
    TrainingState trainingState,
  ) {
    final List<Widget> items = <Widget>[];
    final List<TrainingSession> future = trainingState.futureSessions;
    final List<TrainingSession> past = trainingState.pastSessions;
    // Future summary
    if (future.length > AppConstants.cardsBeforeSummary) {
      items.add(SummaryCard(
        title: '${future.length - AppConstants.cardsBeforeSummary} more upcoming',
        subtitle: 'Tap to see all upcoming sessions',
        onTap: () {},
      ));
      for (int i = future.length - 1;
          i >= future.length - AppConstants.cardsBeforeSummary;
          i--) {
        items.add(_buildTrainingCard(context, ref, future[i]));
      }
    } else {
      for (int i = future.length - 1; i >= 0; i--) {
        items.add(_buildTrainingCard(context, ref, future[i]));
      }
    }
    // Past sessions
    if (past.length > AppConstants.cardsBeforeSummary) {
      for (int i = 0; i < AppConstants.cardsBeforeSummary; i++) {
        items.add(_buildTrainingCard(context, ref, past[i]));
      }
      items.add(SummaryCard(
        title: '${past.length - AppConstants.cardsBeforeSummary} older sessions',
        subtitle: 'Tap to see training history',
        onTap: () {},
      ));
    } else {
      for (final TrainingSession session in past) {
        items.add(_buildTrainingCard(context, ref, session));
      }
    }
    return items;
  }

  int _findCenterIndex(TrainingState trainingState, List<Widget> items) {
    final int futureCount = trainingState.futureSessions.length;
    if (futureCount > AppConstants.cardsBeforeSummary) {
      return AppConstants.cardsBeforeSummary;
    }
    return futureCount > 0 ? futureCount - 1 : 0;
  }

  Widget _buildTrainingCard(
    BuildContext context,
    WidgetRef ref,
    TrainingSession session,
  ) {
    return TrainingCard(
      session: session,
      onTap: () =>
          context.router.push(TrainingDetailRoute(trainingId: session.id)),
      onRsvpChanged: session.isCoachTraining
          ? (status) => ref
              .read(trainingControllerProvider.notifier)
              .updateRsvp(session.id, status)
          : null,
    );
  }
}
