import 'package:digitalt_application/AppManagement/StorageManager.dart';
import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/routeNames.dart';
import 'package:digitalt_application/Pages/EditProfilePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// this page will display the user profile
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color logoGreen = Color(0xff25bcbb);

  final AuthService _auth = AuthService();
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _db = DatabaseService();
  BaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    _setBaseUser();
  }

  _setBaseUser() async {
    if (!_auth.isUserAnonymous()) {
      var user = await _auth.getFirebaseUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      } else {
        print('Base user is null');
      }
    }
  }

  _signOut() async {
    print('signing out');
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  _deleteUser() {
    _auth.deleteUser();
    _db.deleteUser(_currentUser.uid);
    StorageManager.deleteData('uid');
  }

  ///creates an alertdialog before pushing changes to firebase
  Widget _showAlertPublishDialog(BuildContext context) {
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
        _deleteUser();
        _navigationService.navigateTo(LoginViewRoute);
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sletting av bruker"),
      content: Text("Er du sikker på at du vil slette denne brukeren?"),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
        //this is the appbar for the home page
        appBar: BaseAppBar(
          title: Text(
            'DIGI-TALT.NO',
            style: TextStyle(color: Colors.white),
          ),
          appBar: AppBar(),
          widgets: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                width: 36,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular((20))),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BaseBottomAppBar(),

        //creates the menu in the appbar(drawer)
        drawer: BaseAppDrawer(),

        //here comes the body of the home page
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Container(
                  width: 400,
                  child: Material(
                    child: _auth.isUserAnonymous()
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text('Logg inn for å lese flere saker'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _signOut();
                                  _navigationService.navigateTo(LoginViewRoute);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Logg inn'),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        theme.state ? Colors.red : logoGreen),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Din Profildata',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.person,
                                size: 50,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Navn: ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  _currentUser == null
                                      ? Text('')
                                      : Text(
                                          _currentUser.fullName,
                                          style: TextStyle(fontSize: 15),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Email: ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  _currentUser == null
                                      ? Text('')
                                      : Text(
                                          _currentUser.email,
                                          style: TextStyle(fontSize: 15),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Mobilnummer: ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  _currentUser == null
                                      ? Text('')
                                      : Text(
                                          _currentUser.phonenumber,
                                          style: TextStyle(fontSize: 15),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Brukertype: ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  _currentUser == null
                                      ? Text('')
                                      : Text(
                                          _currentUser.userRole,
                                          style: TextStyle(fontSize: 15),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditProfilePage(
                                            email: _currentUser.email,
                                            name: _currentUser.fullName,
                                            phonenumber:
                                                _currentUser.phonenumber,
                                            uid: _currentUser.uid,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Rediger'),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: theme.state
                                            ? Colors.red
                                            : logoGreen),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showAlertPublishDialog(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('   Slett   '),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: theme.state
                                            ? Colors.red
                                            : logoGreen),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
