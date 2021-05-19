import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Pages/ProfilePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Layouts/BaseAppBar.dart';
import '../Layouts/BaseAppDrawer.dart';

/*
 * this is the add case form. it is used by the admin to add cases
 * to the database and the app.
 *
 * this page is only available on web
 */
class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String uid;
  final String phonenumber;

  const EditProfilePage({
    Key key,
    @required this.name,
    @required this.email,
    @required this.uid,
    @required this.phonenumber,
  }) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color logoGreen = Color(0xff25bcbb);

  DatabaseService _db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String _id;
  final _fullname = TextEditingController();
  final _emailAdress = TextEditingController();
  final _number = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setProfileDetails();
  }

  ///this method will set the caseitems in page from input fields to the widget
  Future _setProfileDetails() async {
    setState(() {
      _fullname.text = widget.name;
      _emailAdress.text = widget.email;
      _number.text = widget.phonenumber;
      _id = widget.uid;
    });
  }

  ///this methods will update the case in firebase
  bool _changeProfileData() {
    bool success = true;

    dynamic result = _db.updateUserData(
        _id, _fullname.text, _emailAdress.text, _number.text);
    if (result != null) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  @override
  void dispose() {
    _fullname.dispose();
    _emailAdress.dispose();
    _number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
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

        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        //creates the menu in the appbar(drawer)
        drawer: BaseAppDrawer(),

        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Container(
                width: 400,
                child: Material(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Rediger din Brukerinformasjon',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 25),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),

                          Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // name textfield
                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: TextFormField(
                              controller: _fullname,
                              validator: (v) {
                                if (v.trim().isEmpty)
                                  return 'Please enter something';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: TextFormField(
                              controller: _emailAdress,
                              validator: (v) {
                                if (v.trim().isEmpty)
                                  return 'Please enter something';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Telefon nummer',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right: 32.0),
                            child: TextFormField(
                              controller: _number,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(8),
                              ],
                              validator: (v) {
                                if (v.trim().isEmpty)
                                  return 'Please enter something';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  _showAlertPublishDialog(context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Lagre endringer',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      theme.state ? Colors.red : logoGreen),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        if (_changeProfileData()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Publisere endring av profildata"),
      content: Text("Er du sikker på at du vil publisere disse endringen?"),
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
