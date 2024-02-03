// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../utils/colors.dart';

class header extends StatelessWidget {
  double heightcon;
  header({Key? key, required this.heightcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: heightcon,
        decoration: const BoxDecoration(
            color: CustomColors.MainColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        child: Stack(children: <Widget>[
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
              top: 150,
              left: translator.currentLanguage == 'en' ? 80 : 50,
              child: Center(
                  child: Text(
               
                translator.translate("caption"),
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'ReadexPro'),
              ))),
          Positioned(
              top: 178,
              left: 128,
              child: Center(
                  child: Text(
                translator.translate("caption2"),
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ReadexPro',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )))
        ]));
  }
}
