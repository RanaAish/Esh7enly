// ignore_for_file: prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/onbroadingscreens/lastpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreePage extends StatelessWidget {
  const ThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 700, child: Image.asset('assets/broading1.jpeg')),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              Get.to(LastPage());
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 70),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'التالي',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
