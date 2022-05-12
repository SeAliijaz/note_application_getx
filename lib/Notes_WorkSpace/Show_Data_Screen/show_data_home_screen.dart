import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:notes_app/Constants/constants.dart";
import "package:notes_app/Firebase_Operations/firebase_services.dart";
import "package:notes_app/Notes_WorkSpace/Edit_Data_Screen/edit_data_screen.dart";
import "package:notes_app/Widgets/connection_state.dart";

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("Notes").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ConnectionStatusWidget(
              text: "Waiting for Connection",
            );
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return ConnectionStatusWidget(
              text: "No Connection",
            );
          }
          if (!snapshot.hasData) {
            return ConnectionStatusWidget(
              text: "No Data yet!",
            );
          }

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                final v = snapshot.data!.docs[i];
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background: const Icon(Icons.delete),
                  key: UniqueKey(),
                  onDismissed: (_) {
                    FirebaseServices.deleteNotes(v.id).whenComplete(
                      () => showToastMsg("Notes Deleted Successfully!"),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    child: ExpansionTile(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditDataScreen(
                                          id: v.id,
                                          title: v["title"],
                                          details: v["details"],
                                        )));
                          },
                          icon: const Icon(Icons.edit)),
                      title: Text(
                        "${v["title"]}".toUpperCase(),
                        style: GoogleFonts.salsa(),
                      ),
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SelectableText(
                              "Details",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.salsa(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SelectableText(
                            "${v["details"]}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.salsa(
                              textStyle: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return ConnectionStatusWidget(
              text: "Loading...",
            );
          }
        },
      ),
    );
  }
}
