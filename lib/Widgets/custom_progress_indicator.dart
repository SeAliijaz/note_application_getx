import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProgressIndicator extends StatelessWidget {
  String? textMessage;

  CustomProgressIndicator({
    Key? key,
    this.textMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              textMessage ?? "text message",
              style: GoogleFonts.salsa(
                textStyle: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: LinearProgressIndicator(),
          )
        ],
      ),
    );
  }
}
