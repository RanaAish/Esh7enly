// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/onbroadingscreens/lastpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class onbroadingpage extends StatefulWidget {
  const onbroadingpage({super.key});

  @override
  State<onbroadingpage> createState() => _onbroadingpageState();
}

class _onbroadingpageState extends State<onbroadingpage> {
  int currentIndex = 0;
  late PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List contents = ['assets/broading3.jpeg','assets/broading2.jpeg','assets/broading1.jpeg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(child:Column(children: [
       SizedBox(
                  height: 700,child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return
                 Image.asset(contents[i]
                );
              })),
                   const SizedBox(height: 10),
                GestureDetector(
            onTap: () async {
              if (currentIndex == contents.length - 1) {
                  Get.to(LastPage());
                    
                  
            }
             _controller.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.decelerate,
                );
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 70),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: const Text(
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
    ])));
  }
}
