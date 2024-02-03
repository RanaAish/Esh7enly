import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class CustomButtonIcon extends StatelessWidget {
  final String text;

  final FontWeight fontweight;

  final Color color;
  // ignore: prefer_typing_uninitialized_variables
  final colortext;
  final double w;
  final double h;
  final double fsize;
  final double m;
  final double p;
  final Color bordercolor;
  final VoidCallback onPress;
  final String url;
  final double wicon;
  // ignore: prefer_typing_uninitialized_variables
  final coloricon;
  final double hicon;

  // ignore: use_key_in_widget_constructors
  const CustomButtonIcon(
      {required this.onPress,
      this.text = 'Write text ',
      this.color = CustomColors.MainColor,
      this.bordercolor = CustomColors.MainColor,
      this.fontweight = FontWeight.bold,
      this.colortext,
      this.w = 300,
      this.coloricon = Colors.white,
      this.h = 50,
      this.p = 10,
      this.fsize = 17,
      this.m = 29,
      this.wicon = 50,
      this.hicon = 50,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // margin: EdgeInsets.symmetric(horizontal: m),
        //padding: EdgeInsets.only(top: p, bottom: p),
        width: w,
        height: h,
        child: OutlinedButton(
            onPressed: onPress,
            style: OutlinedButton.styleFrom(
              backgroundColor: color,
              side: BorderSide(color: bordercolor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  7.0,
                ),
              ),
            ),
            child: Center(
                child: SvgPicture.asset(
              url,
              width: wicon,
              height: hicon,
              fit: BoxFit.cover,
              color: coloricon,
            ))));
  }
}
