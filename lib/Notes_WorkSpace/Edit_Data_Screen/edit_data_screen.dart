import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:notes_app/Constants/constants.dart";
import "package:notes_app/Firebase_Operations/firebase_services.dart";
import 'package:notes_app/Widgets/custom_button.dart';

class EditDataScreen extends StatefulWidget {
  ///var
  String? title;
  String? details;
  String? id;

  ///Const
  EditDataScreen({
    Key? key,
    this.title,
    this.details,
    this.id,
  }) : super(key: key);

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  ///key
  final globalKey = GlobalKey<FormState>();

  ///Controllers
  TextEditingController titleC = TextEditingController();

  TextEditingController detailsC = TextEditingController();

  ///updateForm
  updateForm() async {
    if (globalKey.currentState!.validate()) {
      await FirebaseServices.updateNotes(
              widget.id!, titleC.text.trim(), detailsC.text.trim())
          .onError(
        (error, stackTrace) => showToastMsg(
          error.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Title ExpansionTile
                  Card(
                    child: ExpansionTile(
                      title: const Text("Title"),
                      children: [
                        myDivider,
                        TextFormField(
                          controller: titleC,
                          minLines: 1,
                          maxLines: 200,
                          // validator: (_) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.title,
                                color: Colors.black,
                              ),
                              hintText: "${widget.title}",
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              )),
                        ),
                        myDivider,
                      ],
                    ),
                  ),

                  ///Details ExpansionTile
                  Card(
                    child: ExpansionTile(
                      title: const Text('Details'),
                      children: [
                        myDivider,
                        TextFormField(
                          controller: detailsC,
                          minLines: 1,
                          maxLines: 200,
                          // validator: (_) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.description_sharp,
                                color: Colors.black,
                              ),
                              hintText: "${widget.details}",
                              hintStyle: const TextStyle(
                                color: Colors.black,
                              )),
                        ),
                        myDivider,
                      ],
                    ),
                  ),
                  CustomButton(
                    text: "Update Data",
                    textColor: Colors.white,
                    fontSize: 17,
                    buttonColor: Colors.blue,
                    onTap: () async {
                      await updateForm();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
