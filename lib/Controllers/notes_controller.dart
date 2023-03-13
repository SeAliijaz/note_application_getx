import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Services/database_services.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Models/notes_model.dart';

class NoteController extends GetxController {
  RxList<NoteModel> noteList = RxList<NoteModel>();
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> bodyController = TextEditingController().obs;

  // ignore: invalid_use_of_protected_member
  List<NoteModel> get notes => noteList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user?.uid;
    print("NoteController onit :: $uid");
    noteList.bindStream(
        DatabaseServices().noteStream(uid)); //stream coming from firebase
    super.onInit();
  }
}
