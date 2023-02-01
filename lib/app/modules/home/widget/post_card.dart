// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:intagram_clone/app/data/constants.dart';
import 'package:intagram_clone/app/modules/home/controllers/user_controller_provider.dart';
import 'package:intagram_clone/app/modules/home/model/post_model.dart';
import 'package:intagram_clone/app/modules/home/model/user_model.dart';
import 'package:intagram_clone/app/modules/home/resources/firestore_methods.dart';
import 'package:intagram_clone/app/modules/home/services/image_picker.dart';
import 'package:intagram_clone/app/modules/home/views/comment/comment_screen.dart';
import 'package:intagram_clone/app/modules/home/widget/like_animation.dart';
import 'package:intagram_clone/app/responsive/dimensions.dart';

class PostCard extends StatefulWidget {
  final int index;
  final snap;
  const PostCard({
    Key? key,
    required this.index, this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    // fetchCommentLen();
  }

  Future<int> fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('post')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      return snap.docs.length;
    } catch (err) {
      ShowSnackBar(
        err.toString(),
        context,
      );
    }
    return 0;
  }

  deletePost(String postId) async {
    try {
      await FirestoreMethods().deletePost(postId);
    } catch (err) {
      ShowSnackBar(
        err.toString(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder<int?>(
        future: fetchCommentLen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          commentLen = snapshot.data ?? 0;

          return Container(
            key: Key(widget.snap['postId']),
            // boundary needed for web
            decoration: BoxDecoration(
              border: Border.all(
                color: width > webScreenSize
                    ? CustomColor.secondaryColor
                    : CustomColor.mobileBackgroundColor,
              ),
              color: CustomColor.mobileBackgroundColor,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Column(
              children: [
                // HEADER SECTION OF THE POST
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(right: 0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          widget.snap['profImage'].toString(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                key: Key("postcardusername"),
                                widget.snap['username'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.snap['uid'].toString() == user!.uid
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                  useRootNavigator: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      key: Key('deletePostDialog'),
                                      child: ListView(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shrinkWrap: true,
                                          children: [
                                            'Delete',
                                          ]
                                              .map(
                                                (e) => InkWell(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12,
                                                          horizontal: 16),
                                                      child: Text(e),
                                                    ),
                                                    onTap: () {
                                                      deletePost(
                                                        widget.snap['postId']
                                                            .toString(),
                                                      );
                                                      //remove the dialog box
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                              )
                                              .toList()),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_vert),
                            )
                          : Container(),
                    ],
                  ),
                ),
                // IMAGE SECTION OF THE POST
                GestureDetector(
                  key: Key('postcardimagelikeontap${widget.index.toString()}'),
                  onDoubleTap: () {
                    FirestoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user.uid,
                      widget.snap['likes'],
                    );
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: Image.network(
                          widget.snap['imageUrl'].toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          isAnimation: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // LIKE, COMMENT SECTION OF THE POST
                Row(
                  children: <Widget>[
                    LikeAnimation(
                      isAnimation: widget.snap['likes'].contains(user.uid),
                      smalllike: true,
                      child: IconButton(
                        key: Key('postcardlikebutton${widget.index.toString()}'),
                        icon: widget.snap['likes'].contains(user.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              ),
                        onPressed: () => FirestoreMethods().likePost(
                          widget.snap['postId'].toString(),
                          user.uid,
                          widget.snap['likes'],
                        ),
                      ),
                    ),
                    IconButton(
                      key: Key('postcardcommentbutton${widget.index.toString()}'),
                      icon: const Icon(
                        Icons.comment_outlined,
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            postId: widget.snap['postId'].toString(),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.send,
                        ),
                        onPressed: () {}),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {}),
                    ))
                  ],
                ),
                //DESCRIPTION AND NUMBER OF COMMENTS
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w800),
                          child: Text(
                            key: Key("postcardlikescount"),
                            '${widget.snap['likes'].length} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: CustomColor.primaryColor),
                            children: [
                              TextSpan(
                                text: widget.snap['username'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' ${widget.snap['description']}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          child: Text(
                            'View all $commentLen comments',
                            style: TextStyle(
                              fontSize: 16,
                              color: CustomColor.secondaryColor,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              postId: widget.snap['postId'].toString(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          'date',
                          style: TextStyle(
                            color: CustomColor.secondaryColor,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
