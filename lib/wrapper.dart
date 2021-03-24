import 'package:digitalt_application/models/user.dart';
import 'package:digitalt_application/screens/authenticate/authenticate.dart';
import 'package:digitalt_application/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BaseUser>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
