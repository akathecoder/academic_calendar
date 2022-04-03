import 'dart:developer';

import 'package:academic_calendar/Screens/login_page.dart';
import 'package:academic_calendar/components/home_page/custom_calendar.dart';
import 'package:academic_calendar/components/home_page/custom_calendar_date_scrollbar.dart';
import 'package:academic_calendar/components/home_page/homepage_appbar.dart';
import 'package:academic_calendar/utilities/academic_event.dart';
import 'package:academic_calendar/utilities/calendar.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static String id = "homePage";

  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? loginedUser;
  List<AcademicEvent> _eventsList = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    getLoginedUser().then(
      (value) => {
        if (value != null)
          loginedUser = value
        else
          Navigator.pushNamed(context, LoginPage.id)
      },
    );

    _selectedDate = DateTime.now();

    getEvents().then((value) => _eventsList = value);
  }

  void handleDateChange(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    // TODO: Update Events Data
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        loginedUser = user;
      });
    });

    return Scaffold(
      appBar: homePageAppBar(
        context: context,
        widget: widget,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              CustomCalendarDateScrollbar(
                onDateChanged: handleDateChange,
                selectedDate: _selectedDate,
              ),
              CustomCalendar(eventsList: _eventsList),
              Text(_selectedDate.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
