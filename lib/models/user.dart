import 'package:digitalt_application/models/subscription.dart';

///
///this is a base user for this project
class BaseUser {
  final String uid;
  final String fullName;
  final String email;
  final String phonenumber;
  final String userRole;
  final List myCases;
  final Subscription mySubscription;

  BaseUser({
    this.uid,
    this.fullName,
    this.email,
    this.phonenumber,
    this.userRole,
    this.myCases,
    this.mySubscription,
  });

  BaseUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['fullName'],
        email = data['email'],
        phonenumber = data['phonenumber'],
        userRole = data['userRole'],
        myCases = data['myCases'],
        mySubscription = Subscription.fromData(data['mySubscription']);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phonenumber': phonenumber,
      'userRole': userRole,
      'myCases': myCases,
      'mySubscription': mySubscription.toJson(),
    };
  }
}
