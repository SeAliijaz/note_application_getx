import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Making Global Toast
void showToastMsg(String msg) {
  Fluttertoast.showToast(msg: msg);
}

const myDivider = Divider(color: Colors.black12, thickness: 1);
