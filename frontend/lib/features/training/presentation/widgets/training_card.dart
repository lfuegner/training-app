import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/training/domain/entities/training_session.dart';
import 'package:frontend/shared/models/rsvp_status.dart';
import 'package:frontend/shared/models/training_type.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A card displaying a single training session.
class TrainingCard extends StatelessWidget {
  final TrainingSession session;
  final VoidCallback onTap;
  final ValueChanged<RsvpStatus>? onRsvpChanged;

  const TrainingCard({
    super.key,
    required this.session,
    required this.onTap,
    this.onRsvpChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String formattedDate =
        DateFormat('EEE, d MMM yyyy').format(session.dateTime);
    final String formattedTime = DateFormat('HH:mm').format(session.dateTime);
    final String durationText =
        '${session.duration.inHours}h ${session.duration.inMinutes.remainder(60)}min';
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(colorScheme, textTheme),
              const SizedBox(height: 10),
              Text(
                session.title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (session.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  session.description!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),
              _buildInfoRow(colorScheme, textTheme, formattedDate,
                  formattedTime, durationText),
              if (session.isCoachTraining) ...[
                const SizedBox(height: 12),
                _buildRsvpRow(colorScheme),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: session.trainingType == TrainingType.coachClub
                ? AppColors.tournamentBadge
                : AppColors.trainingBadge,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            session.trainingType.displayName,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (session.coachName != null)
          Text(
            session.coachName!,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(
    ColorScheme colorScheme,
    TextTheme textTheme,
    String date,
    String time,
    String duration,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 4,
      children: [
        Text(date,
            style: textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        Text(time,
            style: textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        Text(duration,
            style: textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurfaceVariant)),
        if (session.location != null)
          Text(session.location!,
              style: textTheme.bodySmall
                  ?.copyWith(color: colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildRsvpRow(ColorScheme colorScheme) {
    final bool isAttending = session.rsvpStatus == RsvpStatus.attending;
    final bool isNotAttending = session.rsvpStatus == RsvpStatus.notAttending;
    final bool isUndecided = session.rsvpStatus == RsvpStatus.undecided;
    return Row(
      children: [
        _rsvpBox(
          icon: isAttending
              ? PhosphorIcons.checkCircle(PhosphorIconsStyle.fill)
              : PhosphorIcons.checkCircle(),
          color: AppColors.attendingGreen,
          isSelected: isAttending,
          borderColor: AppColors.attendingGreen,
          onTap: () => onRsvpChanged?.call(RsvpStatus.attending),
        ),
        const SizedBox(width: 8),
        _rsvpBox(
          icon: isNotAttending
              ? PhosphorIcons.xCircle(PhosphorIconsStyle.fill)
              : PhosphorIcons.xCircle(),
          color: AppColors.notAttendingRed,
          isSelected: isNotAttending,
          borderColor: AppColors.notAttendingRed,
          onTap: () => onRsvpChanged?.call(RsvpStatus.notAttending),
        ),
        const SizedBox(width: 8),
        _rsvpBox(
          icon: isUndecided
              ? PhosphorIcons.question(PhosphorIconsStyle.fill)
              : PhosphorIcons.question(),
          color: AppColors.undecidedAmber,
          isSelected: isUndecided,
          borderColor: AppColors.undecidedAmber,
          onTap: () => onRsvpChanged?.call(RsvpStatus.undecided),
        ),
      ],
    );
  }

  Widget _rsvpBox({
    required PhosphorIconData icon,
    required Color color,
    required bool isSelected,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor.withValues(alpha: isSelected ? 1.0 : 0.4),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? borderColor.withValues(alpha: 0.08) : null,
          ),
          child: Center(
            child: PhosphorIcon(
              icon,
              color: color,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
