import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/Constants/constants.dart';

///Globall
FirebaseFirestore firestore = FirebaseFirestore.instance;

///Class Firebase Operations
class FirebaseServices {
  static Future<void> addNotesData(String title, String details) async {
    firestore.collection("Notes").add({
      "title": title,
      "details": details,
    }).whenComplete(() => showToastMsg("Added Successfully!"));
  }

  static Future<void> deleteNotes(String id) async {
    await firestore.collection("Notes").doc(id).delete();
  }

  static Future<void> updateNotes(
    String id,
    String title,
    String details,
  ) async {
    await firestore.collection("Notes").doc(id).update({
      "title": title,
      "details": details,
    }).whenComplete(() => showToastMsg("Updated Successfully!"));
  }
}
