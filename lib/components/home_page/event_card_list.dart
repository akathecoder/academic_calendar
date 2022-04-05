import 'package:academic_calendar/components/home_page/event_card.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:flutter/material.dart';

class EventCardList extends StatefulWidget {
  const EventCardList({Key? key, required this.eventsList}) : super(key: key);

  final List<AcademicEvent> eventsList;

  @override
  State<EventCardList> createState() => _EventCardListState();
}

class _EventCardListState extends State<EventCardList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            for (var event in widget.eventsList) EventCard(event: event),
          ],
        ),
      ),
    );
  }
}
