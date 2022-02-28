import 'package:academic_calendar/Screens/login_page.dart';
import 'package:academic_calendar/components/home_page/homepage_appbar.dart';
import 'package:academic_calendar/utilities/calendar.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

class MyHomePage extends StatefulWidget {
  static String id = "homePage";

  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? loginedUser;
  late List<NeatCleanCalendarEvent> _eventList;

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

    setState(() {
      _eventList = getEvents();
    });
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
          padding: const EdgeInsets.only(top: 12.0),
          child: Calendar(
            startOnMonday: false,
            isExpandable: true,
            eventsList: _eventList,
            locale: "en_IN",
          ),
        ),
      ),
    );
  }
}
