import 'dart:io';

import 'package:academic_calendar/Screens/event_page.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  EventCard({Key? key, required this.event}) : super(key: key);

  final AcademicEvent event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  String image = "";

  void downloadImage() async {
    String imageUrl = await getImage(widget.event.image);
    if (mounted) {
      setState(() {
        image = imageUrl;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    downloadImage();
  }

  String getTimeFrame() {
    return "${widget.event.startTime.hour.toString().padLeft(2, '0')}:${widget.event.startTime.minute.toString().padLeft(2, '0')} - ${widget.event.endTime.hour.toString().padLeft(2, '0')}:${widget.event.endTime.minute.toString().padLeft(2, '0')}";
  }

  void handleClick() {
    Navigator.pushNamed(
      context,
      EventPage.id,
      arguments: EventPageArguments(widget.event),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleClick,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.summary,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTimeFrame(),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        widget.event.location,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
