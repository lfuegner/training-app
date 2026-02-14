import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/training/domain/entities/training_session.dart';
import 'package:frontend/features/training/presentation/controllers/training_controller.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

@RoutePage()
class TrainingDetailScreen extends ConsumerWidget {
  final String trainingId;

  const TrainingDetailScreen({
    super.key,
    @PathParam('trainingId') required this.trainingId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TrainingState state = ref.watch(trainingControllerProvider);
    final TrainingSession? session = _findSession(state, trainingId);
    if (session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Training Details')),
        body: const Center(child: Text('Session not found')),
      );
    }
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(session.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              session.title,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (session.description != null) ...[
              const SizedBox(height: 8),
              Text(
                session.description!,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _detailRow(
                      context,
                      icon: PhosphorIcons.calendarBlank(),
                      label: 'Date',
                      value: DateFormat('EEEE, d MMMM yyyy')
                          .format(session.dateTime),
                    ),
                    const SizedBox(height: 12),
                    _detailRow(
                      context,
                      icon: PhosphorIcons.clock(),
                      label: 'Time',
                      value: DateFormat('HH:mm').format(session.dateTime),
                    ),
                    const SizedBox(height: 12),
                    _detailRow(
                      context,
                      icon: PhosphorIcons.timer(),
                      label: 'Duration',
                      value:
                          '${session.duration.inHours}h ${session.duration.inMinutes.remainder(60)}min',
                    ),
                    if (session.location != null) ...[
                      const SizedBox(height: 12),
                      _detailRow(
                        context,
                        icon: PhosphorIcons.mapPin(),
                        label: 'Location',
                        value: session.location!,
                      ),
                    ],
                    if (session.coachName != null) ...[
                      const SizedBox(height: 12),
                      _detailRow(
                        context,
                        icon: PhosphorIcons.chalkboardTeacher(),
                        label: 'Coach',
                        value: session.coachName!,
                      ),
                    ],
                    if (session.groupName != null) ...[
                      const SizedBox(height: 12),
                      _detailRow(
                        context,
                        icon: PhosphorIcons.usersThree(),
                        label: 'Group',
                        value: session.groupName!,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TrainingSession? _findSession(TrainingState state, String id) {
    final Iterable<TrainingSession> matches =
        state.sessions.where((TrainingSession s) => s.id == id);
    return matches.isNotEmpty ? matches.first : null;
  }

  Widget _detailRow(
    BuildContext context, {
    required PhosphorIconData icon,
    required String label,
    required String value,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        PhosphorIcon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
