import 'dart:io';

import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Pages/DisplayVippsOrder.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/VippsApi.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher.dart';

/// this page will display the user profile
class SubscriptionPage extends StatefulWidget {
  final BaseUser _currentUser;

  const SubscriptionPage(this._currentUser);
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final VippsApi _vippsApi = VippsApi();
  final DatabaseService _db = DatabaseService();
  int _type;

  String _month = '';
  String _year = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _getAccessToken();
    _getPrices();
  }

  _getPrices() async {
    List resultant = await _db.getVippsPricesContent();
    if (resultant != null) {
      var result = resultant[0];
      print(result);
      setState(() {
        _month = result['oneMonth'];
        _year = result['oneYear'];
      });
    } else {
      print('resultant is null');
    }
  }

  _getAccessToken() async {
    var token = await _vippsApi.getAccessToken();
    if (token.contains('error')) {
      setState(() {
        error = token;
      });
    }
  }

  _initiateVipps(String cost) async {
    await _vippsApi
        .initiatePayment(widget._currentUser.phonenumber, _type, cost)
        .then((value) async {
      if (value != null) {
        await _webLaunch(true, value);
        await _vippsApi.getPaymentDetails();
      }
    });
    sleep(const Duration(seconds: 10));
    _capturePayment();
  }

  _webLaunch(bool state, String url) async {
    print('in web launch');
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
    String captureCost;
    if (_type == 1) {
      captureCost = _year;
    } else {
      captureCost = _month;
    }
    dynamic response = await _vippsApi.capturePayment(captureCost, _type);
    print(response);
    if (response.toString().contains('status')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DisplayVippsOrder(response, widget._currentUser.uid, _type),
        ),
      );
      _webLaunch(false, null);
    } else {
      switch (response) {
        case '404':
          sleep(const Duration(seconds: 10));
          _capturePayment();
          break;
        case '402':
          sleep(const Duration(seconds: 10));
          _capturePayment();
          break;
        case '429':
          _webLaunch(false, null);
          break;
        case 'denied':
          _webLaunch(false, null);

          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
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
                    child: widget._currentUser.mySubscription.status ==
                            'nonActive'
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'VELG ABONNEMENT OG BETAL MED ',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  700
                                              ? 15
                                              : 30),
                                    ),
                                    Image(
                                      image: AssetImage(
                                          'assets/vipps/vippsLogo.png'),
                                      width: MediaQuery.of(context).size.width <
                                              700
                                          ? 50
                                          : 100,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ResponsiveGridRow(
                                children: [
                                  ResponsiveGridCol(
                                    xl: 6,
                                    lg: 6,
                                    xs: 12,
                                    child: Container(
                                        margin: EdgeInsets.all(5),
                                        width: 300,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 0),
                                                color: Colors.redAccent,
                                                height: 75,
                                                child: Center(
                                                  child: Text(
                                                    '1 ÅR',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: theme.getState()
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                color: theme.getState() == false
                                                    ? null
                                                    : Colors.grey.shade800,
                                                height: 200,
                                                child: Center(
                                                    child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      _displayAmount(_year) +
                                                          'kr',
                                                      style: TextStyle(
                                                          color: theme
                                                                  .getState()
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 30),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    FlatButton(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      height: 50,
                                                      minWidth: 200,
                                                      onPressed: () {
                                                        setState(() {
                                                          _type = 1;
                                                        });
                                                        _initiateVipps(_year);
                                                      },
                                                      child: Text(
                                                        'KJØP NÅ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                      color: Colors.deepOrange,
                                                    ),
                                                  ],
                                                )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  ResponsiveGridCol(
                                    xl: 6,
                                    lg: 6,
                                    xs: 12,
                                    child: Container(
                                        margin: EdgeInsets.all(5),
                                        width: 300,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 0),
                                                color: Colors.redAccent,
                                                height: 75,
                                                child: Center(
                                                  child: Text(
                                                    'PRØV 1 MÅNED',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: theme.getState()
                                                            ? Colors.black
                                                            : Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                color: theme.getState() == false
                                                    ? null
                                                    : Colors.grey.shade800,
                                                height: 200,
                                                child: Center(
                                                    child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      _displayAmount(_month) +
                                                          'kr',
                                                      style: TextStyle(
                                                          color: theme
                                                                  .getState()
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 30),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    widget
                                                            ._currentUser
                                                            .mySubscription
                                                            .freeMonthUsed
                                                        ? Text(
                                                            'Du har allerede brukt din prøve måned',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          )
                                                        : FlatButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            height: 50,
                                                            minWidth: 200,
                                                            onPressed: () {
                                                              if (widget
                                                                      ._currentUser
                                                                      .mySubscription
                                                                      .freeMonthUsed !=
                                                                  true) {
                                                                setState(() {
                                                                  _type = 2;
                                                                });
                                                                _initiateVipps(
                                                                    _month);
                                                              } else {}
                                                            },
                                                            child: Text(
                                                              'KJØP NÅ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17),
                                                            ),
                                                            color: Colors
                                                                .deepOrange,
                                                          ),
                                                  ],
                                                )),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  width: 300,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 5, 10, 0),
                                          color: Colors.redAccent,
                                          height: 75,
                                          child: Center(
                                            child: Text(
                                              'Ditt Abonnement',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: theme.getState()
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          color: theme.getState() == false
                                              ? null
                                              : Colors.grey.shade800,
                                          height: 200,
                                          child: Center(
                                              child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Type: ' +
                                                    widget
                                                        ._currentUser
                                                        .mySubscription
                                                        .transactionText,
                                                style: TextStyle(
                                                    color: theme.getState()
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Betalt: ' +
                                                    _displayAmount(
                                                      widget
                                                          ._currentUser
                                                          .mySubscription
                                                          .amount,
                                                    ),
                                                style: TextStyle(
                                                    color: theme.getState()
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'Status: ' +
                                                    widget._currentUser
                                                        .mySubscription.status
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                    color: theme.getState()
                                                        ? Colors.white
                                                        : Colors.black),
                                              )
                                            ],
                                          )),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  _displayAmount(String number) {
    if (number != '') {
      List<String> characterList = number.split('');
      characterList.insert(number.length - 2, ',');
      String newNumber = characterList.join();
      return newNumber;
    } else {
      return '';
    }
  }
}
