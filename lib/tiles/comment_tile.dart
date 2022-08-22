import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/member_comment.dart';
import '../util/firebase_handler.dart';

class CommentTile extends StatelessWidget {
  MemberComment memberComment;

  CommentTile({Key? key, required this.memberComment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseHandler().fire_user.doc(memberComment.memberId).snapshots(),
        builder: (context, snap) {
      if (snap.hasData) {
        Member member = Member(snap.data!);
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ProfileImage(urlString: member.imageUrl, onPressed: () {

                    }),
                    Text("${member.surname} ${member.name}")
                  ],
                ),
                Text(memberComment.date, style: TextStyle(color: ColorTheme().pointer(), fontStyle: FontStyle.italic),)
              ],
            ),
            Center(child: Text(memberComment.text),)
          ],
        );
      } else {
        return const SizedBox(height: 0, width: 0);
      }
    });
  }


}