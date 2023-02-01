// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:intagram_clone/app/modules/home/resources/auth.dart';
// import 'package:mockito/mockito.dart';

// class MockUser extends Mock implements User {}

// final MockUser _mockUser = MockUser();

// class MockUserCredential extends Mock implements UserCredential {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User> authStateChanges() {
//     return Stream.fromIterable([
//       _mockUser,
//     ]);
//   }
// }

// void main() {
//   group('description', () {
//     final _mockAuth = MockFirebaseAuth();
//     late AuthMethods auth;

//     setUp(() {
//       auth = AuthMethods(auth: _mockAuth);
//     });

//     tearDown(() {});
//     const _email = 'ilyas@yopmail.com';
//     const _uid = 'sampleUid';
//     const _displayName = 'ilyas';
//     const _password = 'Test@123';
//     final _mockUser = MockUser();

//     test('signIn function test', () async {
//       final user = await auth.loginUser(
//           emailAddress: "tadas@gmail.com", password: "123456");
//       expect(user, _mockUser);
//     });
//   });
// }
