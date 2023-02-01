import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intagram_clone/app/data/theme.dart';
import 'package:intagram_clone/app/modules/home/controllers/user_controller_provider.dart';
import 'package:intagram_clone/app/modules/home/views/Auth/auth_wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: 'AIzaSyCRkoJkd3-MJ19YpK2jZ3IvhX6-MJGSMwU',
      appId: '1:381493914059:web:d9a85069aae47c68342e4e',
      messagingSenderId: '381493914059',
      projectId: 'instaclone-33ba5',
      storageBucket: 'instaclone-33ba5.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => UserProvider(),
            ),
          ],
          child: MyApp(),
        );
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryTheme,
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      // home: ResponsiveLayout(
      //   mobileScreenLayout: MobileView(),
      //   webScreenLayout: WebView(),
      // )
      // ,
      home: AuthWrapper(),
    );
  }
}
