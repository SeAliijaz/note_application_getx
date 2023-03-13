import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Controllers/notes_controller.dart';
import 'package:notes_app/Screens/Home/CRUD/show_notes.dart';

class NoteList extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final NoteController noteController = Get.find<NoteController>();

  NoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StaggeredGridView.countBuilder(
        itemCount: noteController.notes.length,
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(authController.axisCount.value);
        },
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          var formattedDate = DateFormat.yMMMd()
              .format(noteController.notes[index].creationDate.toDate());
          Random random = Random();
          Color backgroundColor = lightColors[random.nextInt(8)];
          return GestureDetector(
            onTap: () {
              Get.to(() {
                return ShowNote(
                    index: index, noteData: noteController.notes[index]);
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                      top: 5,
                      right: 8,
                      left: 8,
                      bottom: 0,
                    ),
                    title: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        noteController.notes[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      noteController.notes[index].body,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Color> lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
    Colors.purpleAccent,
    Colors.greenAccent.shade400,
    Colors.cyanAccent,
    Colors.white70,
    Colors.grey[100],
    Colors.blueGrey[50],
    Colors.tealAccent[100],
    Colors.indigo[100],
    Colors.lightGreen[100],
    Colors.yellow[100],
    Colors.orange[100],
    Colors.red[100],
    Colors.pink[100],
    Colors.purple[100],
    Colors.deepPurple[100],
    Colors.blue[100],
    Colors.lightBlue[100],
    Colors.cyan[100],
    Colors.green[100],
    Colors.lime[100],
    Colors.amber[100],
    Colors.deepOrange[100],
    Colors.brown[100],
    Colors.grey[200],
    Colors.blueGrey[100],
    Colors.teal[100],
    Colors.indigoAccent[100],
    Colors.lightGreenAccent[100],
    Colors.yellowAccent[100],
    Colors.orangeAccent[100],
    Colors.redAccent[100],
    Colors.pinkAccent[100],
    Colors.purpleAccent[100],
    Colors.deepPurpleAccent.shade100,
    Colors.redAccent.shade100,
    Colors.limeAccent.shade100,
    Colors.teal.shade300,
    Colors.blueGrey[200],
    Colors.deepOrangeAccent.shade100,
    Colors.blue.shade300,
    Colors.cyanAccent.shade100,
    Colors.green[200],
    Colors.yellow[200],
  ];
}
