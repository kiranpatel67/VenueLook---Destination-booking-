// textstyles

import 'package:flutter/material.dart';

class AppTextStyles{
  static final TextStyle title = TextStyle(
    fontSize: 21,
    color: Colors.white,
  );

  static final TextStyle heading = TextStyle(
  fontSize: 34,
  color: Colors.white,
  );
  static TextStyle getTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      color: Colors.white
    );
  }

}



class TermHeadingStyle{
  static final TextStyle primary = TextStyle(
    color: Colors.green,
    fontStyle: FontStyle.italic,
  );
  static final TextStyle secondary = TextStyle(
    color: Colors.green,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
    decorationColor: Colors.green,
    decorationStyle: TextDecorationStyle.solid,
  );
}