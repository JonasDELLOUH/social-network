import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Member.dart';
import '../model/member_comment.dart';
import '../model/post.dart';
import '../tiles/comment_tile.dart';
import '../tiles/post_tile.dart';
import '../util/constants.dart';

class DetailPage extends StatefulWidget {

  Post post;
  Member member;

  DetailPage({Key? key, required this.post, required this.member}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détail du post")),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: widget.post.ref.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snaps) {
          List<MemberComment> comments = [];
          final  Map<String, dynamic>? datas = snaps.data!.data();
          final   commentsSnap = datas?[commentKey];
          commentsSnap.forEach((s) {
            comments.add(MemberComment(s));
          });
          print(comments.length);
          return ListView.separated(

              itemBuilder: (context, index) {
                if (index == 0) {
                  return PostTile(post: widget.post, member: widget.member, isDetail: true,);
                } else {
                  MemberComment comment = comments[index - 1];
                  return CommentTile(memberComment: comment);
                }
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: comments.length + 1
          );
        },
      )
    );
  }
}