import 'dart:io';
import 'package:academic_calendar/components/create_event/create_event_appbar.dart';
import 'package:academic_calendar/components/create_event/image_picker_card.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:academic_calendar/utilities/firebase_firestore.dart';
import 'package:academic_calendar/utilities/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateEventPage extends StatefulWidget {
  static String id = "createEventPage";

  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  File? image;
  AcademicEvent newEvent = AcademicEvent(
    summary: "",
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 10)),
    owner: getLoggedInUserId(),
  );

  void updateImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

  void handleSubmit(BuildContext context) async {
    context.loaderOverlay.show();

    newEvent.image = await uploadImage(image);

    await addEventToDatabase(
      summary: newEvent.summary,
      startTime: newEvent.startTime,
      endTime: newEvent.endTime,
      owner: newEvent.owner,
      description: newEvent.description,
      location: newEvent.location,
      isHoliday: newEvent.isHoliday,
      isExam: newEvent.isExam,
      image: newEvent.image,
    );

    Navigator.pop(context);
  }

  bool validateForm() {
    if (newEvent.summary.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
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
                  customCheckboxField(
                    label: "Holiday",
                    value: newEvent.isHoliday,
                    onValueChange: (value) {
                      setState(() {
                        newEvent.isHoliday = value;
                      });
                    },
                  ),
                  customCheckboxField(
                    label: "Exam",
                    value: newEvent.isExam,
                    onValueChange: (value) {
                      setState(() {
                        newEvent.isExam = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 14.0),
                    child: ElevatedButton(
                        onPressed:
                            validateForm() ? () => handleSubmit(context) : null,
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  Widget customCheckboxField({
    required String label,
    required void Function(bool value) onValueChange,
    required bool value,
    String? hintText,
    bool readOnly = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor:
                MaterialStateProperty.resolveWith((states) => Colors.blue),
            value: value,
            onChanged: (bool? v) {
              if (v != null) {
                setState(() {
                  onValueChange(v);
                });
              }
            },
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
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
