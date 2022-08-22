import 'package:flutter/material.dart';
import 'package:flutter_social2/model/Member.dart';
class NotifPage extends StatefulWidget {
  final Member member;
  const NotifPage({Key? key, required this.member}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Notif Page"),));
  }
}
