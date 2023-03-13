import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Screens/Settings/Account-Profile/account.dart';
import 'package:notes_app/Screens/Settings/Theme/dark_mode.dart';
import 'package:notes_app/Screens/Settings/Widgets/list_tile.dart';
import 'package:notes_app/Screens/Widgets/custom_icon_button.dart';

class Setting extends StatelessWidget {
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
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                      color: Theme.of(context).colorScheme.background,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTileSetting(
                onTap: () {
                  Get.to(() => Account());
                },
                title: "Account",
                iconData: Icons.person_outline,
                subtitle: null,
              ),
              ListTileSetting(
                onTap: () {
                  Get.to(() => DarkMode());
                },
                title: "Dark Mode",
                iconData: Icons.nights_stay_outlined,
                subtitle: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
