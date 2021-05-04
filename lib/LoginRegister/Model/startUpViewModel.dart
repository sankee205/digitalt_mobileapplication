import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/routeNames.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/baseModel.dart';

class StartUpViewModel extends BaseModel {
  final AuthService _authenticationService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomePageRoute);
    } else {
      await _authenticationService.signInAnon().then((value) {
        _navigationService.navigateTo(HomePageRoute);
      });
    }
  }
}
