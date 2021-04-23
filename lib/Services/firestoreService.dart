import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalt_application/models/user.dart';

/// this class creates and gets BaseUsers
/// from/to firebase firestore
class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  //creates a base user in the firestore
  Future createUser(BaseUser user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  // returns the Base User
  Future<BaseUser> getUser(String uid) async {
    try {
      dynamic userData = await _usersCollectionReference.doc(uid).get();
      BaseUser user = BaseUser.fromData(userData.data());
      return user;
    } catch (e) {
      return e.message;
    }
  }
}
