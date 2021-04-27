import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
///this is the base casebox class. its a layout for all the cases to be displayed in the homepage
///before entering the whole case
class BaseCaseBox extends StatefulWidget {
  //takes in the object caseITem and builds the box from image and title
  final String image;
  final String title;

  const BaseCaseBox({Key key, @required this.image, @required this.title})
      : super(key: key);

  @override
  _BaseCaseBoxState createState() => _BaseCaseBoxState();
}

class _BaseCaseBoxState extends State<BaseCaseBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => GridTile(
        footer: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(0), boxShadow: [
            BoxShadow(
                color: theme.getState() == false
                    ? Colors.grey.shade200
                    : Colors.grey.shade900,
                blurRadius: 0,
                spreadRadius: 1)
          ]),
          //here comes the Text of the CaseBox
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: Colors.black,
                  fontSize: 15),
            ),
          ),
        ),
        //this is the Image of the CaseBox
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
