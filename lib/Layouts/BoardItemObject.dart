/// this is a board item object for the board list object
class BoardItemObject {
  String title;

  BoardItemObject({this.title}) {
    if (this.title == null) {
      this.title = "";
    }
  }
}
