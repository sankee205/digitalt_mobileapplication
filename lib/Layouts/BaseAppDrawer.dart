import 'package:digitalt_application/LoginRegister/Views/loginView.dart';
import 'package:digitalt_application/LoginRegister/Views/startUpView.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Pages/SettingsPage.dart';
import 'package:digitalt_application/Pages/SubscriptionPage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/HomePage.dart';
import '../Pages/InfoPage.dart';

///
///this is a Base App Drawer. It wil be used in all the pages.
///It is a class made so we dont need to write this for every new
///page in the app/ web app
///
class BaseAppDrawer extends StatefulWidget {
  @override
  _BaseAppDrawerState createState() => _BaseAppDrawerState();
}

final AuthService _auth = AuthService();

final DatabaseService _db = DatabaseService();
List _infoList = [];
List _text = [];
List _author = [];
String _contactPhoto = '';
String _date = '';
String _email = '';
String _textPhoto = '';
String _tlf = '';
String _backgroundPhoto = '';

class _BaseAppDrawerState extends State<BaseAppDrawer> {
  String _currentUserRole = 'User';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
    _getUserRole();
  }

  _getUserRole() async {
    dynamic firebaseUserRole = await _auth.getUserRole();
    if (firebaseUserRole != null) {
      setState(() {
        _currentUserRole = firebaseUserRole;
      });
    }
  }

  Future _getInfo() async {
    List resultant = await _db.getInfoPageContent();
    if (resultant != null) {
      var result = resultant[0];
      setState(() {
        _textPhoto = result['textPhoto'];
        _contactPhoto = result['contactPhoto'];
        _backgroundPhoto = result['backgroundPhoto'];
        _text = result['text'];
        _author = result['author'];
        _date = result['date'];
        _email = result['email'];
        _tlf = result['tlf'];
      });
    } else {
      print('resultant is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'DIGI-TALT.NO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InfoPage(
                          infoList: _infoList,
                          text: _text,
                          author: _author,
                          contactPhoto: _contactPhoto,
                          date: _date,
                          email: _email,
                          textPhoto: _textPhoto,
                          backgroundPhoto: _backgroundPhoto,
                          tlf: _tlf)));
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Abonnement'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubscriptionPage()));
            },
          ),
          _auth.isUserAnonymous()
              ? ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Logg inn'),
                  onTap: () {
                    _signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                  },
                )
              : ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logg ut'),
                  onTap: () {
                    showAlertSignOutDialog(context);
                  },
                ),
        ],
      ),
    );
  }

  _signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Widget showAlertSignOutDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Nei"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ja"),
      onPressed: () {
        _signOut();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StartUpView()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logg ut av DIGI-TALT.NO"),
      content: Text("Er du sikker på at du vil logge ut?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
