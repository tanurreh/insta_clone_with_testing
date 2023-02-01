import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intagram_clone/app/modules/home/views/Auth/login_screen.dart';
import 'package:intagram_clone/app/modules/home/views/addPost/add_post_screen.dart';
import 'package:intagram_clone/app/modules/home/views/mobile_view.dart';
import 'package:intagram_clone/app/modules/home/views/web_view.dart';
import 'package:intagram_clone/app/responsive/responsive.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ResponsiveLayout(
                mobileScreenLayout: MobileView(),
                webScreenLayout: WebView(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
          }
           return LoginScreen();
        }));
  }
}
