import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'StorageManager.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool state;
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    accentColor: Colors.red,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black.withOpacity(0.6), iconTheme: IconThemeData(color: Colors.red)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black.withOpacity(0.4),unselectedItemColor: Colors.white, selectedItemColor: Colors.red),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.red),

    //canvasColor: Colors.amberAccent
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade200,

    accentIconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(backgroundColor: Colors.red, iconTheme: IconThemeData(color: Colors.white), ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Colors.red,unselectedItemColor: Colors.grey),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blue),


  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        state = false;
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
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

  bool getState(){
    return state;
  }
}