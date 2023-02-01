// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';


// class MockFirestore extends Mock implements FirebaseFirestore {
// }

// class MockCollectionReference extends Mock implements CollectionReference {
//   @override
//   Future<DocumentReference> add(Map<String, dynamic> data) {
//     return super.noSuchMethod(
//       Invocation.method(#add, [data]),
//       returnValue: Future.value(MockDocumentReference()),
//     );
//   }
// }

// class MockDocumentReference extends Mock implements DocumentReference {}

// class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

// void main() {
//   late MockFirestore instance;
//   late MockDocumentSnapshot mockDocumentSnapshot;
//   late MockCollectionReference mockCollectionReference;
//   late MockDocumentReference mockDocumentReference;

//   setUp(() {
//     instance = MockFirestore();
//     mockCollectionReference = MockCollectionReference();
//     mockDocumentReference = MockDocumentReference();
//     mockDocumentSnapshot = MockDocumentSnapshot();
//   });

//   // //Get data from firestore doc
//   // test('should return data when the call to remote source is successful.', () async {
//   //   when(instance.collection(any)).thenReturn(mockCollectionReference);
//   //   when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
//   //   when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
//   //   when(mockDocumentSnapshot.data()).thenReturn(responseMap);
//   //   //act
//   //   final result = await remoteDataSource.getData('user_id');
//   //   //assert
//   //   expect(result, userModel); //userModel is a object that is defined. Replace with you own model class object.
//   // });

//   //Add data to firestore doc
//   //This demonstrates chained call like (instance.collection('path1').doc('doc1').collection('path2').doc('doc2').add(data));
//   //We return the same mocked objects for each call.
//   test('should get data from nested document.', () async {
//     // arrange
//     when(instance.collection(any)).thenReturn(mockCollectionReference);
//     when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
//     // when(mockDocumentReference.collection(any)).thenReturn(mockCollectionReference);
//     // when(mockCollectionReference.add(any)).thenAnswer((_) async => mockDocumentReference);
//     // when(mockDocumentReference.id).thenReturn(messageID);
//     // when(mockDocumentSnapshot.data()).thenReturn(messageData);
//     //act
  
//     //assert
//     //expect(result, notificationID);
//   });
// }