import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

final eventsRef = firestore.collection('events').withConverter(
      fromFirestore: (snapshot, _) => AcademicEvent.fromJson(snapshot.data()!),
      toFirestore: (AcademicEvent academicEvent, _) => academicEvent.toJson(),
    );

Future<void> addEventToDatabase({
  required String summary,
  required DateTime startTime,
  required DateTime endTime,
  String description = '',
  String location = '',
  String color = "ff2196f3",
  bool isAllDay = false,
  bool isMultiDay = false,
  bool isDone = false,
}) async {
  await eventsRef.add(AcademicEvent(
    summary: summary,
    startTime: startTime,
    endTime: endTime,
    description: description,
    location: location,
    color: color,
    isAllDay: isAllDay,
    isMultiDay: isMultiDay,
    isDone: isDone,
  ));
}

Future<List<QueryDocumentSnapshot<AcademicEvent>>> getEventsFromDatabase(
    DateTime date) async {
  return await eventsRef
      .where(
        'startTime',
        isLessThanOrEqualTo:
            DateTime(date.year, date.month, date.day + 1, 0, 0, 0, 0, 0),
      )
      .get()
      .then((snapshot) => snapshot.docs);
}





// NeatCleanCalendarEvent NeatCleanCalendarEvent(
//   String summary, {
//   String description = '',
//   String location = '',
//   required DateTime startTime,
//   required DateTime endTime,
//   Color? color = Colors.blue,
//   bool isAllDay = false,
//   bool isMultiDay = false,
//   bool isDone = false,
//   dynamic multiDaySegement,
// })