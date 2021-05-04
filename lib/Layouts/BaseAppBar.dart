import 'package:flutter/material.dart';

///
///This is a Base App Bar class. It is a class for the appbar that will be used
///in all the different pages in the app/web app
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final Color backgroundColor = Colors.red;
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar({
    Key key,
    this.title,
    this.appBar,
    this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title, actions: widgets);
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
