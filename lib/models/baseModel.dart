import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authenticationService = locator<AuthService>();
  BaseUser get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
