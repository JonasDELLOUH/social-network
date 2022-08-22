import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/my_textField.dart';
import '../util/constants.dart';
import '../util/firebase_handler.dart';
import 'Member.dart';

class AlertHelper {

  TextButton close(BuildContext context, String string) {
    return TextButton(
        onPressed: (() => Navigator.pop(context)),
        child: Text(string)
    );
  }

  Future<void> disconnect(BuildContext context) async {
    bool isiOS = (Theme.of(context).platform == TargetPlatform.iOS);
    Text title = const Text("Voulez vous vous déconnecter?");
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return (isiOS)
              ? CupertinoAlertDialog(title: title,actions: [close(context, "NON"), disconnectBtn(context)])
              : AlertDialog(title: title, actions: [close(context, "NON"), disconnectBtn(context)],);
        });
  }

  TextButton disconnectBtn(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
          FirebaseHandler().logOut();
        },
        child: Text("OUI"));
  }

  Future<void> error(BuildContext context, String error) async {
    bool isiOS = (Theme.of(context).platform == TargetPlatform.iOS);
    final title = Text("Erreur");
    final explanation = Text(error);
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (isiOS)
              ? CupertinoAlertDialog(title: title, content: explanation, actions: [close(ctx, "OK")],)
              : AlertDialog(title: title, content: explanation, actions: [close(ctx, "OK")],);
        }
    );
  }

  Future<void> changeUser(
      BuildContext context, {
        required Member member,
        required TextEditingController name,
        required TextEditingController surname,
        required TextEditingController desc
      }
      ) async {
    MyTextField nameTF = MyTextField(controller: name, hint: member.name,);
    MyTextField surnameTF = MyTextField(controller: surname, hint: member.surname,);
    MyTextField descTF = MyTextField(controller: desc, hint: member.description ?? "Aucune description",);
    Text text = Text("Modification des données");
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title:  text,
            content: Column(
              children: [nameTF, surnameTF, descTF],
            ),
            actions: [
              close(context, "Annuler"),
              TextButton(
                child: Text("Valider"),
                onPressed: () {
                  Map<String, dynamic> datas = {};
                  if (name.text != null && name.text != "") {
                    datas[nameKey] = name.text;
                  }
                  if (surname.text != null && surname.text != "") {
                    datas[surnameKey] = surname.text;
                  }
                  if (desc.text != null && desc.text != "") {
                    datas[descriptionKey] = desc.text;
                  }
                  FirebaseHandler().modifyMember(datas, member.uid);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}