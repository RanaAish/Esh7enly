// ignore_for_file: unnecessary_import, camel_case_types, deprecated_member_use, prefer_const_constructors

import 'package:esh7enly/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../controlls/Homviewmodel.dart';
import '../../views/controllhome.dart';
import 'package:bottom_indicator_bar_svg/bottom_indicator_bar_svg.dart';

class bottomnavigationbar extends StatelessWidget {
  bottomnavigationbar({Key? key}) : super(key: key);
  final List<BottomIndicatorNavigationBarItem> items = [
    BottomIndicatorNavigationBarItem(icon: Icons.home, label: Text('Home')),
    BottomIndicatorNavigationBarItem(icon: Icons.search, label: 'Search'),
    BottomIndicatorNavigationBarItem(icon: '', label: 'Svg'),
    BottomIndicatorNavigationBarItem(
      icon: 'assets/inactiveIcon.svg',
      activeIcon: 'assets/activeIcon.svg',
      label: 'Account',
    ),
  ]; 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controler) => Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                translator.currentLanguage == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child:Container(    
            height:   translator.currentLanguage=='en'?55:63,                                        
  decoration: BoxDecoration(                                                   
    borderRadius: BorderRadius.only(                                           
      topRight: Radius.circular(30), topLeft: Radius.circular(30)),            
    boxShadow: const [                                                               
      BoxShadow(color: Colors.transparent, spreadRadius: 0, blurRadius: 0),       
    ],                                                                         
  ),                                                                           
  child: ClipRRect(                                                            
    borderRadius: BorderRadius.only(                                           
    topLeft: Radius.circular(30.0),                                            
    topRight: Radius.circular(30.0),                                           
    ),                                                                         
    child:ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0), ),
        child:BottomNavigationBar(
          elevation: 0.0,
          currentIndex: controler.navigatovalue,
          type: BottomNavigationBarType.fixed,
          backgroundColor:CustomColors.SecondryColor,   
            selectedItemColor: Colors.white,
                    selectedLabelStyle: TextStyle(color: Colors.white),
                     unselectedLabelStyle: TextStyle(color: CustomColors.SecondryColor),
                     showUnselectedLabels: false,
                      onTap: (selectedvalue) {
                      controler.changeselectedvalue(selectedvalue);
                      Get.offAll(Controllhomeview());
                    },
                   // type: BottomNavigationBarType.fixed,
                    // ignore: prefer_const_literals_to_create_immutables                                      
         items:  <BottomNavigationBarItem>[                                        
         BottomNavigationBarItem(                            
          icon: Image.asset('images/gift .png',width: 30,height: 25,),label:translator.translate("gift")),               
        BottomNavigationBarItem(                                               
          icon: Image.asset('images/icon-03.png',width: 30,height: 25,), label:translator.translate("support")),
            BottomNavigationBarItem(                                               
          icon: Image.asset('images/icon-05.png',width: 30,height: 25), label:  translator.translate("home screen")) ,
            BottomNavigationBarItem(                                               
          icon: Image.asset('images/icon-06.png',width: 30,height: 25), label: translator.translate("balance"))  ,    
          BottomNavigationBarItem(                                               
          icon: Image.asset('images/icon-04.png',width: 30,height: 25), label: translator.translate("profile"))  ,             
      ],                                                                       
    ),          
                    //activeColor: Color.fromARGB(255, 24, 24, 24),
                    //selectedIconTheme: IconThemeData(color: CustomColors.MainColor),
                    //unselectedItemColor: Colors.black,
                   
                    // showUnselectedLabels: false,
                    //type: BottomNavigationBarType.fixed,
                    // ignore: prefer_const_literals_to_create_immutables
                  ))
              
  )));
  }
}
/*Container(
        height: 50,
        decoration: const BoxDecoration(
            color: CustomColors.MainColor,
            borderRadius: BorderRadius.only(
               topRight: Radius.circular(70),
              topLeft: Radius.circular(70))),
               child: (BottomIndicatorBar(
                //
                    iconSize: 25,
                    //  indicatorColor: Colors.white,
                    currentIndex: controler.navigatovalue,
                    onTap: (selectedvalue) {
                      controler.changeselectedvalue(selectedvalue);
                      Get.offAll(Controllhomeview());
                    },

                    //elevation: 0.0,
                    backgroundColor: CustomColors.MainColor,
                    inactiveColor: Colors.white,
                    activeColor: Color.fromARGB(255, 24, 24, 24),
                    //selectedIconTheme: IconThemeData(color: CustomColors.MainColor),
                    //unselectedItemColor: Colors.black,
                    //selectedItemColor: CustomColors.MainColor,
                    //selectedLabelStyle: TextStyle(color: CustomColors.MainColor),
                    // unselectedLabelStyle: TextStyle(color: Colors.black),
                    // showUnselectedLabels: false,
                    //type: BottomNavigationBarType.fixed,
                    // ignore: prefer_const_literals_to_create_immutables
                    items: [
                      BottomIndicatorNavigationBarItem(
                          icon: 'assets/gift .svg',
                          label: translator.translate("gift")),
                      BottomIndicatorNavigationBarItem(
                          icon: 'assets/icon-03.svg',
                          label: translator.translate("support")),
                      BottomIndicatorNavigationBarItem(
                          icon: 'assets/icon-05.svg',
                          label: translator.translate("home screen")),
                      BottomIndicatorNavigationBarItem(
                          icon: 'assets/icon-06.svg',
                          label: translator.translate("balance")),
                      BottomIndicatorNavigationBarItem(
                          icon: 'assets/icon-04.svg',
                          label: translator.translate("profile")),
                    ]))
              
               /*Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(),
                  ],
                ), */
               ) */
/*  items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icon-02.png")),
                      label: "r"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icon-03.png")),
                      label: "r"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icon-05.png")),
                      label: "r"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icon-06.png")),
                      label: "v"),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/icon-04.png")),
                      label: "r"),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet_outlined),
                  ),
                  /*const BottomNavigationBarItem(
                      icon: Icon(Icons.account_box)),

                       const BottomNavigationBarItem(
                      icon: Icon(Icons.account_box)),
                       const BottomNavigationBarItem(
                      icon: Icon(Icons.account_box)),
 */
                ])));
  } */


  /* */