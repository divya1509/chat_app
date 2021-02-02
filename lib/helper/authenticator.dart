import 'package:chatapp/screens/SignIn.dart';
import 'package:chatapp/screens/signUp.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;

  void toggleView() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn)
      return SignIn(toggleView);
    else
      return SignUp(toggleView);
  }
}
