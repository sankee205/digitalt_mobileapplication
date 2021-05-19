import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:digitalt_application/Services/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

/*
 * this is the infopage. it consists of information about digi-talt.no and
 * contact inofrmation
 */
class InfoPage extends StatefulWidget {
  final List infoList;
  final List text;
  final List author;
  final String contactPhoto;
  final String date;
  final String email;
  final String textPhoto;
  final String tlf;
  final String backgroundPhoto;

  const InfoPage(
      {Key key,
      @required this.infoList,
      @required this.text,
      @required this.author,
      @required this.contactPhoto,
      @required this.date,
      @required this.email,
      @required this.textPhoto,
      @required this.backgroundPhoto,
      @required this.tlf});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        bottomSheet: TabBar(
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(
              child: Text('Om Digi-talt'),
            ),
            Tab(
              child: Text('Kontakt oss'),
            )
          ],
        ),
        bottomNavigationBar: BaseBottomAppBar(),
        //creates the menu in the appbar(drawer)
        drawer: BaseAppDrawer(),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.backgroundPhoto), fit: BoxFit.cover),
          ),
          child: TabBarView(
            children: [
              Container(
                  child: SingleChildScrollView(
                      child: Stack(children: [
                Center(
                  child: Container(
                    width: 800,
                    child: Material(
                      borderRadius: BorderRadius.circular(35),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.grey)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Om DIGI-TALT.NO',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //this is the title
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: Image(
                              image: NetworkImage(widget.textPhoto),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //in this row you find author and published date
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: Colors.grey),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 200,
                                  child: ResponsiveGridRow(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: widget.author.map((author) {
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
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.date_range),
                                Text(widget.date)
                              ],
                            ),
                          ),

                          //this is the description of the case. the main text
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: widget.text.map((item) {
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
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]))),
              Container(
                  child: SingleChildScrollView(
                      child: Stack(children: [
                Center(
                  child: Container(
                    width: 800,
                    child: Material(
                      borderRadius: BorderRadius.circular(35),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.grey)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Kontakt oss',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //this is the title
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: Image(
                              image: NetworkImage(widget.contactPhoto),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: Colors.grey),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text('Telefon: ' + widget.tlf)),
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text('Email: ' + widget.email)),
                              ],
                            ),
                          ),
                          //this is the description of the case. the main text
                        ],
                      ),
                    ),
                  ),
                )
              ]))),
            ],
          ),
        ),
      ),
    );
  }
}
