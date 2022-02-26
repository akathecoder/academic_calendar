import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
