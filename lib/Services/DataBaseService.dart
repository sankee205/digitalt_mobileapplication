import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users'); //What to collect

  Future updateUserData(String name, String email, String phonenumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future getInfoPageContent() async {
    List infoList = [];
    await FirebaseFirestore.instance
        .collection('InfoPageContent')
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                infoList.add(element);
              })
            });
    return infoList;
  }

  Future getCaseItems(String folder) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection(folder)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> downloadUrl(String fileName) async {
    return FirebaseStorage.instance
        .ref('images')
        .child(fileName)
        .getDownloadURL();
  }
}
