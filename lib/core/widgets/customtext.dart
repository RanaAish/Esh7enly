// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


// ignore: camel_case_types
class customtext extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String fontfamily;
  final fontweight;
  final Alignment alignment;
  final int maxLine;
  final double height;

  // initial values
  // ignore: use_key_in_widget_constructors
  const customtext(
      {this.text = "",
      this.fontSize = 14,
      this.color = Colors.black,
      this.fontfamily = "SegoeUI",
      this.alignment = Alignment.topLeft,
      required this.maxLine,
      this.fontweight,
      this.height = 1});
  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
     
      style: TextStyle(
        
          color: color,
          fontSize: fontSize,
          fontFamily: fontfamily,
          height: height,
          fontWeight: fontweight),
      maxLines: maxLine,
    );
  }
}
