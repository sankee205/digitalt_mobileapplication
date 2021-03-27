import 'dart:math';
import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:responsive_grid/responsive_grid.dart';

/*
 * this is the case PAge. t takes in a caseitem and creates a layout 
 * for the caseitem to be read.
 */
class CasePage extends StatelessWidget {
  final DatabaseService db = DatabaseService();
  //caseItem to be layed out in the casepage
  final String image;
  final String title;
  final List author;
  final String publishedDate;
  final String lastEdited;
  final String introduction;
  final List text;

  Text _lastEditedText;

  CasePage(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.author,
      @required this.publishedDate,
      @required this.introduction,
      @required this.text,
      this.lastEdited})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lastEdited != null) {
      _lastEditedText = Text('Sist edret: ' + lastEdited);
    }
    return Scaffold(
      //this is the appbar for the home page
      appBar: BaseAppBar(
        title: Text(
          'DIGI-TALT',
          style: TextStyle(color: Colors.white),
        ),
        appBar: AppBar(),
        widgets: <Widget>[Icon(Icons.more_vert)],
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0.0,
                        max(MediaQuery.of(context).size.width * 0.225, 225),
                        0.0,
                        0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.circular(35),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            //this is the title
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            //in this row you find author and published date
                            Row(
                              children: [
                                Icon(Icons.person),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 170,
                                  child: ResponsiveGridRow(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: author.map((author) {
                                      return ResponsiveGridCol(
                                          xl: 12,
                                          md: 12,
                                          xs: 12,
                                          child: Container(
                                            child: Text(
                                              author,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ));
                                    }).toList(),
                                  ),
                                ),
                                Icon(Icons.date_range),
                                Text(publishedDate)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Text(
                                introduction,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //this is the description of the case. the main text
                            //this is the description of the case. the main text
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              width: 600,
                              child: Column(
                                children: text.map((item) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item,
                                      style: TextStyle(fontSize: 20),
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
