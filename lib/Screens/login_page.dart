import 'package:academic_calendar/components/login_page/custom_input_box.dart';
import 'package:academic_calendar/components/login_page/submit_button.dart';
import 'package:academic_calendar/utilities/firebase_auth.dart';
import 'package:academic_calendar/utilities/login_form_utilities.dart';
import 'package:academic_calendar/utilities/snackbar.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      showSnackbar(
        context: context,
        text:
            'Processing Data\nEmail: ${_emailTextFieldController.text}\nPassword: ${_passwordTextFieldController.text}',
      );
    }

    loginUserWithEmailAndPassword(
      email: _emailTextFieldController.text,
      password: _passwordTextFieldController.text,
    ).then((value) => {
          if (value != null)
            Navigator.pop(context)
          else
            showSnackbar(
              context: context,
              text: "Invalid Username or Password!",
              backgroundColor: Colors.red,
            )
        });
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
