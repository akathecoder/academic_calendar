import 'dart:async';

import 'package:academic_calendar/components/event/event_appbar.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventPageArguments {
  final AcademicEvent event;
  final void Function()? refreshData;

  EventPageArguments({required this.event, this.refreshData});
}

class EventPage extends StatefulWidget {
  static String id = "eventPage";

  const EventPage({Key? key, this.refreshData}) : super(key: key);
  final void Function()? refreshData;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String image = "";

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void downloadImage(String imagePath) async {
    String imageUrl = await getImage(imagePath);
    if (mounted) {
      setState(() {
        image = imageUrl;
      });
    }
  }

  String convertDateTimeToString(DateTime dateTime) {
    final Map<int, String> months = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December",
    };

    return "${months[dateTime.month]} ${dateTime.day.toString().padLeft(2, '0')}, ${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  FutureOr onGoBack() {
    widget.refreshData!();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EventPageArguments;

    downloadImage(args.event.image);

    return Scaffold(
      appBar: eventAppBar(context, args.event, onGoBack),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            widget.refreshData!();
          },
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: image.isNotEmpty
                        ? Hero(
                            tag: image,
                            child: Image.network(
                              image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.event.summary,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          convertDateTimeToString(args.event.startTime) +
                              " - " +
                              convertDateTimeToString(args.event.endTime),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          args.event.location,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (args.event.isHoliday) ...[
                              Chip(
                                label: const Text(
                                  'Holiday',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.blue.shade400,
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (args.event.isExam) ...[
                              Chip(
                                label: const Text(
                                  'Exam',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red.shade400,
                              ),
                              const SizedBox(width: 8),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          args.event.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
