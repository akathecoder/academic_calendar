import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;

  const SubmitButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.onPressed,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_formKey.currentState!.validate()) {
            onPressed();
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          minimumSize: const Size.fromHeight(50),
        ),
      ),
    );
  }
}
