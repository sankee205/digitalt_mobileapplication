import 'BoardItemObject.dart';

/// this is a board list object for the Board view to display
/// the different list in the admin console
class BoardListObject {
  String title;
  List<BoardItemObject> items;

  BoardListObject({this.title, this.items}) {
    if (this.title == null) {
      this.title = "";
    }
    if (this.items == null) {
      this.items = [];
    }
  }
}
