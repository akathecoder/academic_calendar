import 'dart:developer';
import 'dart:io';
import 'package:academic_calendar/Screens/create_event_page.dart';
import 'package:academic_calendar/components/create_event/create_event_appbar.dart';
import 'package:academic_calendar/components/create_event/image_picker_card.dart';
import 'package:academic_calendar/components/edit_event/edit_event_appbar.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_firestore.dart';
import 'package:academic_calendar/utilities/firebase_storage.dart';
import 'package:academic_calendar/utilities/url_to_file.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditEventPage extends CreateEventPage {
  static String id = "editEventPage";

  const EditEventPage({Key? key}) : super(key: key);

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  File? image;
  AcademicEvent? newEvent;

  void updateImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

  void handleSubmit(BuildContext context) async {
    context.loaderOverlay.show();

    final args =
        ModalRoute.of(context)!.settings.arguments as EditEventPageArguments;

    if (image != null) {
      newEvent!.image = await uploadImage(image, path: args.event.image);
    }

    // log("Update Event", name: "Update Event", error: {
    //   newEvent!.id,
    //   newEvent!.summary,
    //   newEvent!.startTime,
    //   newEvent!.endTime,
    //   newEvent!.owner,
    //   newEvent!.description,
    //   newEvent!.location,
    //   newEvent!.isHoliday,
    //   newEvent!.isExam,
    //   newEvent!.image,
    // });

    await updateEventToDatabase(
      newEvent!.id,
      summary: newEvent!.summary,
      startTime: newEvent!.startTime,
      endTime: newEvent!.endTime,
      owner: newEvent!.owner,
      description: newEvent!.description,
      location: newEvent!.location,
      isHoliday: newEvent!.isHoliday,
      isExam: newEvent!.isExam,
      image: newEvent!.image,
    );

    Navigator.pop(context);
  }

  bool validateForm() {
    if (newEvent!.summary.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditEventPageArguments;

    newEvent ??= AcademicEvent.copy(args.event);

    // log("New Event", name: "New Event", error: {
    //   newEvent!.id,
    //   newEvent!.summary,
    //   newEvent!.startTime,
    //   newEvent!.endTime,
    //   newEvent!.owner,
    //   newEvent!.description,
    //   newEvent!.location,
    //   newEvent!.isHoliday,
    //   newEvent!.isExam,
    //   newEvent!.image,
    // });

    return LoaderOverlay(
      child: Scaffold(
        appBar: editEventAppBar(),
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
                    value: newEvent!.summary,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.summary = value;
                      });
                    },
                  ),
                  customDateField(
                    label: "Start Date",
                    hintText: 'Enter Start date',
                    date: newEvent!.startTime,
                    firstDate: DateTime.now(),
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.startTime = value;
                      });
                    },
                  ),
                  customDateField(
                    label: "End Date",
                    hintText: 'Enter End date',
                    date: newEvent!.endTime,
                    firstDate: newEvent!.endTime,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.endTime = value;
                      });
                    },
                  ),
                  customTextField(
                    label: "Description",
                    hintText: 'Enter event details',
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    value: newEvent!.description,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.description = value;
                      });
                    },
                  ),
                  customTextField(
                    label: "Location",
                    hintText: 'Enter event location',
                    value: newEvent!.location,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.location = value;
                      });
                    },
                  ),
                  customCheckboxField(
                    label: "Holiday",
                    value: newEvent!.isHoliday,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.isHoliday = value;
                      });
                    },
                  ),
                  customCheckboxField(
                    label: "Exam",
                    value: newEvent!.isExam,
                    onValueChange: (value) {
                      setState(() {
                        newEvent!.isExam = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 14.0),
                    child: ElevatedButton(
                        onPressed:
                            validateForm() ? () => handleSubmit(context) : null,
                        child: const Text('Update'),
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

  Widget customTextField({
    required String label,
    required void Function(String value) onValueChange,
    String? value,
    String? hintText,
    bool readOnly = false,
    int? maxLines,
    int minLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
          TextFormField(
            initialValue: value,
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
