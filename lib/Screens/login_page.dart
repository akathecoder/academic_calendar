import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:academic_calendar/utilities/login_form_utilities.dart';
import 'package:academic_calendar/utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static String id = "loginPage";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  void loginUserOnSubmit() {
    showSnackbar(context,
        'Processing Data\nEmail: ${_emailTextFieldController.text}\nPassword: ${_passwordTextFieldController.text}');

    loginUserWithEmailAndPassword(
            _emailTextFieldController.text, _passwordTextFieldController.text)
        .then((value) => Navigator.pop(context));
  }

  @override
  void initState() {
    super.initState();

    getLoginedUser().then(
      (value) => {
        if (value != null)
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pop(context);
          })
      },
    );
  }

  @override
  void dispose() {
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Proceed with your",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        CustomInputBox(
                          icon: Icons.person,
                          hintText: 'Enter your email id',
                          labelText: 'Email ID',
                          validateFunction: validateEmail,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: _emailTextFieldController,
                        ),
                        CustomInputBox(
                          icon: Icons.lock,
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          validateFunction: validatePassword,
                          textInputAction: TextInputAction.done,
                          textEditingController: _passwordTextFieldController,
                        ),
                        SubmitButton(
                          formKey: _formKey,
                          onPressed: loginUserOnSubmit,
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Text("Forgot Password?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
