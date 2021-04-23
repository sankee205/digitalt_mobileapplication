import 'package:digitalt_application/LoginRegister/Model/signUpViewModel.dart';
import 'package:digitalt_application/LoginRegister/Views/loginView.dart';

import '../uiHelpers.dart';
import '../Widgets/busyButton.dart';
import '../Widgets/expansionList.dart';
import '../Widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final Function toggleView;
  SignUpView({this.toggleView});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
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
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => LoginView()));
                  }),
            ],
          ),
          body: Material(
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
                  ),
                  verticalSpaceSmall,
                  InputField(
                    placeholder: 'Telefonnummer',
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BusyButton(
                        title: 'Registrer deg',
                        busy: model.busy,
                        onPressed: () {
                          model.setSelectedRole('User');
                          model.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              phonenumber: phonenumberController.text,
                              fullName: fullNameController.text);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
