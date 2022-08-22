import 'package:flutter/material.dart';
import '../custom_widgets/padding_with.dart';
import '../custom_widgets/post_content.dart';
import '../model/Member.dart';
import '../model/alert_helper.dart';
import '../model/color_theme.dart';
import '../model/post.dart';
import '../pages/detail_page.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';

class PostTile extends StatelessWidget {

  Post post;
  Member member;
  bool isDetail = false;

  PostTile({Key? key, required this.post, required this.member, this.isDetail: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (!isDetail) {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
              return DetailPage(post: post, member: member);
            }));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Card(
            color: ColorTheme().base(),
            shadowColor: ColorTheme().pointer(),
            elevation: 5,
            child: PaddingWith(
              child: Column(
                children: [
                  PostContent(post: post, member: member),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: (post.likes.contains(FirebaseHandler().authInstance.currentUser!.uid) ? likeIcon : unlikeIcon),
                          onPressed: () {
                            FirebaseHandler().addOrRemoveLike(post, FirebaseHandler().authInstance.currentUser!.uid);
                          }),
                      Text("${post.likes.length} likes"),
                      IconButton(icon: commentIcon, onPressed: () {
                        AlertHelper().writeAComment(context, post: post, commentController: TextEditingController(), member: member);
                      }),
                      Text("${post.comments.length} commentaires")

                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}