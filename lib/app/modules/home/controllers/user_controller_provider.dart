import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intagram_clone/app/modules/home/model/user_model.dart';
import 'package:intagram_clone/app/modules/home/resources/auth.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await AuthMethods(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance).getUserData();
    _user = user;
    notifyListeners();
  }
}


// import 'package:flutter/widgets.dart';
// import 'package:instagram_clone_flutter/models/user.dart';
// import 'package:instagram_clone_flutter/resources/auth_methods.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final AuthMethods _authMethods = AuthMethods();

//   User get getUser => _user!;

//   Future<void> refreshUser() async {
//     User user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }