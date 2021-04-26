import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/subscription.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

/// this page will display the user profile
class DisplayVippsOrder extends StatefulWidget {
  final dynamic jsonDetailString;
  final String uid;

  const DisplayVippsOrder(this.jsonDetailString, this.uid);
  @override
  _DisplayVippsOrderState createState() => _DisplayVippsOrderState();
}

class _DisplayVippsOrderState extends State<DisplayVippsOrder> {
  final AuthService _auth = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  String _amount;
  String _transactionId;
  @override
  void initState() {
    super.initState();
    _setOrderDetails();
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
        transactionText: transactionInfo['transactionText']);
    await _databaseService.updateSubscriptionData(widget.uid, mySubscription);
    setState(() {
      _amount = transactionInfo['amount'].toString();
      _transactionId = transactionInfo['transactionId'].toString();
    });
  }

  _signOut() async {
    print('signing out');
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
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
                      Text('Kr. ' + _amount),
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
