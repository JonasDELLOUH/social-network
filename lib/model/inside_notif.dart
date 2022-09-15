import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/constants.dart';
import '../util/date_handler.dart';

class InsideNotif {
  late DocumentReference reference;
  late String text;
  late String date;
  late String userId;
  late DocumentReference<Map<String, dynamic>> aboutRef;
  late bool seen;
  late String type;

  InsideNotif(DocumentSnapshot<Map<String, dynamic>> snap) {
    reference = snap.reference;
    Map<String, dynamic>? map = snap.data();
    text = map?[textKey];
    date = DateHandler().myDate(map?[dateKey]);
    userId = map?[uidKey];
    aboutRef = map?[refKey];
    seen = map?[seenKey];
    type = map?[typeKey];
  }
}