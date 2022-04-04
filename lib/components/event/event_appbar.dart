import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar eventAppBar(String title) => AppBar(
      title: Text(title),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
      ),
      toolbarHeight: kToolbarHeight * 1.1,
    );
