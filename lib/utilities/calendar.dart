import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<AcademicEvent>> getEvents() async {
  List<AcademicEvent> _eventList = [];

  List<QueryDocumentSnapshot<AcademicEvent>> eventData =
      await getEventsFromDatabase();

  for (var eventDoc in eventData) {
    _eventList.add(eventDoc.data());
  }

  return _eventList;
}


// Future<List<NeatCleanCalendarEvent>> getEvents() async {
//   List<NeatCleanCalendarEvent> _eventList = [];

//   List<QueryDocumentSnapshot<AcademicEvent>> eventData =
//       await getEventsFromDatabase();

//   for (var eventDoc in eventData) {
//     AcademicEvent event = eventDoc.data();

//     _eventList.add(NeatCleanCalendarEvent(
//       event.summary,
//       startTime: event.startTime,
//       endTime: event.endTime,
//       description: event.description,
//       location: event.location,
//       color: HexColor(event.color),
//       isAllDay: event.isAllDay,
//       isDone: event.isDone,
//       isMultiDay: event.isMultiDay,
//     ));
//   }

//   return _eventList;
// }


// List<NeatCleanCalendarEvent> getEvents() {
//   final List<NeatCleanCalendarEvent> _eventList = [
//     NeatCleanCalendarEvent(
//       'MultiDay Event A',
//       startTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day,
//         10,
//         0,
//       ),
//       endTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day + 2,
//         12,
//         0,
//       ),
//       color: Colors.orange,
//       isMultiDay: true,
//       description: "sssssssss",
//     ),
//     NeatCleanCalendarEvent(
//       'Allday Event B',
//       startTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day - 2,
//         14,
//         30,
//       ),
//       endTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day + 2,
//         17,
//         0,
//       ),
//       color: Colors.pink,
//       isAllDay: true,
//     ),
//     NeatCleanCalendarEvent(
//       'Normal Event D',
//       startTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day,
//         14,
//         30,
//       ),
//       endTime: DateTime(
//         DateTime.now().year,
//         DateTime.now().month,
//         DateTime.now().day,
//         17,
//         0,
//       ),
//       color: Colors.indigo,
//     ),
//   ];
//   return _eventList;
// }
