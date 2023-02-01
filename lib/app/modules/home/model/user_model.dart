import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String uid;
  String bio;
  String imageUrl;
  String emailAddress;
  List followers;
  List following;
  UserModel({
    required this.username,
    required this.uid,
    required this.bio,
    required this.imageUrl,
    required this.emailAddress,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'uid': uid});
    result.addAll({'bio': bio});
    result.addAll({'photoUrl': imageUrl});
    result.addAll({'emailAddress': emailAddress});
    result.addAll({'followers': followers});
    result.addAll({'following': following});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      bio: map['bio'] ?? '',
      imageUrl: map['photoUrl'] ?? '',
      emailAddress: map['emailAddress'] ?? '',
      followers: List.from(map['followers']),
      following: List.from(map['following']),
    );
  }

   String toJson(DocumentSnapshot<Object?> snap) => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
