import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 * this is the settings page
 * here you can change the theme to dark or light mode
 */
class UserTermsPage extends StatefulWidget {
  final bool register;

  const UserTermsPage({Key key, @required this.register}) : super(key: key);
  @override
  _UserTermsPageState createState() => _UserTermsPageState();
}

class _UserTermsPageState extends State<UserTermsPage> {
  final DatabaseService _db = DatabaseService();
  String _text = '';
  String _date = '';

  _getGdpr() async {
    List resultList = await _db.getUserTermsContent();
    var result = resultList[0];
    setState(() {
      _text = result['text'];
      _date = result['date'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGdpr();
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
              bottomNavigationBar: widget.register ? null : BaseBottomAppBar(),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              //creates the menu in the appbar(drawer)
              drawer: widget.register ? null : BaseAppBar(),

              //here comes the body of the home page
              body: SingleChildScrollView(
                  child: Container(
                      child: Center(
                child: Container(
                    width: 600,
                    child: Material(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text('Personvernerklæring',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 20
                                          : 30)),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Text(_text),
                          ),
                          Text('Dato: ' + _date),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )),
              ))),
            ));
  }
}
