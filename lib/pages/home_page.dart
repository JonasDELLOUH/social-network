import 'package:flutter/material.dart';

import '../model/Member.dart';
class HomePage extends StatefulWidget {
  final Member member;
  const HomePage({Key? key, required this.member}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Home Page"),));
  }
}
