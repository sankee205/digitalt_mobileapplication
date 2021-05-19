import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:responsive_grid/responsive_grid.dart';

/*
 * this is the Case Page. t takes in a caseitem and creates a layout 
 * for the caseitem to be read.
 */
class CasePage extends StatefulWidget {
  final bool searchBar;
  final String image;
  final String title;
  final List author;
  final String publishedDate;
  final String lastEdited;
  final String introduction;
  final List text;

  CasePage(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.author,
      @required this.publishedDate,
      @required this.introduction,
      @required this.text,
      @required this.searchBar,
      this.lastEdited})
      : super(key: key);
  @override
  _CasePageState createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();

  BaseUser _currentUser;
  Text _lastEditedText;
  bool isArticleSaved;

  _setBaseUser() async {
    if (!_auth.isUserAnonymous()) {
      var user = await _auth.getFirebaseUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
        });
        if (user.myCases.contains(widget.title)) {
          setState(() {
            isArticleSaved = true;
          });
        } else {
          setState(() {
            isArticleSaved = false;
          });
        }
      } else {
        print('user from authservice is null');
      }
    }
  }

  _changeMyCasesList(bool value) {
    if (!value && _currentUser.myCases.contains(widget.title)) {
      List newList = _currentUser.myCases;
      newList.remove(widget.title);
      _updateMyCasesList(newList);
    }
    if (value && !_currentUser.myCases.contains(widget.title)) {
      List newList = _currentUser.myCases;
      newList.add(widget.title);
      _updateMyCasesList(newList);
    }
  }

  bool _updateMyCasesList(List newMyCaseList) {
    bool success = true;
    dynamic result = _db.updateMyCasesData(_currentUser.uid, newMyCaseList);
    if (result != null) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  @override
  void initState() {
    super.initState();
    _setBaseUser();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lastEdited != null) {
      _lastEditedText = Text('Sist endret: ' + widget.lastEdited);
    }
    return Scaffold(
      //this is the appbar for the home page
      appBar: widget.searchBar
          ? null
          : BaseAppBar(
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
      //here starts the body
      body: Center(
        child: Container(
          width: 1200,
          alignment: Alignment.topCenter,
          //this is the backgound image of the case

          //here starts the case
          child: Container(
            width: 800,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 800,
                              child: Image(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //this is the title
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ResponsiveGridRow(
                                children: [
                                  ResponsiveGridCol(
                                    lg: 4,
                                    xs: 4,
                                    child: Row(
                                      children: [
                                        Icon(Icons.person),
                                        Container(
                                          width: 60,
                                          margin: EdgeInsets.all(10),
                                          child: ResponsiveGridRow(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children:
                                                widget.author.map((author) {
                                              return ResponsiveGridCol(
                                                  xl: 12,
                                                  md: 12,
                                                  xs: 12,
                                                  child: Container(
                                                    child: Text(
                                                      author,
                                                      style: TextStyle(
                                                          fontSize: 9),
                                                    ),
                                                  ));
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ResponsiveGridCol(
                                    lg: 4,
                                    xs: 4,
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range),
                                        Text(
                                          widget.publishedDate,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ResponsiveGridCol(
                                    lg: 4,
                                    xs: 4,
                                    child: isArticleSaved == null
                                        ? SizedBox()
                                        : Row(children: [
                                            Text(
                                              'Lagre Artikkel',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Checkbox(
                                              value: isArticleSaved,
                                              activeColor: Colors.red,
                                              onChanged: (bool newValue) {
                                                _changeMyCasesList(newValue);
                                                setState(() {
                                                  isArticleSaved = newValue;
                                                });
                                              },
                                            ),
                                          ]),
                                  ),
                                ],
                              ),
                            ),
                            //in this row you find author and published date

                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                widget.introduction,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //this is the description of the case. the main text
                            //this is the description of the case. the main text
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 700,
                              child: Column(
                                children: widget.text.map((item) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: _lastEditedText == null
                                  ? Text(
                                      'Denne artikkelen har aldri blitt endret')
                                  : _lastEditedText,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
