import 'package:digitalt_application/Layouts/BaseFadeRoute.dart';
import 'package:digitalt_application/Pages/HomePage.dart';
import 'package:digitalt_application/Pages/MyArticles.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:flutter/material.dart';

///
///this is the bass bottom app bar. it is a class for the bottom app bar so
///we dont need to implement the bottom app bar in every page
///
class BaseBottomAppBar extends StatefulWidget {
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const BaseBottomAppBar({Key key, this.appBar}) : super(key: key);
  @override
  _BaseBottomAppBarState createState() => _BaseBottomAppBarState();
}

class _BaseBottomAppBarState extends State<BaseBottomAppBar> {
  List<Widget> _buildScreens() {
    return [HomePage(), MyArticles(), ProfilePage()];
  }

  void onTabTapped(int index) {
    Navigator.push(context, BaseFadeRoute(page: _buildScreens()[index]));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Hjem',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storage),
          label: 'Mine Artikler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Min Profil',
        ),
      ],
      //selectedItemColor: Colors.red,
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(widget.appBar.preferredSize.height);
}
