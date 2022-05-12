import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:notes_app/Notes_WorkSpace/Show_Data_Screen/show_data_home_screen.dart";

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

      ///Home
      ///The widget for the default route of the app ([Navigator.defaultRouteName]),
      home: const ShowDataScreen(),
    );
  }
}
