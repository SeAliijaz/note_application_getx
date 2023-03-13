import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Screens/Auth/login_screen.dart';
import 'package:notes_app/screens/home/home_screen.dart';

class Root extends StatelessWidget {
  Root({Key key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (authController != null && authController.user?.uid != null) {
          return HomePage();
        } else {
          return LogInScreen();
        }
      },
    );
  }
}
