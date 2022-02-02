import 'package:flutter/material.dart';

class Utils {
  static fontsize({context, fontsize}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return (height / 10 * width / 10) / 1000 * fontsize;
  }
}

class AppColors {
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color grey900 = Colors.grey.shade900;
  static Color grey700 = Colors.grey.shade700;
  static Color deepPurple = Colors.deepPurple;
}
