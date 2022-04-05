import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> loginUserWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      if (kDebugMode) {
        print('No user found for that email.');
      }
    } else if (e.code == 'wrong-password') {
      if (kDebugMode) {
        print('Wrong password provided for that user.');
      }
    }
  }
  return null;
}

Future<User?> getLoginedUser() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    return user;
  }

  return null;
}

Future<void> logoutUser() async {
  await FirebaseAuth.instance.signOut();
}

String getLoggedInUserId() {
  return FirebaseAuth.instance.currentUser?.uid ?? "";
}
