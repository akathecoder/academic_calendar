import 'package:flutter/material.dart';

class CustomInputBox extends StatelessWidget {
  final IconData icon;
  final String? hintText;
  final String labelText;
  final Function validateFunction;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;

  const CustomInputBox({
    Key? key,
    required this.icon,
    this.hintText,
    required this.labelText,
    required this.validateFunction,
    this.textInputAction,
    this.keyboardType,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          TextFormField(
            decoration: textFormFieldDecorations(),
            validator: (value) => validateFunction(value),
            controller: textEditingController,
            textInputAction: textInputAction ?? TextInputAction.done,
            keyboardType: keyboardType,
          ),
        ],
      ),
    );
  }

  InputDecoration textFormFieldDecorations() {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 24,
        maxWidth: 24,
      ),
      prefix: const SizedBox(
        width: 8,
      ),
    );
  }
}
