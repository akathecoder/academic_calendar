import 'package:academic_calendar/Screens/login_page.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  static String id = "homePage";

  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? loginedUser;

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
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        loginedUser = user;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (loginedUser != null)
              Text(loginedUser.toString())
            else
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                child: const Text("Login"),
              ),
          ],
        ),
      ),
    );
  }
}
