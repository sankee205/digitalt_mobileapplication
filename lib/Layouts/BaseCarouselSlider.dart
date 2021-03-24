import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:flutter/material.dart';

import 'BaseCaseBox.dart';

/**
 * this is the carouselslider. is will show the top X cases in the home page
 */
class BaseCarouselSlider extends StatefulWidget {
  //list of cass it gets from the database
  final List caseList;

  const BaseCarouselSlider(this.caseList);

  @override
  _BaseCarouselSliderState createState() => _BaseCarouselSliderState();
}

class _BaseCarouselSliderState extends State<BaseCarouselSlider> {
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
      items: widget.caseList.map((caseObject) {
        return Builder(builder: (
          BuildContext context,
        ) {
          //makes the onclick available
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CasePage(
                            image:
                            caseObject['image'],
                            title:
                            caseObject['title'],
                            author: caseObject[
                            'author'],
                            publishedDate:
                            caseObject[
                            'publishedDate'],
                            introduction:
                            caseObject[
                            'introduction'],
                            text: caseObject[
                            'text']
                            )));
              },
              child: BaseCaseBox(image: caseObject['image'],title: caseObject['title']));
        });
      }).toList(),
    );
  }
}
