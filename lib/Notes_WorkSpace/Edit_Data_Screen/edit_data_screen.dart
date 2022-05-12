import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:notes_app/Constants/constants.dart";
import "package:notes_app/Firebase_Operations/firebase_services.dart";

class EditDataScreen extends StatelessWidget {
  ///key
  final globalKey = GlobalKey<FormState>();

  ///Controllers
  TextEditingController titleC = TextEditingController();
  TextEditingController detailsC = TextEditingController();

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

  ///updateForm
  updateForm() async {
    if (globalKey.currentState!.validate()) {
      await FirebaseServices.updateNotes(
              id!, titleC.text.trim(), detailsC.text.trim())
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
        actions: [
          IconButton(
            onPressed: () async {
              await updateForm();
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.photo),
            label: "Add Image",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: "Voice Notes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Save Notes",
          ),
        ],
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black38,
                    height: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: titleC,
                      minLines: 1,
                      maxLines: 200,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field Should not be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.title,
                          color: Colors.black,
                        ),
                        hintText: "$title",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                    height: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: detailsC,
                      minLines: 1,
                      maxLines: 200,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field Should not be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.details,
                            color: Colors.black,
                          ),
                          hintText: "$details",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                    height: 0.5,
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
