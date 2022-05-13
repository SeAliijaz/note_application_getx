import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import 'package:notes_app/Firebase_Operations/firebase_services.dart';
import "package:notes_app/Notes_WorkSpace/Show_Data_Screen/show_data_home_screen.dart";
import 'package:notes_app/Widgets/custom_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///title of App
      title: "Notes App",

      ///Setting Default theme
      theme: ThemeData(
        /// light theme settings
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),

      ///For DarkTheme
      darkTheme: ThemeData(
        /// dark theme settings
        brightness: Brightness.dark,
      ),
      /*
       * ThemeMode.system to follow system theme,
       * ThemeMode.light for light theme, 
       * ThemeMode.dark for dark theme
       */
      themeMode: ThemeMode.system,

      ///DebugShowCheckedModeBanner
      debugShowCheckedModeBanner: false,

      ///Home Default Screen to start initially
      ///The widget for the default route of the app ([Navigator.defaultRouteName]),
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("Notes").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              return const ShowDataScreen();
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return CustomProgressIndicator(
                textMessage: "Waiting for Connection...",
              );
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.none) {
              return CustomProgressIndicator(
                textMessage: "No Connection...",
              );
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.none &&
                snapshot.connectionState == ConnectionState.waiting) {
              return CustomProgressIndicator(
                textMessage: "Waiting For Response",
              );
            } else {
              return CustomProgressIndicator(
                textMessage: "Loading...",
              );
            }
          },
        ),
      ),
    );
  }
}
