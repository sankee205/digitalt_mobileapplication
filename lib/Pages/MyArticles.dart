import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCaseBox.dart';
import 'package:digitalt_application/LoginRegister/Views/loginView.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:digitalt_application/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

/// this page will display the user profile
class MyArticles extends StatefulWidget {
  @override
  _MyArticlesState createState() => _MyArticlesState();
}

class _MyArticlesState extends State<MyArticles> {
  final AuthService _auth = AuthService();

  final DatabaseService _db = DatabaseService();
  BaseUser _currentUser = BaseUser();
  List _allCases = [];
  List _myCases = [];
  List _userMyCases = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataBaseList();
    _setBaseUser();
  }

  _fetchDataBaseList() async {
    dynamic resultant = await _db.getCaseItems('AllCases');
    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        _allCases = resultant;
      });
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

  _createMyCaseList() {
    List newList = [];
    if (_userMyCases.isNotEmpty) {
      for (int i = 0; i < _allCases.length; i++) {
        for (int j = 0; j < _userMyCases.length; j++) {
          var object = _allCases[i];
          if (object['title'] == _userMyCases[j]) {
            newList.add(_allCases[i]);
          }
        }
      }
    }
    setState(() {
      _myCases = newList;
    });
  }

  _setBaseUser() async {
    if (!_auth.isUserAnonymous()) {
      var user = await _auth.getFirebaseUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
          _userMyCases = user.myCases;
        });
      } else {
        print('user from authservice is null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _createMyCaseList();
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
                  child: _auth.isUserAnonymous()
                      ? Column(
                          children: [
                            SizedBox(height: 50),
                            Text(
                                'Du kan ikke lagre noen artikler når du ikke er innlogget'),
                            SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Logg inn'),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Dine Lagrede Artikler',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ResponsiveGridRow(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: _myCases.map((caseObject) {
                                return ResponsiveGridCol(
                                    lg: 6,
                                    md: 6,
                                    xs: 6,
                                    child: Container(
                                        margin: EdgeInsets.all(5),
                                        height: 250,
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CasePage(
                                                            image: caseObject[
                                                                'image'],
                                                            title: caseObject[
                                                                'title'],
                                                            author: caseObject[
                                                                'author'],
                                                            publishedDate:
                                                                caseObject[
                                                                    'publishedDate'],
                                                            introduction:
                                                                caseObject[
                                                                    'introduction'],
                                                            text: caseObject[
                                                                'text'],
                                                            lastEdited:
                                                                caseObject[
                                                                    'lastEdited'],
                                                            searchBar: false,
                                                          )));
                                            },
                                            child: BaseCaseBox(
                                              image: caseObject['image'],
                                              title: caseObject['title'],
                                              guestCaseItem: true,
                                            ))));
                              }).toList(),
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
