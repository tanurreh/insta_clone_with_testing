import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intagram_clone/app/modules/home/model/user_model.dart';
import 'package:intagram_clone/app/modules/home/services/storage_method.dart';

class AuthMethods {
     FirebaseAuth? auth;
     FirebaseFirestore? firestore;

  AuthMethods({
   this.auth ,
   this.firestore});
  
   FirebaseAuth  get _auth => auth?? FirebaseAuth.instance;
   FirebaseFirestore get _firestore => firestore?? FirebaseFirestore.instance;
  //MockFirebaseAuth auth = MockFirebaseAuth();
  //final FirebaseAuth auth = FirebaseAuth.instance;
  //final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserData() async {
 

    User currentuser = _auth.currentUser!;
    return await _firestore.collection('users').doc(currentuser.uid).get().then(
        (value) => UserModel.fromMap(value.data() as Map<String, dynamic>));

    // return UserModel.fromMap(snap as Map<String, dynamic>);
  }

  Future<String> signUpUser({
    required String emailAddress,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (emailAddress.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: emailAddress, password: password);
        //Uploading Image to FireStore
      //   String imageUrl = await StorageMethods()
      //       .uploadImageToStorage('ProfilePic', file, false);
      //   // Adding data to firestore
      //   UserModel user = UserModel(
      //       username: username,
      //       uid: cred.user!.uid,
      //       bio: bio,
      //       emailAddress: emailAddress,
      //       followers: [],
      //       following: [],
      //       imageUrl: imageUrl);
      //  _firestore.collection('users').doc(cred.user!.uid).set(user.toMap());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    String res = 'Some error occured';

    try {
      if (emailAddress.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: emailAddress, password: password);
        res = "success";
      } else {
        res = 'Please Enter All the feilds';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
