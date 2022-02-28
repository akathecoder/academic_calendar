import 'package:academic_calendar/Screens/my_home_page.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:academic_calendar/utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar homePageAppBar({
  required BuildContext context,
  required MyHomePage widget,
}) {
  return AppBar(
    title: Text(widget.title),
    elevation: 8,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ),
    actions: [
      IconButton(
        onPressed: () {
          logoutUser().then((value) => {
                showSnackbar(
                  context: context,
                  text: "Logout Successful",
                ),
              });
        },
        icon: const Icon(Icons.logout),
        tooltip: "Logout",
      )
    ],
  );
}
