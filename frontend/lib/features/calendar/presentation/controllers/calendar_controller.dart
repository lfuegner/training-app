import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

/// Calendar view format options.
enum CalendarViewFormat {
  daily('Daily', CalendarFormat.week),
  threeDays('3 Days', CalendarFormat.week),
  week('Week', CalendarFormat.week),
  month('Month', CalendarFormat.month);

  final String displayName;
  final CalendarFormat tableCalendarFormat;
  const CalendarViewFormat(this.displayName, this.tableCalendarFormat);
}

/// Filter for which events to show.
enum CalendarEventFilter {
  all('All'),
  personal('My Events'),
  group('Group Events');

  final String displayName;
  const CalendarEventFilter(this.displayName);
}

/// A simple calendar event.
class CalendarEvent {
  final String id;
  final String title;
  final DateTime dateTime;
  final Duration duration;
  final String type; // 'game' or 'training'
  final String? groupName;
  final bool isPersonal;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.type,
    this.groupName,
    this.isPersonal = true,
  });
}

/// Holds the calendar state.
class CalendarState {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarViewFormat viewFormat;
  final CalendarEventFilter eventFilter;
  final Map<DateTime, List<CalendarEvent>> events;

  CalendarState({
    DateTime? focusedDay,
    DateTime? selectedDay,
    this.viewFormat = CalendarViewFormat.month,
    this.eventFilter = CalendarEventFilter.all,
    Map<DateTime, List<CalendarEvent>>? events,
  })  : focusedDay = focusedDay ?? DateTime.now(),
        selectedDay = selectedDay ?? DateTime.now(),
        events = events ?? {};

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    CalendarViewFormat? viewFormat,
    CalendarEventFilter? eventFilter,
    Map<DateTime, List<CalendarEvent>>? events,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      viewFormat: viewFormat ?? this.viewFormat,
      eventFilter: eventFilter ?? this.eventFilter,
      events: events ?? this.events,
    );
  }

  List<CalendarEvent> getEventsForDay(DateTime day) {
    final DateTime key = DateTime(day.year, day.month, day.day);
    final List<CalendarEvent> dayEvents = events[key] ?? [];
    switch (eventFilter) {
      case CalendarEventFilter.all:
        return dayEvents;
      case CalendarEventFilter.personal:
        return dayEvents.where((CalendarEvent e) => e.isPersonal).toList();
      case CalendarEventFilter.group:
        return dayEvents.where((CalendarEvent e) => !e.isPersonal).toList();
    }
  }
}

/// Controller for the Calendar feature.
class CalendarController extends StateNotifier<CalendarState> {
  CalendarController() : super(CalendarState()) {
    _loadMockEvents();
  }

  void selectDay(DateTime day) {
    state = state.copyWith(selectedDay: day, focusedDay: day);
  }

  void changeFocusedDay(DateTime day) {
    state = state.copyWith(focusedDay: day);
  }

  void changeViewFormat(CalendarViewFormat format) {
    state = state.copyWith(viewFormat: format);
  }

  void changeEventFilter(CalendarEventFilter filter) {
    state = state.copyWith(eventFilter: filter);
  }

  void goToToday() {
    final DateTime today = DateTime.now();
    state = state.copyWith(focusedDay: today, selectedDay: today);
  }

  void _loadMockEvents() {
    final DateTime now = DateTime.now();
    final Map<DateTime, List<CalendarEvent>> events = {};
    final List<CalendarEvent> mockEvents = [
      CalendarEvent(
        id: 'ce1',
        title: 'Tennis Match vs Carlos',
        dateTime: now.subtract(const Duration(days: 2)),
        duration: const Duration(hours: 2),
        type: 'game',
        isPersonal: true,
      ),
      CalendarEvent(
        id: 'ce2',
        title: 'Group Drills',
        dateTime: now.subtract(const Duration(days: 1)),
        duration: const Duration(hours: 1, minutes: 30),
        type: 'training',
        groupName: 'Advanced Group A',
        isPersonal: false,
      ),
      CalendarEvent(
        id: 'ce3',
        title: 'Rated Match vs Marco',
        dateTime: now.add(const Duration(days: 2)),
        duration: const Duration(hours: 2),
        type: 'game',
        isPersonal: true,
      ),
      CalendarEvent(
        id: 'ce4',
        title: 'Tactical Training',
        dateTime: now.add(const Duration(days: 1)),
        duration: const Duration(hours: 2),
        type: 'training',
        groupName: 'Advanced Group A',
        isPersonal: false,
      ),
      CalendarEvent(
        id: 'ce5',
        title: 'Cardio Session',
        dateTime: now.add(const Duration(days: 4)),
        duration: const Duration(hours: 1),
        type: 'training',
        isPersonal: true,
      ),
      CalendarEvent(
        id: 'ce6',
        title: 'Tournament Match',
        dateTime: now.add(const Duration(days: 7)),
        duration: const Duration(hours: 3),
        type: 'game',
        isPersonal: true,
      ),
    ];
    for (final CalendarEvent event in mockEvents) {
      final DateTime key = DateTime(
          event.dateTime.year, event.dateTime.month, event.dateTime.day);
      events.putIfAbsent(key, () => []);
      events[key]!.add(event);
    }
    state = state.copyWith(events: events);
  }
}

/// Provider for the CalendarController.
final calendarControllerProvider =
    StateNotifierProvider<CalendarController, CalendarState>((Ref ref) {
  return CalendarController();
});
