import 'package:digitalt_application/Pages/VippsLoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/Screens/Authenticate/authenticate.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            TextButton(
                child: Text('Registrer deg'),
                onPressed: () {
                  widget.toggleView();
                })
          ],
        ),
        backgroundColor: primaryColor,
        body: Center(
          child: Container(
            width: 800,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Logg inn her for å se alt av innhold hos DIGI-TALT',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Skriv inn e-post og passord her for å lese saker hos DIGI-TALT',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  ),

                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ characters long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 20,),
                  MaterialButton(
                    elevation: 0,
                    minWidth: 210,
                    height: 50,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() =>
                          error = 'Could not log in with those credentials!');
                        }
                      }
                    },
                    color: logoGreen,
                    child: Text('Logg inn',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 20),

                  FlatButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => VippsLoginPage()));},
                      child: Image.asset('vipps/login_image.png',width: 200,)),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    child: TextButton(
                      child: Text('sign in anon'),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('error signing in');
                        } else {
                          print('signed in');
                          print(result);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildFooterLogo(),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('DIGI-TALT',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
