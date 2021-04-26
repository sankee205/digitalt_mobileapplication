import 'dart:convert';
import 'dart:io';

import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/VippsApi.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher.dart';

/// this page will display the user profile
class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final AuthService _auth = AuthService();
  final VippsApi _vippsApi = VippsApi();
  BaseUser _currentUser;
  bool _isAppInstalled = false;

  @override
  void initState() {
    super.initState();
    _setBaseUser();
    _getAccessToken();
    _appInstalled();
  }

  _appInstalled() async {
    /*bool value = await LaunchApp.isAppInstalled(
        androidPackageName: 'vipps', iosUrlScheme: 'vipps://');
    if (value != null) {
      setState(() {
        _isAppInstalled = value;
      });
    }*/
  }

  _getAccessToken() async {
    var token = await _vippsApi.getAccessToken();
    if (token != null) {
      print('_accesstoken recieved');
    }
  }

  _setBaseUser() async {
    if (!_auth.isUserAnonymous()) {
      var user = await _auth.getFirebaseUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
      } else {
        print('Base user is null');
      }
    }
  }

  _signOut() async {
    print('signing out');
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  _initiateVipps() async {
    if (_isAppInstalled) {
      await _vippsApi.initiatePayment('93249909').then((value) async {
        await LaunchApp.openApp(
            androidPackageName: 'vipps.   vipps',
            iosUrlScheme: 'vipps://',
            openStore: false);
      });
    } else {
      await _vippsApi.initiatePayment('93249909').then((value) async {
        await _webLaunch(true, value);
        await _vippsApi.getPaymentDetails();
      });
      sleep(const Duration(seconds: 5));
      _capturePayment();
    }
  }

  _webLaunch(bool state, String url) async {
    switch (state) {
      case true:
        print('opening web view');
        await launch(url);
        break;
      case false:
        print('closing web view');
        await closeWebView();
        break;
      default:
    }
  }

  _capturePayment() async {
    dynamic response = await _vippsApi.capturePayment();
    print(response);
    if (response.contains('status')) {
      print('contains status');
    }

    switch (response) {
      case '404':
        sleep(const Duration(seconds: 3));
        _capturePayment();
        break;
      case '402':
        sleep(const Duration(seconds: 3));
        _capturePayment();
        break;
      case '429':
        sleep(const Duration(seconds: 4));
        _capturePayment();
        break;
      default:
    }

    //_webLaunch(false, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this is the appbar for the home page
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

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Container(
                width: 800,
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Abonnement',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ResponsiveGridRow(
                        children: [
                          ResponsiveGridCol(
                            xl: 6,
                            lg: 6,
                            xs: 12,
                            child: GestureDetector(
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  width: 300,
                                  child: Material(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          color: Colors.greenAccent,
                                          height: 75,
                                          child: Center(
                                            child: Text(
                                              'Abonnement 1',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          color: Colors.white,
                                          height: 200,
                                          child: Center(
                                            child: Text('Et års abonnement'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                              onTap: () {
                                _initiateVipps();
                              },
                            ),
                          ),
                          ResponsiveGridCol(
                              xl: 6,
                              lg: 6,
                              xs: 12,
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  width: 300,
                                  child: Material(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          color: Colors.greenAccent,
                                          height: 75,
                                          child: Center(
                                            child: Text(
                                              'Abonnement 2',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 10, 5),
                                          color: Colors.white,
                                          height: 200,
                                          child: Center(
                                            child: Text(
                                                'Prøve abonnement: 1 måned'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ))),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
