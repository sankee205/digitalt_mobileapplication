import 'package:digitalt_application/Screens/Authenticate/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:digitalt_application/Screens/Authenticate/loginPage.dart';
import 'package:digitalt_application/Screens/Authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
