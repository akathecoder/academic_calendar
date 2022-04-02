import 'package:flutter/material.dart';
import 'dart:io';

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
    this.description = '',
    this.location = '',
    this.color = 'a',
    this.isAllDay = false,
    this.isMultiDay = false,
    this.isDone = false,
  });

  final String summary;
  final DateTime startTime;
  final DateTime endTime;
  final String description;
  final String location;
  final String color;
  final bool isAllDay;
  final bool isMultiDay;
  final bool isDone;

  AcademicEvent.fromJson(Map<String, Object?> json)
      : this(
          summary: json['summary']! as String,
          startTime: parseTime(json['startTime']!),
          endTime: parseTime(json['endTime']!),
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
      'description': description,
      'location': location,
      'color': color,
      'isAllDay': isAllDay,
      'isMultiDay': isMultiDay,
      'isDone': isDone,
    };
  }
}
