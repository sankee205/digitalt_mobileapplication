import 'package:digitalt_application/LoginRegister/Views/startUpView.dart';
import 'package:digitalt_application/LoginRegister/locator.dart';
import 'package:digitalt_application/LoginRegister/navigationService.dart';
import 'package:digitalt_application/LoginRegister/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppManagement/ThemeManager.dart';

/*
 * This is the main file that wil start running when the app is open and
 * it redirects to the homepage file to run the home page
 * @Sander Keedklang 
 * @Mathias Gjærde Forberg
 */

import 'Services/dialogService.dart';
import 'LoginRegister/dialogManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();

  // calls the class HomePage to run
  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
  // Register all the models and services before the app starts
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, widget) => MaterialApp(
          title: 'DIGI-TALT.NO',
          builder: (context, child) => Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(child: child)),
          ),
          navigatorKey: locator<NavigationService>().navigationKey,
          theme: theme.getTheme(),
          home: StartUpView(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
