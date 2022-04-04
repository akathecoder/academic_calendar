import 'package:academic_calendar/Screens/create_event_page.dart';
import 'package:academic_calendar/Screens/event_page.dart';
import 'package:academic_calendar/Screens/login_page.dart';
import 'package:academic_calendar/Screens/my_home_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Calendar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        MyHomePage.id: (context) =>
            const MyHomePage(title: "Academic Calendar"),
        LoginPage.id: (context) => const LoginPage(),
        CreateEventPage.id: (context) => CreateEventPage(),
        EventPage.id: (context) => EventPage(),
      },
      initialRoute: MyHomePage.id,
    );
  }
}
