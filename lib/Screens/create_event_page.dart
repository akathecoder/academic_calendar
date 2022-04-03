import 'dart:io';

import 'package:academic_calendar/components/create_event/create_event_appbar.dart';
import 'package:academic_calendar/components/create_event/image_picker_card.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  static String id = "createEventPage";

  CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  File? image;
  AcademicEvent newEvent = AcademicEvent(
    summary: "",
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 10)),
  );

  void updateImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createEventAppBar(),
      body: SafeArea(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImagePickerCard(image: image, onImageUpdate: updateImage),
                const SizedBox(height: 20),
                customTextField(
                  label: "Event Name",
                  hintText: 'Enter event name',
                  onValueChange: (value) {
                    setState(() {
                      newEvent.summary = value;
                    });
                  },
                ),
                customDateField(
                  label: "Start Date",
                  hintText: 'Enter Start date',
                  date: newEvent.startTime,
                  firstDate: DateTime.now(),
                  onValueChange: (value) {
                    setState(() {
                      newEvent.startTime = value;
                    });
                  },
                ),
                customDateField(
                  label: "End Date",
                  hintText: 'Enter End date',
                  date: newEvent.endTime,
                  firstDate: newEvent.endTime,
                  onValueChange: (value) {
                    setState(() {
                      newEvent.endTime = value;
                    });
                  },
                ),
                customTextField(
                  label: "Description",
                  hintText: 'Enter event details',
                  minLines: 6,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onValueChange: (value) {
                    setState(() {
                      newEvent.description = value;
                    });
                  },
                ),
                customTextField(
                  label: "Location",
                  hintText: 'Enter event location',
                  onValueChange: (value) {
                    setState(() {
                      newEvent.location = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateEventPage.id);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget customTextField(
      {required String label,
      required void Function(String value) onValueChange,
      String? hintText,
      bool readOnly = false,
      int? maxLines,
      int minLines = 1,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          TextField(
            onChanged: (value) {
              onValueChange(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              hintText: hintText,
              isDense: true,
            ),
            readOnly: readOnly,
            maxLines: maxLines,
            minLines: minLines,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  Widget customDateField({
    required String label,
    required DateTime date,
    required void Function(DateTime value) onValueChange,
    required DateTime firstDate,
    DateTime? lastDate,
    String? hintText,
    bool readOnly = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          GestureDetector(
            onTap: () async {
              DateTime newDate = await pickDate(
                context: context,
                selectedDate: date,
                firstDate: firstDate,
              );
              onValueChange(newDate);
            },
            child: Container(
              width: double.infinity,
              height: 51.0,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime> pickDate({
    required BuildContext context,
    required DateTime selectedDate,
    required DateTime firstDate,
    DateTime? lastDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate ?? firstDate.add(const Duration(days: 366)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        pickedDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute);
      }

      return pickedDate;
    }

    return selectedDate;
  }
}
