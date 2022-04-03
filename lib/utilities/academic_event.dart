import 'package:cloud_firestore/cloud_firestore.dart';

DateTime parseTime(dynamic date) {
  // return Platform.isIOS ? (date as Timestamp).toDate() : (date as DateTime);
  return (date as Timestamp).toDate();
}

class AcademicEvent {
  AcademicEvent({
    required this.summary,
    required this.startTime,
    required this.endTime,
    this.image = '',
    this.description = '',
    this.location = '',
    this.color = 'a',
    this.isAllDay = false,
    this.isMultiDay = false,
    this.isDone = false,
  });

  String image;
  String summary;
  DateTime startTime;
  DateTime endTime;
  String description;
  String location;
  String color;
  bool isAllDay;
  bool isMultiDay;
  bool isDone;

  AcademicEvent.fromJson(Map<String, Object?> json)
      : this(
          summary: json['summary']! as String,
          startTime: parseTime(json['startTime']!),
          endTime: parseTime(json['endTime']!),
          image: json['image']! as String,
          description: json['description']! as String,
          location: json['location']! as String,
          color: json['color']! as String,
          isAllDay: json['isAllDay']! as bool,
          isMultiDay: json['isMultiDay']! as bool,
          isDone: json['isDone']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'summary': summary,
      'startTime': startTime,
      'endTime': endTime,
      'image': image,
      'description': description,
      'location': location,
      'color': color,
      'isAllDay': isAllDay,
      'isMultiDay': isMultiDay,
      'isDone': isDone,
    };
  }
}
