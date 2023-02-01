import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intagram_clone/app/modules/home/controllers/user_controller_provider.dart';
import 'package:intagram_clone/app/modules/home/views/Auth/login_screen.dart';
import 'package:intagram_clone/app/modules/home/views/addPost/add_post_screen.dart';
import 'package:intagram_clone/app/modules/home/views/comment/comment_screen.dart';
import 'package:intagram_clone/app/modules/home/views/feed/feed_screen.dart';
import 'package:intagram_clone/app/modules/home/views/profile/profile.dart';
import 'package:intagram_clone/app/modules/home/views/search/search_screen.dart';
import 'package:intagram_clone/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  //  const MethodChannel channel =
  // MethodChannel('plugins.flutter.io/image_picker');

 

//   //'assets/load.png'
//   handler(MethodCall methodCall) async {
//   ByteData data = await rootBundle.load('assets/load.png');
//   Uint8List bytes = data.buffer.asUint8List();
//   Directory tempDir = await getTemporaryDirectory();
//   File file = await File(
//     '${tempDir.path}/tmp.tmp',
//   ).writeAsBytes(bytes);
//   return file.path;
// }
 // TestWidgetsFlutterBinding.ensureInitialized();



    // setUp((){
    // TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger
    // .setMockMethodCallHandler(channel,  handler);
    // });


  
  // login screen
  final logintextfeild = find.byKey(const Key('login_email_textfield'));
  final passwordtextfeild = find.byKey(const Key('password_text_field'));
  final loginbutton = find.byKey(const Key('login_button'));


  //bottomnavigation screen

  final homebutton = find.byKey(const Key('home_button'));
  final searchbutton = find.byKey(const Key('search_button'));
  final addpostbutton = find.byKey(const Key('add_post_button'));
  final notificationbutton = find.byKey(const Key('notification_button'));
  final profilebutton = find.byKey(const Key('profile_button'));
  final feedscreen = find.byType(FeedScreen);
  final searchScreen = find.byType(SearchScreen);
  final addPostScreen = find.byType(AddPostScreen);
  final profileScreen = find.byType(ProfileScreen);
  final commenyscreen = find.byType(CommentsScreen);

  //feed screen
  final feedstreambuilder = find.byKey(const Key('feedScreenStreamBuilder'));
  final feedlistview = find.byKey(const Key('feedScreenListViewBuilder'));
  final feedscreenpostcard = find.byKey(const Key('feedScreenPostCard0'));
  final feedpostcardtapbutton= find.byKey(const Key('postcardimagelikeontap0'));
  final commentbutton = find.byKey(const Key('postcardcommentbutton0'));

  //commentscreen
  final commenttextfeild = find.byKey(const Key('commentTextField'));
  final commentpostbutton = find.byKey(const Key('postCommentButton'));
  final commentprofileavatar = find.byKey(const Key('profilePicavatar'));
  final commentlistviewbuilder = find.byKey(const Key('commentScreenListViewBuilder'));

  //profilescreen
  final signoutbutton = find.byKey(const Key('signoutbutton'),);
  final profilegrid = find.byKey(const Key('profilegrid'));
  final profileavatar = find.byKey(const Key('profilecircleavatar'));
  //search screen
  final searchtextfeild = find.byKey(const Key('searchtextfeild'));
  final futurebuildergrid =  find.byKey(const Key('searchfuturebuildergrid'));
  final searchstraggedgridview = find.byKey(const Key('searchstaggeredgridview'));

  //addpost screen
  final addpostdialogue = find.byKey(const Key('photodialogue'));
  final addpostdialoguecamera = find.byKey(const Key('selecttakeaphoto'));
  final addpostdialoguegallery = find.byKey(const Key('choosefromgallery'));
  final addpostdialoguecancel = find.byKey(const Key('cancel'));
  final addposticonbutton = find.byKey(const Key('addposticonbutton'));
  final descriptiontextfeild = find.byKey(const Key('descriptiontextfield'));
  final postbutton = find.byKey(const Key('postbutton'));
  final progressbar = find.byKey(const Key('linearindicator'));


// check for login screen
 Future<bool> isPresent (
  Finder bykey,
  WidgetTester tester,
  ) async {
  try {
    await tester.pump(Duration(seconds: 1));
    expect(bykey, findsOneWidget);
    await tester.pumpAndSettle();
    return true;
  } catch (e) {
    return false;
  }
 }

//login function
 Future<void> loginfunction (WidgetTester tester) async {
  await tester.enterText(logintextfeild, 'zeepalm@gmail.com');
    await tester.enterText(passwordtextfeild, '123456');
    await tester.pumpAndSettle();
    await tester.tap(loginbutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 5));
 
 }

  testWidgets("test", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp()));
    await tester.pumpAndSettle();

    // expect(find.byType(MaterialApp), findsOneWidget);
    if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }
    expect(feedscreen, findsOneWidget);

    expect(feedstreambuilder, findsOneWidget);
    expect(feedlistview, findsOneWidget);
    expect(feedscreenpostcard, findsOneWidget);
    expect(feedpostcardtapbutton, findsOneWidget);

    await tester.tap(feedpostcardtapbutton);
    await tester.pump(Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(commentbutton);
     await tester.pump(Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(commenyscreen, findsOneWidget);
    expect(feedscreen, findsNothing);

    expect(commenttextfeild, findsOneWidget);
    expect(commentpostbutton, findsOneWidget);
    expect(commentprofileavatar, findsOneWidget);
    expect(commentlistviewbuilder, findsOneWidget);
    final comment = 'hey this is a comment';
     await tester.enterText(commenttextfeild, comment);
      await tester.pump(Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tester.tap(commentpostbutton);
    await tester.pumpAndSettle();  
     await tester.pump(Duration(seconds: 10));

    //expect(find.byType(MobileView), findsOneWidget);
    // expect(find.byType(LoginScreen), findsNothing);
  });
  
  


  testWidgets(" NAvigation bar test ", (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp(
    )));
    await tester.pumpAndSettle();

   if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }

    expect(feedscreen, findsOneWidget);
    expect(homebutton, findsOneWidget);
    expect(searchbutton, findsOneWidget);
    expect(addpostbutton, findsOneWidget);
    expect(notificationbutton, findsOneWidget);
    expect(profilebutton, findsOneWidget);

    await tester.tap(searchbutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(searchScreen, findsOneWidget);
    expect(feedscreen, findsNothing);

     await tester.tap(addpostbutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(addPostScreen, findsOneWidget);
    expect(searchScreen, findsNothing);

    await tester.tap(profilebutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(profileScreen, findsOneWidget);
    expect(addPostScreen, findsNothing);



    




  });

 testWidgets('profile screen', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp()));
    await tester.pumpAndSettle();

     if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }

    expect(feedscreen, findsOneWidget);
    
    await tester.tap(profilebutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(profileScreen, findsOneWidget);
    expect(feedscreen, findsNothing);

    expect(profilegrid, findsOneWidget);
    expect(profileavatar, findsOneWidget);
    expect(signoutbutton, findsOneWidget);
  await tester.pump(Duration(seconds: 5));
    await tester.tap(signoutbutton);
    




    

});

testWidgets('search screen', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp()));
    await tester.pumpAndSettle();

   if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }

    expect(feedscreen, findsOneWidget);
    
    await tester.tap(searchbutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(searchScreen, findsOneWidget);
    expect(feedscreen, findsNothing);

    expect(searchtextfeild, findsOneWidget);
    expect(futurebuildergrid, findsOneWidget);
    expect(searchstraggedgridview, findsOneWidget);

    await tester.enterText(searchtextfeild, 'zeepalm');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 4));
    find.text('zeepalm');
    await tester.pumpAndSettle();
    await tester.tapAt(Offset(200, 150));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 4));
    
    expect(profileScreen, findsOneWidget);
   expect(searchScreen ,findsNothing );

    
    
});

testWidgets('upload image  screen', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp()));
    await tester.pumpAndSettle();

   if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }

    expect(feedscreen, findsOneWidget);
    // select nav post button
    await tester.tap(addpostbutton);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 3));
    expect(addPostScreen, findsOneWidget);
    expect(feedscreen, findsNothing);

    expect(addposticonbutton, findsOneWidget);
    await tester.tap(addposticonbutton);
    await tester.pumpAndSettle();

    expect(addpostdialogue, findsOneWidget);
    expect(addpostdialoguecamera, findsOneWidget);
    expect(addpostdialoguegallery, findsOneWidget);
    expect(addpostdialoguecancel, findsOneWidget);

    await tester.tap(addpostdialoguegallery);
    await tester.pumpAndSettle();  
    await tester.pump(Duration(seconds: 5));
    expect(addpostdialogue, findsNothing);

    expect(addpostdialogue, findsNothing);
    expect(descriptiontextfeild, findsOneWidget);
    expect(postbutton, findsOneWidget);
    await tester.pump(Duration(seconds: 3));
    await tester.enterText(descriptiontextfeild, 'Good');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(Duration(seconds: 4));
    await tester.pumpAndSettle();
    await tester.tap(postbutton);
     await tester.pump(Duration(seconds: 2));
    expect(progressbar, findsOneWidget);
    await tester.pumpAndSettle();
    expect(addposticonbutton, findsOneWidget);    
});

testWidgets('scrollable test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ], child: MyApp()));
    await tester.pumpAndSettle();

     if(await isPresent(find.byType(LoginScreen), tester)){
   await loginfunction(tester);
    }
    expect(feedscreen, findsOneWidget);
    await tester.pump(Duration(seconds: 3));
    await tester.drag(find.byType(FeedScreen), Offset(0, -300));
    // select nav post button
   final listFinder = find.byType(Scrollable).first;
    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      feedscreenpostcard,
      50,
      scrollable: listFinder,
    );

    // Verify that the item contains the correct text.
    expect(feedscreenpostcard, findsOneWidget);
});
}
