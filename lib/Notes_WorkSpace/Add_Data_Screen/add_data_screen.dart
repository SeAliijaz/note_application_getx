import "package:flutter/material.dart";
import "package:notes_app/Constants/constants.dart";
import "package:notes_app/Firebase_Operations/firebase_services.dart";

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

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Make Your Notes",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () async {
                await saveForm();
              },
              icon: const Icon(Icons.check),
            ),
          ),
        ],
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
                            Icons.details,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
