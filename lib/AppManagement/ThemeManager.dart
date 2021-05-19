import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'StorageManager.dart';
import 'package:flutter/material.dart';

/// this class holds the different theme colors for the app
/// light and d
class ThemeNotifier with ChangeNotifier {
  bool state;
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    accentColor: Colors.red,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade900,
        iconTheme: IconThemeData(color: Colors.red)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade900,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.red),

    //canvasColor: Colors.amberAccent
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade200,
    accentIconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.red,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.red, unselectedItemColor: Colors.grey),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Color(0xff25bcbb)),
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        state = false;
        _themeData = lightTheme;
      } else {
        state = true;
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    state = true;
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    state = false;
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  bool getState() {
    return state;
  }
}
