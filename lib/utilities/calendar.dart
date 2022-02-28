import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

List<NeatCleanCalendarEvent> getEvents() {
  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent(
      'MultiDay Event A',
      startTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        10,
        0,
      ),
      endTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 2,
        12,
        0,
      ),
      color: Colors.orange,
      isMultiDay: true,
      description: "sssssssss",
    ),
    NeatCleanCalendarEvent(
      'Allday Event B',
      startTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - 2,
        14,
        30,
      ),
      endTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 2,
        17,
        0,
      ),
      color: Colors.pink,
      isAllDay: true,
    ),
    NeatCleanCalendarEvent(
      'Normal Event D',
      startTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        14,
        30,
      ),
      endTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        17,
        0,
      ),
      color: Colors.indigo,
    ),
  ];
  return _eventList;
}
