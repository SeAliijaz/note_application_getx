import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Controllers/notes_controller.dart';
import 'package:notes_app/Screens/Home/CRUD/add_notes.dart';
import 'package:notes_app/Screens/Home/CRUD/notes_list.dart';
import 'package:notes_app/Screens/Settings/Theme/setting.dart';
import 'package:notes_app/Screens/Widgets/custom_icon_button.dart';

class HomePage extends GetWidget<AuthController> {
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Obx(() => Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          color: Theme.of(context).colorScheme.background,
                          onPressed: () {
                            authController.axisCount.value =
                                authController.axisCount.value == 2 ? 4 : 2;
                          },
                          icon: Icon(authController.axisCount.value == 2
                              ? Icons.list_outlined
                              : Icons.grid_on_outlined),
                        ),
                        Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomIconButton(
                          color: Theme.of(context).colorScheme.background,
                          onPressed: () {
                            Get.to(() => Setting());
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetX<NoteController>(
                      init: Get.put<NoteController>(NoteController()),
                      builder: (NoteController noteController) {
                        if (noteController != null &&
                            noteController.notes != null) {
                          return NoteList();
                        } else {
                          return Text(
                            "No Notes Found\nCreate Note Now",
                            textAlign: TextAlign.center,
                          );
                        }
                      }),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: "Add Note",
          onPressed: () {
            Get.to(() => AddNotePage());
          },
          child: Icon(
            Icons.note_add_outlined,
            size: 30,
          )),
    );
  }
}
