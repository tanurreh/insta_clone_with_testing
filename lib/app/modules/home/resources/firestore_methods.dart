import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intagram_clone/app/modules/home/model/post_model.dart';
import 'package:intagram_clone/app/modules/home/services/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //upload post
  Future<String> uploadPost(
    String uid,
    String description,
    Uint8List file,
    String username,
    String profImage,
  ) async {
    String res = 'Some thing is wrong';
    try {
      //Uploading Image to FireStore
      String imageUrl =
          await StorageMethods().uploadImageToStorage('Post', file, true);

      //Upload post
      String postId = const Uuid().v1();
      Post post = Post(
          datePublished: DateTime.now(),
          profImage: profImage,
          likes: [],
          username: username,
          uid: uid,
          description: description,
          imageUrl: imageUrl,
          postId: postId,
          postUrl: imageUrl);
      _firestore.collection('post').doc(postId).set(post.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
    // await _firestore.collection('post').doc()
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('post')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('post').doc(postId).delete();
    } catch (e) {
      print(e);
    }
  }
Future<void> followUser(
    String uid,
    String followId
  ) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }
}
