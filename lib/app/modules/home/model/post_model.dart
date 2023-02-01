import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String uid;
  final String description;
  final String imageUrl;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List<String> likes;

  Post({
    required this.datePublished,
    required this.profImage,
    required this.likes,
    required this.username,
    required this.uid,
    required this.description,
    required this.imageUrl,
    required this.postId,
    required this.postUrl,
  });


  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'username': username});
    result.addAll({'uid': uid});
    result.addAll({'description': description});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'postId': postId});
    result.addAll({'datePublished': datePublished.millisecondsSinceEpoch});
    result.addAll({'postUrl': postUrl});
    result.addAll({'profImage': profImage});
    result.addAll({'likes': likes});
  
    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      postId: map['postId'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      postUrl: map['postUrl'] ?? '',
      profImage: map['profImage'] ?? '',
      likes: List<String>.from(map['likes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
