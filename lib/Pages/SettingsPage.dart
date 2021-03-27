import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/**
 * this is the profile page.
 */
class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, child) =>Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text('DIGI-TALT', style: TextStyle(color: Colors.white),),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
          child: Container(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                    width: 600,
                    child:Material(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('Mørkt modus'),
                              SizedBox(height: 10.0,),
                              Switch(
                                activeColor: Colors.green,
                                value: theme.getState(),
                                onChanged: (value) {
                                  setState(() {
                                    if(value == true){
                                      theme.setDarkMode();
                                    }
                                    else{
                                      theme.setLightMode();
                                    }
                                  });
                                },
                              ),],
                          )


                        ],
                      ),
                    )),
              ))),
    ));
  }
}