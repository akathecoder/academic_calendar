import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar editEventAppBar() => AppBar(
      title: const Text("Edit Event"),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
      ),
      toolbarHeight: kToolbarHeight * 1.1,
    );
