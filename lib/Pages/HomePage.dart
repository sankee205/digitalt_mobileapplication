import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Layouts/BaseCarouselSlider.dart';
import 'package:digitalt_application/Layouts/BaseCaseBox.dart';
import 'package:digitalt_application/Layouts/BaseSearch.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/VippsApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:digitalt_application/Services/auth.dart';

/*
 * This is the main page of the flutter application and this is the window that will
 * open when you open the app. At the top it has an appbar with a drawer, then below 
 * the appbar a slider for newest/top X images, and at the end a gridview for all 
 * images in the list of items; _listItem.
 * 
 * @Sander Keedklang
 * 
 */

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

// this class represents a home page with a grid layout
class HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
  List _newCases = [];
  List _allCases = [];
  List _popularCases = [];

  String _currentUserRole;
  List<String> _guestList = [];

  //a list with only string objects for the search bar
  List<String> _allCaseList = [];
  List<String> _searchCaseList;

  //form key to evaluate the search bar input
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchDataBaseList('PopularCases');
    _fetchDataBaseList('AllCases');
    _fetchDataBaseList('NewCases');
    _getUserRole();
    _getGuestList();
  }

  _getUserRole() async {
    dynamic firebaseUserRole = await _auth.getUserRole();
    if (firebaseUserRole != null) {
      setState(() {
        _currentUserRole = firebaseUserRole;
      });
    } else {
      print('firebaseUserRole is null');
    }
  }

  _createStringList() {
    _allCaseList.clear();
    for (int i = 0; i < _allCases.length; i++) {
      var caseObject = _allCases[i];
      _allCaseList.add(caseObject['title']);
    }
  }

  /*_goToSingleCase(String title) {
    var caseObject;
    for (int i = 0; i < _allCases.length; i++) {
      var caseVar = _allCases[i];
      if (caseVar['title'] == title) {
        caseObject = caseVar;
      }
    }
    if (caseObject != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CasePage(
                    image: caseObject['image'],
                    title: caseObject['title'],
                    author: caseObject['author'],
                    publishedDate: caseObject['publishedDate'],
                    introduction: caseObject['introduction'],
                    text: caseObject['text'],
                    lastEdited: caseObject['lastEdited'],
                    searchBar: false,
                  )));
    }
  }*/

  _setSearchBarList() {
    switch (_currentUserRole) {
      case 'Admin':
        setState(() {
          _searchCaseList = _allCaseList;
        });
        break;
      case 'Subscriber':
        setState(() {
          _searchCaseList = _allCaseList;
        });
        break;
      case 'User':
        setState(() {
          _searchCaseList = _guestList;
        });
        break;
      case 'Guest':
        setState(() {
          _searchCaseList = _guestList;
        });
        break;
      default:
        setState(() {
          _searchCaseList = _guestList;
        });
    }
  }

  _getGuestList() async {
    List<String> firebaseList = [];
    List resultant = await _db.getGuestListContent();
    if (resultant != null) {
      for (int i = 0; i < resultant.length; i++) {
        var object = resultant[i];
        firebaseList.add(object['Title'].toString());
      }
      setState(() {
        _guestList = firebaseList;
      });
    } else {
      print('resultant is null');
    }
  }

  _fetchDataBaseList(String folder) async {
    dynamic resultant = await _db.getCaseItems(folder);

    if (resultant == null) {
      print('unable to get data');
    } else {
      setState(() {
        switch (folder) {
          case 'PopularCases':
            {
              _popularCases = resultant;
            }
            break;

          case 'NewCases':
            {
              _newCases = resultant;
            }
            break;
          case 'AllCases':
            {
              _allCases = resultant;
            }
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _createStringList();
    _setSearchBarList();
    //returns a material design
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT.NO',
          style: TextStyle(color: Colors.white),
        ),
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
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: BaseSearch(
                            allCases: _searchCaseList, allCaseList: _allCases));
                  },
                  child: Icon(Icons.search)))
        ],
        appBar: AppBar(),
        /*widgets: <Widget>[
          Icon(Icons.more_vert),
        ],*/
      ),
      bottomNavigationBar: BaseBottomAppBar(),

      //creates the menu in the appbar(drawer)
      drawer: BaseAppDrawer(),

      //here comes the body of the home page
      body: SingleChildScrollView(
          child: Center(
        child: Container(
            width: 800,
            child: Material(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        lg: 8,
                        xs: 12,
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 320,
                                child: ListView(
                                  children: <Widget>[
                                    //should we add a play and stop button?
                                    BaseCarouselSlider(_popularCases)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveGridCol(
                        lg: 4,
                        xs: 12,
                        child: Container(
                          width: 400,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    'Siste Nytt',
                                    style: TextStyle(
                                      fontSize: 25,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  children: _newCases.map((caseObject) {
                                    return Builder(builder: (
                                      BuildContext context,
                                    ) {
                                      //makes the onclick available
                                      return _casesContainer(caseObject, false);
                                    });
                                  }).toList(),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ResponsiveGridRow(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _allCases.map((caseObject) {
                      return ResponsiveGridCol(
                          lg: 6,
                          md: 6,
                          xs: 12,
                          child: Container(
                              //margin: EdgeInsets.fromLTRB(6, 10, 6, 10),
                              height: 250,
                              child: _casesContainer(caseObject, true)));
                    }).toList(),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )),
      )),
    );
  }

  _goToCasePage(dynamic caseObject) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CasePage(
                  image: caseObject['image'],
                  title: caseObject['title'],
                  author: caseObject['author'],
                  publishedDate: caseObject['publishedDate'],
                  introduction: caseObject['introduction'],
                  text: caseObject['text'],
                  lastEdited: caseObject['lastEdited'],
                  searchBar: false,
                )));
  }

  _casesContainer(dynamic caseObject, bool alllist) {
    switch (_currentUserRole) {
      case 'Admin':
        return GestureDetector(
            onTap: () {
              _goToCasePage(caseObject);
            },
            child: alllist
                ? BaseCaseBox(
                    image: caseObject['image'],
                    title: caseObject['title'],
                    guestCaseItem: _guestList.contains(caseObject['title']),
                  )
                : Container(
                    //height: 40,
                    width: 500,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade600)),
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        caseObject['title'],
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ));

        break;
      case 'Subscriber':
        return GestureDetector(
            onTap: () {
              _goToCasePage(caseObject);
            },
            child: alllist
                ? BaseCaseBox(
                    image: caseObject['image'],
                    title: caseObject['title'],
                    guestCaseItem: _guestList.contains(caseObject['title']),
                  )
                : Container(
                    //height: 40,
                    width: 500,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade600)),
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        caseObject['title'],
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ));

        break;
      case 'User':
        return GestureDetector(
            onTap: () {
              if (_guestList.contains(caseObject['title'])) {
                _goToCasePage(caseObject);
              }
            },
            child: alllist
                ? BaseCaseBox(
                    image: caseObject['image'],
                    title: caseObject['title'],
                    guestCaseItem: _guestList.contains(caseObject['title']),
                  )
                : Container(
                    //height: 40,
                    width: 500,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade600)),
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        caseObject['title'],
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ));

        break;
      case 'Guest':
        return GestureDetector(
            onTap: () {
              if (_guestList.contains(caseObject['title'])) {
                _goToCasePage(caseObject);
              }
            },
            child: alllist
                ? BaseCaseBox(
                    image: caseObject['image'],
                    title: caseObject['title'],
                    guestCaseItem: _guestList.contains(caseObject['title']),
                  )
                : Container(
                    //height: 40,
                    width: 500,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade600)),
                    margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    alignment: Alignment.topLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        caseObject['title'],
                        style: TextStyle(fontStyle: FontStyle.normal),
                      ),
                    ),
                  ));

        break;
    }
  }
}
