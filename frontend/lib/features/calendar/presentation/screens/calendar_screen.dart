import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/calendar/presentation/controllers/calendar_controller.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CalendarState calState = ref.watch(calendarControllerProvider);
    final CalendarController controller =
        ref.read(calendarControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: PhosphorIcon(PhosphorIcons.sidebar(), color: AppColors.headerWhite),
          onPressed: () => _showFormatPicker(context, controller, calState),
        ),
        title: _buildDateButton(context, controller, calState),
        actions: [
          _buildTodayButton(context, controller),
        ],
      ),
      body: Column(
        children: [
          _buildEventFilterChips(context, ref, calState),
          Expanded(child: _buildCalendarBody(context, ref, calState)),
          if (calState.getEventsForDay(calState.selectedDay).isNotEmpty)
            _buildEventList(context, calState),
        ],
      ),
    );
  }

  Widget _buildDateButton(
    BuildContext context,
    CalendarController controller,
    CalendarState calState,
  ) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: calState.focusedDay,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          controller.selectDay(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.headerWhite,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          DateFormat('d MMMM yyyy').format(calState.focusedDay),
          style: const TextStyle(
            color: AppColors.headerDarkGreen,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTodayButton(
    BuildContext context,
    CalendarController controller,
  ) {
    final int todayNumber = DateTime.now().day;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => controller.goToToday(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.headerWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            '$todayNumber',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.headerDarkGreen,
            ),
          ),
        ),
      ),
    );
  }

  void _showFormatPicker(
    BuildContext context,
    CalendarController controller,
    CalendarState calState,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: CalendarViewFormat.values.map((CalendarViewFormat format) {
              final bool isSelected = calState.viewFormat == format;
              return ListTile(
                leading: isSelected
                    ? PhosphorIcon(
                        PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : PhosphorIcon(PhosphorIcons.circle()),
                title: Text(format.displayName),
                onTap: () {
                  controller.changeViewFormat(format);
                  Navigator.pop(ctx);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildEventFilterChips(
    BuildContext context,
    WidgetRef ref,
    CalendarState calState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: CalendarEventFilter.values.map((CalendarEventFilter filter) {
          final bool isSelected = calState.eventFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter.displayName),
              selected: isSelected,
              onSelected: (bool selected) {
                ref
                    .read(calendarControllerProvider.notifier)
                    .changeEventFilter(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalendarBody(
    BuildContext context,
    WidgetRef ref,
    CalendarState calState,
  ) {
    final CalendarController controller =
        ref.read(calendarControllerProvider.notifier);
    return TableCalendar<CalendarEvent>(
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      focusedDay: calState.focusedDay,
      selectedDayPredicate: (DateTime day) =>
          isSameDay(calState.selectedDay, day),
      calendarFormat: calState.viewFormat.tableCalendarFormat,
      eventLoader: calState.getEventsForDay,
      onDaySelected: (DateTime selected, DateTime focused) {
        controller.selectDay(selected);
      },
      onPageChanged: (DateTime focusedDay) {
        controller.changeFocusedDay(focusedDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
        markerSize: 6,
        markersMaxCount: 3,
      ),
      headerVisible: false,
    );
  }

  Widget _buildEventList(BuildContext context, CalendarState calState) {
    final List<CalendarEvent> events =
        calState.getEventsForDay(calState.selectedDay);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          final CalendarEvent event = events[index];
          return ListTile(
            leading: PhosphorIcon(
              event.type == 'game'
                  ? PhosphorIcons.sword()
                  : PhosphorIcons.barbell(),
              color: colorScheme.primary,
            ),
            title: Text(event.title, style: textTheme.bodyMedium),
            subtitle: Text(
              '${DateFormat('HH:mm').format(event.dateTime)} - ${event.duration.inHours}h',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: event.groupName != null
                ? Chip(
                    label: Text(
                      event.groupName!,
                      style: textTheme.labelSmall,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
