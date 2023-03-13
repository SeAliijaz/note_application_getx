import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Controllers/auth_controller.dart';
import 'package:notes_app/Controllers/user_controller.dart';
import 'package:notes_app/Screens/Widgets/custom_icon_button.dart';

class Account extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Account",
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
              Container(
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text("Hi, ${userController.user.name}"),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text(" ${userController.user.email}"),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                onTap: () {
                  showSignOutDialog(context);
                },
                title: Text("Logout"),
                leading: Icon(
                  Icons.power_settings_new_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSignOutDialog(BuildContext context) async {
  final AuthController authController = Get.find<AuthController>();
  print("in dialog ");
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        actionsPadding: EdgeInsets.only(right: 60),
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text(
          "Are you sure you want to log out?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Your notes are already saved so when logging back your noteswill be there.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Log Out",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              Get.back();
              authController.signout();
              Get.close(2);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
          ),
          TextButton(
            child: Text("Cancel",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
