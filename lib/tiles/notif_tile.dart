import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../model/inside_notif.dart';
import '../model/post.dart';
import '../pages/detail_page.dart';
import '../pages/profile_page.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';

class NotifTile extends StatelessWidget {
  final InsideNotif notif;
  const NotifTile({Key? key, required this.notif}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(notif.userId);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseHandler().fire_user.doc(notif.userId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
          if (snap.hasData) {
            print(snap.data!.data());
            Member member = Member(snap.data!);
            return  InkWell(
                onTap: () {
                  FirebaseHandler().seenNotif(notif);
                  if (notif.type == follow) {
                    Navigator.push(context, MaterialPageRoute(builder: (build) {
                      return Scaffold(body: ProfilePage(member: member));
                    }));
                  } else {
                    notif.aboutRef.get().then((value) {
                      Post post = Post(value);
                      Navigator.push(context, MaterialPageRoute(builder: (build) {
                        return DetailPage(post: post, member: member);
                      }));
                    });
                  }
                },
                child: Container(
                  color: (notif.seen) ? ColorTheme().base(): ColorTheme().accent(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              ProfileImage(urlString: member.imageUrl, onPressed: () {

                              }),
                              Text("${member.surname} ${member.name}")
                            ],
                          ),
                          Text(notif.date)
                        ],
                      ),
                      Center(child: Text(notif.text),)
                    ],
                  ),
                )
            );
          } else {
            return const Center(child:  Text("Aucune données"));
          }
        });
  }
}
