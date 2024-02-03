// ignore_for_file: prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/onbroadingscreens/page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePage extends StatelessWidget {
  const OnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/broading3.jpeg'),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              Get.to(const TwoPage());
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
