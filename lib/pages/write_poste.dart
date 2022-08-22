import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social2/custom_widgets/my_gradient.dart';
import 'package:flutter_social2/custom_widgets/my_textField.dart';
import 'package:flutter_social2/custom_widgets/padding_with.dart';
import 'package:flutter_social2/model/color_theme.dart';
import 'package:flutter_social2/util/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../util/firebase_handler.dart';

class WritePost extends StatefulWidget {
  final String memberId;
  const WritePost({Key? key, required this.memberId,}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  late TextEditingController _controller;
  File? _imageFile;

  @override
  void initState() {
    _controller = TextEditingController();
    print(_imageFile);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme().base(),
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: PaddingWith(
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            color: ColorTheme().accent(),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight:Radius.circular(25) )
          ),
          child: InkWell(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PaddingWith(
                      child: Text("Ecrivez quelque chose ...")
                  ),
                  PaddingWith(
                      child: MyTextField(
                        controller: _controller,
                        hint: "Exprimez vous",
                        icon: writePost,
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (() => takePicture(ImageSource.camera)), icon: cameraIcon),
                      IconButton(onPressed: (() => takePicture(ImageSource.gallery)), icon: libraryIcon)
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: (_imageFile == null) ? Text("Aucune Image") : Image.file(_imageFile!),
                  ),

                  Card(
                    elevation: 7.5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: MyGradient(
                        startColor: ColorTheme().base(),
                        endColor: ColorTheme().pointer(),
                        radius: 25,
                        horizontal: true
                      ),
                      child: TextButton(
                        child: Text("Envoyer"),
                        onPressed: (){
                          sendToFirebase();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  takePicture(ImageSource source) async {
    final imagePath = await ImagePicker().pickImage(source: source, maxHeight: 500, maxWidth: 500);
    final file = File(imagePath!.path);
    setState(() {
      _imageFile = file;
    });
  }

  sendToFirebase() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.pop(context);
    if ((_imageFile != null) || (_controller.text != null && _controller.text != "")) {
      FirebaseHandler().addPostToFirebase(widget.memberId, _controller.text, _imageFile);
    }
  }
}
