// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final FontWeight fontweight;

  final Color color;
  final colortext;
  final double w;
  final double h;
  final double fsize;
  final double m;
  final double p;

  final VoidCallback onPress;

  // ignore: use_key_in_widget_constructors
  const CustomButton(
      {required this.onPress,
      this.text = 'Write text ',
      this.color = CustomColors.MainColor,
      this.fontweight = FontWeight.bold,
      required this.colortext,
      this.w = 300,
      this.h = 50,
      this.p = 10,
      this.fsize = 17,
      this.m = 29,
      required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: m),
        padding: EdgeInsets.only(top: p, bottom: p),
        width: w,
        height: h,
        child: OutlinedButton(
          onPressed: onPress,
          style: OutlinedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: customtext(
            alignment: Alignment.center,
            text: text,
            color: colortext,
            fontSize: fsize,
            fontweight: fontweight,
            maxLine: 1,
          ),
        ));
  }
}
