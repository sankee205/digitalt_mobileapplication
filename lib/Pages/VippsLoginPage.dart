import 'dart:convert';

import 'package:digitalt_application/Services/VippsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/Authenticate/loginPage.dart';

class VippsLoginPage extends StatefulWidget {

  @override
  _VippsLoginPageState createState() => _VippsLoginPageState();
}

class _VippsLoginPageState extends State<VippsLoginPage> {
  final number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 400,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Image(image: AssetImage('vipps/vippsLogo.png'),),
                        SizedBox(height: 20,),
                        Center(child: Text('Logg inn', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                        ),),),
                        SizedBox(height: 10,),
                        Center(
                          child: Text('DIGI-TALT', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold,)),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: number,
                            decoration: new InputDecoration(labelText: "TelefonNummer"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                          ),),
                        SizedBox(height: 20,),
                        SizedBox(
                          child: ElevatedButton(
                              child: Text(
                                  "Neste".toUpperCase(),
                                  style: TextStyle(fontSize: 14)
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      )
                                  )
                              ),
                              onPressed: (){
                                //VippsApi().getAccessToken();
                              }
                          ),
                        )
                      ]
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));},
                  child: Text('Avbryt', style: TextStyle(color: Colors.grey),))
            ],
          )
        ),
      )
    );
  }

}
