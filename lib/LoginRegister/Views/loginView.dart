import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/LoginRegister/Model/loginViewModel.dart';
import 'package:digitalt_application/LoginRegister/Widgets/inputField.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/routeNames.dart';
import 'package:digitalt_application/LoginRegister/uiHelpers.dart';
import 'package:digitalt_application/Services/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../locator.dart';

class LoginView extends StatefulWidget {
  final Function toggleView;
  LoginView({this.toggleView});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final NavigationService _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Color logoGreen = Color(0xff25bcbb);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => ViewModelBuilder<
              LoginViewModel>.reactive(
          viewModelBuilder: () => LoginViewModel(),
          builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  MaterialButton(
                      child: Text('Registrer deg'),
                      onPressed: () {
                        _navigationService.navigateTo(SignUpViewRoute);
                      }),
                ],
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 800,
                    child: Material(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Logg inn her for å se alt av innhold hos DIGI-TALT.NO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 28),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Skriv inn e-post og passord her for å lese saker hos DIGI-TALT.NO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                                verticalSpaceMedium,
                                InputField(
                                    controller: emailController,
                                    placeholder: 'Email',
                                    textInputType: TextInputType.emailAddress,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    }),
                                verticalSpaceSmall,
                                InputField(
                                  controller: passwordController,
                                  placeholder: 'Passord',
                                  password: true,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                                verticalSpaceMedium,
                                MaterialButton(
                                  elevation: 0,
                                  minWidth: 210,
                                  height: 50,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() => error =
                                            'Kunne ikke logge inn. Email og/eller passord er feil!');
                                      } else {
                                        _navigationService
                                            .navigateTo(HomePageRoute);
                                      }
                                    }
                                  },
                                  color: theme.state ? Colors.red : logoGreen,
                                  child: Text('Logg inn',
                                      style: TextStyle(fontSize: 16)),
                                  textColor: Colors.white,
                                ),
                                SizedBox(height: 20),
                                verticalSpaceSmall,
                                MaterialButton(
                                  child: Text('Fortsett som gjest'),
                                  onPressed: () async {
                                    dynamic result = await _auth.signInAnon();
                                    if (result == null) {
                                    } else {
                                      _navigationService
                                          .navigateTo(HomePageRoute);
                                    }
                                  },
                                ),
                                verticalSpaceSmall,
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.0),
                                ),
                                verticalSpaceMedium,
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: _buildFooterLogo(),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ))),
    );
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('DIGI-TALT.NO',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
