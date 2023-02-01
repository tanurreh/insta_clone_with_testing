import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intagram_clone/app/data/assets_path.dart';
import 'package:intagram_clone/app/data/constants.dart';
import 'package:intagram_clone/app/modules/home/model/post_model.dart';
import 'package:intagram_clone/app/modules/home/widget/post_card.dart';
import 'package:intagram_clone/app/responsive/dimensions.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: width > webScreenSize
            ? CustomColor.webBackgroundColor
            : CustomColor.mobileBackgroundColor,
        appBar: width > webScreenSize
            ? null
            : AppBar(
                key: Key('feedScreenAppBar'),
                backgroundColor: CustomColor.mobileBackgroundColor,
                centerTitle: false,
                title: SvgPicture.asset(
                  CustomAssets.instagram,
                  color: CustomColor.primaryColor,
                  height: 32,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.messenger_outline,
                      color: CustomColor.primaryColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
        body: StreamBuilder(
            key: Key('feedScreenStreamBuilder'),
            stream: FirebaseFirestore.instance.collection('post').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  key: Key('feedScreenListViewBuilder'),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width > webScreenSize ? width * 0.3 : 0,
                          vertical: width > webScreenSize ? 15 : 0,
                        ),
                        child: PostCard(
                          key: Key('feedScreenPostCard${index.toString()}'),
                          
                          snap: snapshot.data!.docs[index].data(), index: index,
                          //  snap:
                        ),
                      ));
            }));
  }
}
