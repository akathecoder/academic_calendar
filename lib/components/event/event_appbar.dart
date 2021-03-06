import 'dart:async';

import 'package:academic_calendar/Screens/create_event_page.dart';
import 'package:academic_calendar/Screens/edit_event_page.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:academic_calendar/utilities/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar eventAppBar(
    BuildContext context, AcademicEvent event, FutureOr onGoBack) {
  Widget getEditButton() {
    if (getLoggedInUserId() == event.owner) {
      return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, EditEventPage.id,
                  arguments: EditEventPageArguments(event))
              .then((value) => onGoBack);
        },
        icon: const Icon(Icons.edit),
        tooltip: "Edit Event",
      );
    } else {
      return const SizedBox();
    }
  }

  Widget getDeleteButton() {
    void handleClick() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Event"),
            content: const Text("Do you want to delete this event?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => deleteEventFromDatabase(event)
                    .then(
                      (value) => Navigator.pop(context, 'OK'),
                    )
                    .then(
                      (value) => Navigator.pop(context),
                    ),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.red.withOpacity(0.3)),
                  // shadowColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ],
          );
        },
        useSafeArea: true,
      );
    }

    if (getLoggedInUserId() == event.owner) {
      return IconButton(
        onPressed: () {
          handleClick();
        },
        icon: const Icon(Icons.delete),
        tooltip: "Edit Event",
      );
    } else {
      return const SizedBox();
    }
  }

  return AppBar(
    title: Text(event.summary),
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ),
    toolbarHeight: kToolbarHeight * 1.1,
    actions: [
      getEditButton(),
      getDeleteButton(),
    ],
  );
}
