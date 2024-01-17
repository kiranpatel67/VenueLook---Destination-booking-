import 'package:get/get.dart';
import 'package:flutter/material.dart';


class GreenButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool? isEnabled;

  GreenButton({required this.text, this.onPressed, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(screenHeight * 0.015),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenHeight * 0.023,
            ),
          ),
        ),
      );

  }
}
