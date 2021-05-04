import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/models/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:jiffy/jiffy.dart';

/// this page will display the user profile
class DisplayVippsOrder extends StatefulWidget {
  final dynamic jsonDetailString;
  final String uid;
  final int type;

  const DisplayVippsOrder(this.jsonDetailString, this.uid, this.type);
  @override
  _DisplayVippsOrderState createState() => _DisplayVippsOrderState();
}

class _DisplayVippsOrderState extends State<DisplayVippsOrder> {
  final DatabaseService _databaseService = DatabaseService();
  String _amount = '';
  String _transactionId = '';
  String _type = '';
  @override
  void initState() {
    super.initState();
    _setOrderDetails();
    _setUserRole();
  }

  _setOrderDetails() async {
    final responseArray = json.decode(widget.jsonDetailString);
    final transactionInfo = responseArray['transactionInfo'];
    Subscription mySubscription = Subscription(
        freeMonthUsed: false,
        orderId: responseArray['orderId'],
        status: 'active',
        amount: transactionInfo['amount'].toString(),
        timeStamp: transactionInfo['timeStamp'],
        expiredDate: _setExpiredDate(transactionInfo['timeStamp']),
        transactionText: transactionInfo['transactionText']);
    await _databaseService.updateSubscriptionData(widget.uid, mySubscription);
    setState(() {
      _amount = transactionInfo['amount'].toString();
      _transactionId = transactionInfo['transactionId'].toString();
      _type = transactionInfo['transactionText'];
    });
  }

  _setExpiredDate(String timeStamp) {
    switch (widget.type) {
      case 1:
        String yearSubscription =
            Jiffy(timeStamp).add(years: 1).dateTime.toString();
        return yearSubscription;
        break;
      case 2:
        String monthSubscription =
            Jiffy(timeStamp).add(months: 1).dateTime.toString();
        return monthSubscription;
        break;
      default:
    }
  }

  _displayAmount(String number) {
    if (number != '') {
      List<String> characterList = number.split('');
      characterList.insert(number.length - 2, ',');
      String newNumber = characterList.join();
      print(newNumber);
      return newNumber;
    } else {
      return '';
    }
  }

  _setUserRole() async {
    await _databaseService.setUserRole(widget.uid, 'Subscriber');
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
                width: 400,
                child: Material(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Takk for Handelen!',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Kr. ' + _displayAmount(_amount)),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Din abonnement er nå: ' + _type),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Transaksjonsnummer:  ' + _transactionId),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
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
