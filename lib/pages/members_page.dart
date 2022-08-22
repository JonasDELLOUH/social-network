import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social2/pages/profile_page.dart';

import '../custom_widgets/profile_image.dart';
import '../model/Member.dart';
import '../model/color_theme.dart';
import '../util/firebase_handler.dart';
import '../util/images.dart';
class MembersPage extends StatefulWidget {
  final Member member;
  const MembersPage({Key? key, required this.member}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    String myId = FirebaseHandler().authInstance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseHandler().fire_user.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool scrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 200,
                      backgroundColor: ColorTheme().pointer(),

                      flexibleSpace: FlexibleSpaceBar(
                        title: Text("Liste des utilisateurs"),
                        background: Image(image: AssetImage(eventsImage), fit: BoxFit.cover,),
                      ),
                    )
                  ];
                },
                body: ListView.separated(
                    itemBuilder: (BuildContext ctx, int index) {
                      final list = snapshot.data!.docs;
                      final memberMap = list[index];
                      final member = Member(memberMap);
                      return ListTile(
                        leading: ProfileImage(urlString: member.imageUrl, onPressed: (){

                        }),
                        title: Text("${member.surname} ${member.name}", style: TextStyle(color: ColorTheme().textColor()),),
                        trailing: TextButton(
                            onPressed: () {
                              FirebaseHandler().addOrRemoveFollow(member);
                            },
                            child: (myId == member.uid)
                                ? Container(width: 0,height: 0,)
                                : Text((member.followers.contains(myId) ? "Ne plus suivre" : "Suivre"))
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext ctx) {
                                return Scaffold( body:ProfilePage(member: member));
                              }));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext ctx, int index) {
                      return Divider();
                    },
                    itemCount: snapshot.data!.docs.length
                )
            );
          } else {
            return Center(child: Text("Aucun utilisateur sur cette app"),);
          }
        }
    );
  }
}
