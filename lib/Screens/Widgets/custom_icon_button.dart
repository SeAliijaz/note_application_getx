import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final Widget icon;
  CustomIconButton({this.color, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
