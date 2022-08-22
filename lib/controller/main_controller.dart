import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social2/controller/loading_controller.dart';
import 'package:flutter_social2/custom_widgets/bar_item.dart';
import 'package:flutter_social2/model/color_theme.dart';
import 'package:flutter_social2/util/firebase_handler.dart';

import '../model/Member.dart';
import '../pages/home_page.dart';
import '../pages/members_page.dart';
import '../pages/notif_page.dart';
import '../pages/profile_page.dart';
import '../pages/write_poste.dart';
import '../util/constants.dart';

class MainController extends StatefulWidget {
  final String memberUid;

  const MainController({Key? key, required this.memberUid}) : super(key: key);

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late StreamSubscription streamSubscription;
  Member? member;
  int index = 0;

  @override
  void initState() {
    streamSubscription = FirebaseHandler()
        .fire_user
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        member = Member(event);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${member?.name}");
    return (member == null)
        ? LoadingController()
        : Scaffold(
            key: _globalKey,
            body: showPage(),
            bottomNavigationBar: BottomAppBar(
              color: ColorTheme().accent(),
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BarItem(
                      icon: homeIcon,
                      onPressed: (() => buttonSelected(0)),
                      selected: (index == 0)),
                  BarItem(
                      icon: friendsIcon,
                      onPressed: (() => buttonSelected(1)),
                      selected: (index == 1)),
                  const SizedBox(
                    width: 0,
                    height: 0,
                  ),
                  BarItem(
                      icon: notifIcon,
                      onPressed: (() => buttonSelected(2)),
                      selected: (index == 2)),
                  BarItem(
                      icon: profileIcon,
                      onPressed: (() => buttonSelected(3)),
                      selected: (index == 3))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _globalKey.currentState!.showBottomSheet((context) => WritePost(memberId: widget.memberUid,));
              },
              child: writePost,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  Widget? showPage() {
    switch (index) {
      case 0:
        return HomePage(member: member!);
      case 1:
        return MembersPage(member: member!);
      case 2:
        return NotifPage(member: member!);
      case 3:
        return ProfilePage(member: member!);
    }
  }
}
