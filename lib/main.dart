import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_social2/controller/auth_controller.dart';

import 'controller/main_controller.dart';
import 'model/color_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: ColorTheme().base(),
          textTheme: TextTheme(bodyText2: TextStyle(color: ColorTheme().textColor())),
          iconTheme: IconThemeData(color: ColorTheme().textColor())
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, snapshot) {
          return (snapshot.hasData) ?  MainController(memberUid: snapshot.data!.uid,) : const AuthController();
        },
      ),
    );
  }
}
