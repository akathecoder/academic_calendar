import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar createEventAppBar() => AppBar(
      title: const Text("Create Event"),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
      ),
      toolbarHeight: kToolbarHeight * 1.1,
    );
