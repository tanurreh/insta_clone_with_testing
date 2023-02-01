
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intagram_clone/app/modules/home/views/addPost/add_post_screen.dart';
import 'package:intagram_clone/app/modules/home/views/feed/feed_screen.dart';
import 'package:intagram_clone/app/modules/home/views/profile/profile.dart';
import 'package:intagram_clone/app/modules/home/views/search/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
