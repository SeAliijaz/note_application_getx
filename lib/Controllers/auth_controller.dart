import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/Services/database_services.dart';
import 'package:notes_app/Controllers/user_controller.dart';
import 'package:notes_app/Models/user_model.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  Rx<int> axisCount = 2.obs;

  User get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser = Rx<User>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    super.onInit();
  }

  void createUser() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        UserModel _user = UserModel(
          id: value.user.uid,
          name: name.text,
          email: email.text,
        );
        DatabaseServices().createNewUser(_user).then((value) {
          if (value) {
            Get.find<UserController>().user = _user;
            Get.back();
            _clearControllers();
          }
        });
      });
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void loginUser() async {
    try {
      print("IN logging in email ${email.text} password ${password.text}");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      // .then((value) async {
      Get.find<UserController>().user =
          await DatabaseServices().getUser(userCredential.user.uid);
      _clearControllers();
    } catch (e) {
      Get.snackbar(
        'Error logging in',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signout() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().user = UserModel();
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }
}
