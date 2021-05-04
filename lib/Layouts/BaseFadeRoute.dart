import 'package:flutter/material.dart';

///
///this is an ekstarnal fade transaction not included in the dart library
class BaseFadeRoute extends PageRouteBuilder {
  final Widget page;
  BaseFadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
