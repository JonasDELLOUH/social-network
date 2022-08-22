import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social2/custom_widgets/profile_image.dart';
import 'package:flutter_social2/util/date_handler.dart';

import '../custom_widgets/padding_with.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/post.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';

class PostTile extends StatelessWidget {

  final QueryDocumentSnapshot snapshot;
  final Member member;
  final Post post;

  const PostTile({Key? key, required this.snapshot, required this.member, required this.post,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Post post = Post(!snapshot);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        color: ColorTheme().base(),
        shadowColor: ColorTheme().pointer(),
        elevation: 5,
        child: PaddingWith(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileImage(urlString: member.imageUrl, onPressed: () {}),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${member.surname} ${member.name}"),
                      Text(DateHandler().myDate(post.date))
                    ],
                  )
                ],
              ),
              Divider(),
              (post.imageUrl != null && post.imageUrl != "") ? PaddingWith(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(post.imageUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  )
              ) : Container(height: 0, width: 0,),
              (post.text != null && post.text != "") ? Text(post.text) : Container(
                height: 0, width: 0,
              ),
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
                   // AlertHelper().writeAComment(context, post: post, commentController: TextEditingController(), member: member);
                  }),
                  Text("${post.comments.length} commentaires")

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}