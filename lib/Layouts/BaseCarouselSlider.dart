import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:digitalt_application/Services/auth.dart';
import 'package:flutter/material.dart';

import 'BaseCaseBox.dart';

///
///this is the carousel slider used in
///the home page to display the most popular cases
///
class BaseCarouselSlider extends StatefulWidget {
  //list of cass it gets from the database
  final List _caseList;

  const BaseCarouselSlider(this._caseList);

  @override
  _BaseCarouselSliderState createState() => _BaseCarouselSliderState();
}

class _BaseCarouselSliderState extends State<BaseCarouselSlider> {
  String _currentUserRole;
  final AuthService _authService = AuthService();
  final DatabaseService _db = DatabaseService();
  List<String> _guestList = [];

  _getUserRole() async {
    dynamic firebaseUserRole = await _authService.getUserRole();
    if (firebaseUserRole != null) {
      setState(() {
        _currentUserRole = firebaseUserRole;
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

  @override
  void initState() {
    super.initState();
    _getUserRole();
    _getGuestList();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          aspectRatio: 0.25,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayInterval: Duration(seconds: 10),
          viewportFraction: 0.8,
          initialPage: 0),
      items: widget._caseList.map((caseObject) {
        return Builder(builder: (
          BuildContext context,
        ) {
          //makes the onclick available
          return GestureDetector(
              onTap: () {
                switch (_currentUserRole) {
                  case 'Admin':
                    {
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
                    break;
                  case 'User':
                    {
                      if (_guestList.contains(caseObject['title'])) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CasePage(
                                      image: caseObject['image'],
                                      title: caseObject['title'],
                                      author: caseObject['author'],
                                      publishedDate:
                                          caseObject['publishedDate'],
                                      introduction: caseObject['introduction'],
                                      text: caseObject['text'],
                                      lastEdited: caseObject['lastEdited'],
                                      searchBar: false,
                                    )));
                      }
                    }
                    break;
                  case 'Subscriber':
                    {
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
                    break;
                  case 'Guest':
                    {
                      if (_guestList.contains(caseObject['title'])) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CasePage(
                                      image: caseObject['image'],
                                      title: caseObject['title'],
                                      author: caseObject['author'],
                                      publishedDate:
                                          caseObject['publishedDate'],
                                      introduction: caseObject['introduction'],
                                      text: caseObject['text'],
                                      lastEdited: caseObject['lastEdited'],
                                      searchBar: false,
                                    )));
                      }
                    }
                    break;
                }
              },
              child: BaseCaseBox(
                image: caseObject['image'],
                title: caseObject['title'],
                guestCaseItem: _guestList.contains(caseObject['title']),
              ));
        });
      }).toList(),
    );
  }
}
