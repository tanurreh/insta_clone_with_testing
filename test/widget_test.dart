// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intagram_clone/app/modules/home/resources/auth.dart';
// import 'package:mockito/mockito.dart';

// class MockUser extends Mock implements User {}

// class MockUserCredential extends Mock implements UserCredential {}

// class MockFirebaseFireStore extends Mock implements FirebaseFirestore {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//    @override
//   Future<UserCredential> signInWithEmailAndPassword({
//     required String? email,
//     required String? password,
//   }) =>
//       super.noSuchMethod(
//           Invocation.method(#signInWithEmailAndPassword, [email, password]),
//           returnValue: Future.value(MockUserCredential()));
  
//   @override
//   Stream<User?> authStateChanges() {
//     return Stream.fromIterable([
//       MockUser(),
//     ]);
//   }

//   @override
//   Future<UserCredential> createUserWithEmailAndPassword({
//     required String? email,
//     required String? password,
//   }) =>
//       super.noSuchMethod(
//           Invocation.method(#createUserWithEmailAndPassword, [email, password]),
//           returnValue: Future.value(MockUserCredential()));
// }

// //mockFirebaseAuth
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//    late MockFirebaseAuth mockAuth;
//   late MockFirebaseFireStore mockFirestore;
//   late MockUserCredential mockCredential;
//   late MockUser mockUser;
//   late AuthMethods auth;
  
//   //final AuthMethods auth = AuthMethods(auth: mockFirebaseAuth, firestore: mockFirebaseFireStore);
//   setUp(() {
//     mockAuth = MockFirebaseAuth();
//     mockFirestore =MockFirebaseFireStore();
//     mockCredential = MockUserCredential();
//     mockUser = MockUser();
//     auth =
//         AuthMethods(auth: mockAuth, firestore: mockFirestore);
//     when(mockCredential.user).thenReturn(mockUser); // IMPORTANT
//   });
  
  

//   test("sign in", () async {
    
//   when(mockAuth.signInWithEmailAndPassword(email: "zeepalm@gmail.com", password: '123456'))
//           .thenAnswer((_) async => mockCredential);
  
//     String user = await  auth.loginUser(emailAddress: "zeepalm@gmail.com", password: "123456");
//     print(user.toString());
//    expect( user, "success");
//      verify(mockAuth.signInWithEmailAndPassword(
//           email: "zeepalm@gmail.com", password: '123456'));
//   });

//   test("sign up", () async {
//     final ByteData bytes = await rootBundle.load('assets/load.png');
//  final Uint8List list = bytes.buffer.asUint8List();
//     when(mockAuth.createUserWithEmailAndPassword(email: "zeepalm@gmail.com", password: '123456'))
//           .thenAnswer((_) async => mockCredential);
//   String user = await auth.signUpUser(emailAddress: "zeepalm@gmail.com", password: "123456", bio: 'zeepalm', file: list, username: 'tanu');
//   print(user.toString());
//    expect( user, "success");
//      verify(mockAuth.createUserWithEmailAndPassword(
//           email: "zeepalm@gmail.com", password: '123456'));
//   });
// }
