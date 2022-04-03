import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  CustomCalendar({Key? key, required this.eventsList}) : super(key: key);

  final List<AcademicEvent> eventsList;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var event in widget.eventsList)
          Text(
            event.startTime.toString(),
          ),
      ],
    );
  }
}
