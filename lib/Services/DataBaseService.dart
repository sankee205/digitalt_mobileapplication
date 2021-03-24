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

  Future updateCaseData(
      String image,
      String title,
      List<String> author,
      String publishedDate,
      String introduction,
      String text) async {
    return await FirebaseFirestore.instance.collection('AllCases').doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'text': text,
    });
  }
  Future updateCaseByFolder(String folder,
      String image,
      String title,
      List<String> author,
      String publishedDate,
      String introduction,
      String text) async {
    return await FirebaseFirestore.instance.collection(folder).doc(uid).set({
      'image': image,
      'title': title,
      'author': author,
      'publishedDate': publishedDate,
      'introduction': introduction,
      'text': text,
    });
  }

  Future getCaseItems(String folder) async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance.collection(folder).get().then((querySnapshot) {
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



  Future<String> downloadUrl(String fileName) async{
    return FirebaseStorage.instance.ref('images').child(fileName).getDownloadURL();
  }

}
