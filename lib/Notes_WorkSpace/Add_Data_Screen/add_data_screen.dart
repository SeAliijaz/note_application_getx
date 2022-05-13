import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import "package:notes_app/Constants/constants.dart";
import "package:notes_app/Firebase_Operations/firebase_services.dart";
import 'package:notes_app/Widgets/custom_button.dart';

class AddDataScreen extends StatefulWidget {
  @override
  State<AddDataScreen> createState() {
    return _AddDataScreenState();
  }
}

class _AddDataScreenState extends State<AddDataScreen> {
  ///key
  final formKey = GlobalKey<FormState>();

  ///Controllers
  TextEditingController titleC = TextEditingController();
  TextEditingController detailsC = TextEditingController();
  var text = "";

  ///SaveForm
  saveForm() async {
    if (formKey.currentState!.validate()) {
      await FirebaseServices.addNotesData(
        titleC.text.trim(),
        detailsC.text.trim(),
      ).onError((error, stackTrace) {
        showToastMsg(error.toString());
      });
    }
  }

  ///Disposing
  @override
  void dispose() {
    titleC.clear();
    titleC.dispose();
    detailsC.clear();
    detailsC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Make Your Notes",
        ),
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: Form(
          key: formKey,
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
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: titleC,
                      minLines: 1,
                      maxLines: 200,
                      validator: (_) {
                        if (_!.isEmpty) {
                          return "Field Should not be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.title,
                            color: Colors.black,
                          ),
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                    height: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: detailsC,
                      minLines: 1,
                      maxLines: 200,
                      validator: (_) {
                        if (_!.isEmpty) {
                          return "Field Should not be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.description_sharp,
                            color: Colors.black,
                          ),
                          hintText: "Enter details",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                    height: 0.5,
                  ),
                  CustomButton(
                    text: "Add Data",
                    textColor: Colors.white,
                    fontSize: 17,
                    buttonColor: Colors.blue,
                    onTap: () async {
                      await saveForm();
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
