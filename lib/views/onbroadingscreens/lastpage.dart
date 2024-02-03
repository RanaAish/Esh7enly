// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:esh7enly/views/Login/register.dart';
import 'package:esh7enly/views/onbroadingscreens/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:esh7enly/views/Login/otp.dart';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';

class LastPage extends StatefulWidget {
  LastPage({super.key});

  @override
  State<LastPage> createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> with TickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  late final AnimationController _controller;
  var json="";

  @override
  void initState() {
    
    
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: 
        SingleChildScrollView(
          child:
        Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: Center(
              child: Text(
                'مع اشحنلي',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.MainColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Center(
              child: Text('سجل واشحن',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.MainColor)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Center(
              child: Text('في ثانيه',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.MainColor)),
            ),
          ),
          SizedBox(
           // height: 300,
            child: Lottie.asset(
              'assets/create_account.json',
              height: 260,
              controller: _controller,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
      
          GestureDetector(
            onTap: () {
              storage.write(key: 'onbreoading', value: 'true');
             Get.offAll(otp());  // Get.off
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'انشاء حساب جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              storage.write(key: 'onbreoading', value: 'true');
              Get.offAll(login());  //Get.off
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 100),
              decoration: BoxDecoration(
                color: CustomColors.MainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'تخطي لتسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
            ),    
          ),
          SizedBox(width: 400, child:  SvgPicture.string(
            
'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
  <path fill="#e7bab6" fill-opacity="1" d="M0,192L26.7,202.7C53.3,213,107,235,160,240C213.3,245,267,235,320,208C373.3,181,427,139,480,117.3C533.3,96,587,96,640,117.3C693.3,139,747,181,800,170.7C853.3,160,907,96,960,90.7C1013.3,85,1067,139,1120,144C1173.3,149,1227,107,1280,90.7C1333.3,75,1387,85,1413,90.7L1440,96L1440,320L1413.3,320C1386.7,320,1333,320,1280,320C1226.7,320,1173,320,1120,320C1066.7,320,1013,320,960,320C906.7,320,853,320,800,320C746.7,320,693,320,640,320C586.7,320,533,320,480,320C426.7,320,373,320,320,320C266.7,320,213,320,160,320C106.7,320,53,320,27,320L0,320Z"></path>
</svg>'''
  , fit: BoxFit.cover ,height: 230,)),
        ])));
  }
}
