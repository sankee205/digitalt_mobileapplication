import 'package:digitalt_application/AppManagement/ThemeManager.dart';
import 'package:digitalt_application/Pages/SingleCasePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseSearch extends SearchDelegate {
  final List<String> allCases;
  final List allCaseList;
  BaseSearch({this.allCases, this.allCaseList});

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.red,
        iconTheme: colorScheme.brightness == Brightness.dark
            ? theme.primaryIconTheme.copyWith(color: Colors.red)
            : theme.primaryIconTheme.copyWith(color: Colors.white),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      Center(
          child: Text(
        'Tøm',
        style: TextStyle(
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.red
                : Colors.white,
            fontSize: 17),
      )),
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    if (selectedResult != null) {
      var caseObject;
      for (int i = 0; i < allCaseList.length; i++) {
        var caseVar = allCaseList[i];
        if (caseVar['title'] == selectedResult) {
          caseObject = caseVar;
        }
      }
      if (caseObject != null) {
        return CasePage(
          image: caseObject['image'],
          title: caseObject['title'],
          author: caseObject['author'],
          publishedDate: caseObject['publishedDate'],
          introduction: caseObject['introduction'],
          text: caseObject['text'],
          lastEdited: caseObject['lastEdited'],
          searchBar: true,
        );
      }
    }
    return (Container(
      child: Center(
        child: Text('Du må velge en artikkel'),
      ),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = allCases
        : suggestionList
            .addAll(allCases.where((element) => element.contains(query)));
    return Consumer<ThemeNotifier>(
        builder: (context, theme, child) => Center(
              child: Container(
                  width: 800,
                  child: Material(
                    child: Center(
                      child: ListView.builder(
                        itemCount: suggestionList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(suggestionList[index]),
                            onTap: () {
                              selectedResult = suggestionList[index];
                              query = suggestionList[index];
                              showResults(context);
                            },
                          );
                        },
                      ),
                    ),
                  )),
            ));
  }
}
