import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/LoginRegister/Model/signUpViewModel.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/routeNames.dart';
import 'package:digitalt_application/Pages/UserTerms.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../locator.dart';
import '../uiHelpers.dart';
import '../Widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  final Function toggleView;
  SignUpView({this.toggleView});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final Color logoGreen = Color(0xff25bcbb);

  final NavigationService _navigationService = locator<NavigationService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phonenumberController = TextEditingController();
  bool agreedToSecurityTerms = false;
  String needToAgree = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) =>
          ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                MaterialButton(
                    child: Text('Logg inn'),
                    onPressed: () {
                      _navigationService.navigateTo(LoginViewRoute);
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
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Registrer deg',
                            style: TextStyle(
                              fontSize: 38,
                            ),
                          ),
                          verticalSpaceLarge,
                          InputField(
                            placeholder: 'Fullt navn',
                            controller: fullNameController,
                          ),
                          verticalSpaceSmall,
                          InputField(
                            placeholder: 'E-post',
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                          ),
                          verticalSpaceSmall,
                          InputField(
                            placeholder: 'Telefonnummer',
                            textInputType: TextInputType.number,
                            controller: phonenumberController,
                          ),
                          verticalSpaceSmall,
                          InputField(
                            placeholder: 'Passord',
                            password: true,
                            controller: passwordController,
                            additionalNote:
                                'Passordet må minst inneholde 6 karakterer.',
                          ),
                          verticalSpaceSmall,
                          ResponsiveGridRow(children: [
                            ResponsiveGridCol(
                                xs: 12,
                                sm: 12,
                                md: 6,
                                lg: 6,
                                child: Row(
                                  children: [
                                    Text(
                                        'Jeg godkjenner personvernerklæringene '),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Checkbox(
                                      value: agreedToSecurityTerms,
                                      activeColor: Colors.red,
                                      onChanged: (bool value) {
                                        setState(() {
                                          agreedToSecurityTerms = value;
                                          if (value) {
                                            needToAgree = '';
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                )),
                            ResponsiveGridCol(
                              xs: 12,
                              sm: 12,
                              md: 6,
                              lg: 6,
                              child: MaterialButton(
                                child: Text('Les personvernerklæring her'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserTermsPage()));
                                },
                              ),
                            )
                          ]),
                          Text(
                            needToAgree,
                            style: TextStyle(color: Colors.red),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (agreedToSecurityTerms) {
                                    model.setSelectedRole('User');
                                    model.signUp(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phonenumber: phonenumberController.text,
                                        fullName: fullNameController.text);
                                  } else {
                                    setState(() {
                                      needToAgree =
                                          'Du må godkjenne personvernerklæring';
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Registrer deg',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        theme.state ? Colors.red : logoGreen),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
