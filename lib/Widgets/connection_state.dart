import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionStatusWidget extends StatelessWidget {
  String? text;
  ConnectionStatusWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            text ?? "text",
            textAlign: TextAlign.center,
            style: GoogleFonts.lateef(
              textStyle: const TextStyle(
                fontSize: 40.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Center(
          child: LinearProgressIndicator(),
        ),
      ],
    );
  }
}
