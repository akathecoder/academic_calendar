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
    required this.owner,
    this.image = '',
    this.description = '',
    this.location = '',
    this.color = 'a',
    this.isHoliday = false,
    this.isExam = false,
    this.id,
  });

  String? id;
  String owner;
  String image;
  String summary;
  DateTime startTime;
  DateTime endTime;
  String description;
  String location;
  String color;
  bool isHoliday;
  bool isExam;

  AcademicEvent.fromJson(Map<String, Object?> json)
      : this(
          summary: json['summary']! as String,
          startTime: parseTime(json['startTime']!),
          endTime: parseTime(json['endTime']!),
          image: json['image']! as String,
          description: json['description']! as String,
          location: json['location']! as String,
          color: json['color']! as String,
          isHoliday: json['isHoliday']! as bool,
          isExam: json['isExam']! as bool,
          owner: json['owner'] as String,
          id: json['id'] as String?,
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
      'isHoliday': isHoliday,
      'isExam': isExam,
      'owner': owner,
      'id': id,
    };
  }

  AcademicEvent.copy(AcademicEvent event)
      : this(
          summary: event.summary,
          startTime: event.startTime,
          endTime: event.endTime,
          owner: event.owner,
          description: event.description,
          id: event.id,
          image: event.image,
          isExam: event.isExam,
          isHoliday: event.isHoliday,
          location: event.location,
          color: event.color,
        );
}
