// ignore_for_file: unused_import, unnecessary_import, camel_case_types, unnecessary_new, deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:esh7enly/Services/features/xpayintegrate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:url_launcher_android/url_launcher_android.dart';
import 'package:esh7enly/Services/features/BankApi.dart';
import '../Services/features/ServiceApi.dart';
import '../core/utils/colors.dart';
import 'Service/details_transaction.dart';
import 'addbalance.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class balance extends StatefulWidget {
  const balance({Key? key}) : super(key: key);

  @override
  State<balance> createState() => _balanceState();
}

class _balanceState extends State<balance> {
  serviceApi service = new serviceApi();
  BankApi bank = new BankApi();
  String? balance = "";

  

  @override
  void initState() {
    
   
    getbal();
    super.initState();
  }

  getbal() {
    bank.getbalance().then((value) {
      setState(() {
        balance = value.toString();
      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                translator.currentLanguage == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                  Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          color: CustomColors.MainColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 50,
                            left: translator.currentLanguage == 'en' ? 62 : 260,
                            child: Text(
                              translator.translate("balance"),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            )),
                        Positioned(
                            top: 48,
                            left: translator.currentLanguage == 'en' ? 30 : 330,
                            child: SvgPicture.asset(
                              "assets/icon-06.svg",
                              width: 30,
                              height: 30,
                              color: Colors.white,
                            )),
                        Positioned(
                            top: 48,
                            left: translator.currentLanguage == 'en' ? 320 : 30,
                            child: Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(Addbalance());
                                  },
                                  child: Icon(
                                    Icons.add_box,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ))),
                        Positioned(
                            top: 89,
                            left: translator.currentLanguage == 'en' ? 65 : 240,
                            child: balance == "null"
                                ? Text(
                                    '    EGP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  )
                                : Text(
                                    ' ${balance.toString()} EGP',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  ))
                      ])),
                  SizedBox(
                    height: 600,
                    child: PagewiseListView(
                        pageSize: 10,
                        padding: const EdgeInsets.all(5.0),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, dynamic entry, index) {
                          print(entry.status);
                                                    if (entry == null) {
                            return const Center(
                              child: Text(
                                'لا يوجد ايداعات',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          } else {
                            DateTime time = DateTime.parse(entry.created_at);
                            List months = <String>[
                           
                              translator.currentLanguage == "en"
                                  ? 'Jan'
                                  : "يناير",
                              translator.currentLanguage == "en"
                                  ? 'Feb'
                                  : "فبراير",
                              translator.currentLanguage == "en"
                                  ? 'Mar'
                                  : "مارس",
                              translator.currentLanguage == "en"
                                  ? 'Apr'
                                  : "ابريل",
                              translator.currentLanguage == "en"
                                  ? 'May'
                                  : "مايو",
                              translator.currentLanguage == "en"
                                  ? 'Jun'
                                  : "يوينو",
                              translator.currentLanguage == "en"
                                  ? 'Jul'
                                  : "يوليو",
                              translator.currentLanguage == "en"
                                  ? 'Aug'
                                  : "اغسطس",
                              translator.currentLanguage == "en"
                                  ? 'Sep'
                                  : "سبنمبر",
                              translator.currentLanguage == "en"
                                  ? 'Oct'
                                  : "اكتوبر",
                              translator.currentLanguage == "en"
                                  ? 'Nov'
                                  : "نوفمبر",
                              translator.currentLanguage == "en"
                                  ? 'Dec'
                                  : "ديسمبر",
                            ];
                        
                            return SizedBox(
                                width: 500,
                                height: 130,
                                child: Card(
                                    color: CustomColors.greycolor,
                                    elevation: 3,
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 1,
                                        right: 10, //23 edit
                                        left: 10),//23 edit
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 130,
                                            color: entry.status == 'SUCCESSFUL'
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                              width: 60,//70 // edit
                                              height: 94,
                                              color: Colors.white,
                                              child: Center(
                                                child: Column(children: [
                                                  SizedBox(height: 20),
                                                  Text(
                                                    time.day.toString(),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(months[time.month - 1],
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17))
                                                ]),
                                              )
                                              // child:Text('${snapshot.data[index].created_at}')
                                              ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15,
                                                  right: translator
                                                              .currentLanguage ==
                                                          'ar'
                                                      ? 10
                                                      : 19,
                                                  left: 12,
                                                  bottom: 7),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: translator
                                                                            .currentLanguage ==
                                                                        'ar'
                                                                    ? 150
                                                                    : 133,
                                                                child: Text(
                                                                    entry.type == "card" ? translator.translate('card') :translator.translate('wallet') ,
                                                                    style: TextStyle(
                                                                        color: entry.status ==
                                                                                'SUCCESSFUL'
                                                                            ? Colors
                                                                                .green
                                                                            : Colors
                                                                                .red,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    translator.currentLanguage ==
                                                                            'ar'
                                                                        ? 3
                                                                        : 8,
                                                              ),
                                                              Text(
                                                                  " ${entry.id}:معرف الايداع ",
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          130,
                                                                          129,
                                                                          129),
                                                                      fontSize:
                                                                          14)),
                                                              SizedBox(
                                                                height:
                                                                    translator.currentLanguage ==
                                                                            'ar'
                                                                        ? 2
                                                                        : 4,
                                                              ),
                                                              Text(
                                                                  "${entry.amount}",
                                                                  style: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          130,
                                                                          129,
                                                                          129),
                                                                      fontSize:
                                                                          14)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 14,
                                                          ),
                                                          Center(
                                                            child: SizedBox(
                                                              width: translator
                                                                          .currentLanguage ==
                                                                      'ar'
                                                                  ? 63
                                                                  : 70,
                                                              height: 24,
                                                              
                                                              child: Text(
                                                                  entry.status ==
                                                                          'PENDING'
                                                                      ? translator.translate(
                                                                          "pending")
                                                                      : entry.status ==
                                                                              'SUCCESSFUL'
                                                                          ? translator.translate(
                                                                              "success")
                                                                          : entry.status =="CANCELLED"
                                                                            ? translator.translate(
                                                                              "canceltrans"):
                                                                          
                                                                          translator.translate(
                                                                              "fail"),
                                                                  style: TextStyle(
                                                                      color: entry
                                                                                  .status ==
                                                                              'SUCCESSFUL'
                                                                          ? 
                                                                          Colors.green:entry.status =="CANCELLED"
                                                                            ? Colors.orange
                                                                          : Colors
                                                                              .red,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                          )
                                                        ])
                                                  ]))
                                        ])));
                          }
                        },
                        pageFuture: (pageIndex) {
                          pageIndex = pageIndex! + 1;

                          return bank.getdeposits(context, pageIndex);
                        },
                        loadingBuilder: (context) {
                          return const CircularProgressIndicator(
                              color: CustomColors.MainColor);
                        }),
                    /*   SizedBox(
                      height: 600,
                      child: FutureBuilder(
                          future: bank.getdeposits(context,1),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.length);
                              print('oooo');
                           
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: CustomColors.MainColor));
                            }
                          })) */
                  )
                ])))));
  }
}
/*
Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(40, 90),
          child: AppBar(
            toolbarHeight: 90,
            backgroundColor: CustomColors.MainColor,
            leading: Icon(
              Icons.account_balance_wallet_outlined,
              size: 30,
            ),
            title: Column(children: [
              Text(
                "Balance     ",
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                height: 13,
              ),
              Text("0.00 EGP   ", style: TextStyle(fontSize: 19))
            ]),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(
                  Icons.add_box,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 247, 245, 245),
        body: GestureDetector(
          onTap: () {
            XPAY obj = new XPAY();
            obj.getiframe().then((value) {
              // _launchURL(value);
            });
          },
          child: Text("click"),
        ));
  }

  /*_launchURL(String ur) async {
    final Uri url = Uri.parse(ur);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  } */
}


 */






/*class _balanceState extends State<balance> {
  serviceApi service = new serviceApi();
  BankApi bank = new BankApi();
  String? balance="";
  @override
  void initState() {
    // TODO: implement initState
    getbal();
    super.initState();
  }

  getbal() {
    bank.getbalance().then((value) {
      setState(() {
        balance = value.toString();
        print(balance);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                translator.currentLanguage == 'en'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: SingleChildScrollView(
                  child: Form(
                    child: 
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                  Container(
                      height: 130,
                      decoration: const BoxDecoration(
                          color: CustomColors.MainColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 50,
                            left: translator.currentLanguage == 'en' ? 62 : 260,
                            child: Text(
                              translator.translate("balance"),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            )),
                        Positioned(
                            top: 48,
                            left: translator.currentLanguage == 'en' ? 30 : 330,
                            child: SvgPicture.asset(
                              "assets/icon-06.svg",
                              width: 30,
                              height: 30,
                              color: Colors.white,
                            )),
                        Positioned(
                            top: 48,
                            left: translator.currentLanguage == 'en' ? 320 : 30,
                            child: Padding(
                                padding: EdgeInsets.only(right: 100),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(Addbalance());
                                  },
                                  child: Icon(
                                    Icons.add_box,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ))),
                        Positioned(
                            top: 89,
                            left: translator.currentLanguage == 'en' ? 65 : 240,
                            child: balance=="null"?Text( '    EGP',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            ): Text(
                              ' ${balance.toString()} EGP',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            ))
                      ])),
                  SizedBox(
                   height:600,
                 child:
                  PagewiseListView(
                    pageSize: 10,
                    padding: const EdgeInsets.all(5.0),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, dynamic entry, index) {
                          if (entry == null) {
                        return const Center(
                          child: Text(
                            'لا يوجد ايداعات',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      } else {   
                                                DateTime time = DateTime.parse(
                                                   entry
                                                        .created_at);
                                                List months = <String>[
                                                  // ignore: deprecated_member_use
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Jan'
                                                      : "يناير",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Feb'
                                                      : "فبراير",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Mar'
                                                      : "مارس",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Apr'
                                                      : "ابريل",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'May'
                                                      : "مايو",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Jun'
                                                      : "يوينو",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Jul'
                                                      : "يوليو",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Aug'
                                                      : "اغسطس",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Sep'
                                                      : "سبنمبر",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Oct'
                                                      : "اكتوبر",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Nov'
                                                      : "نوفمبر",
                                                  translator.currentLanguage ==
                                                          "en"
                                                      ? 'Dec'
                                                      : "ديسمبر",
                                                ];
                                                print(translator
                                                    .translate("pending"));
                                                return Container(
                                                    width: 500,
                                                    height: 130,
                                                    child: Card(
                                                        color: CustomColors
                                                            .greycolor,
                                                        elevation: 3,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        margin: EdgeInsets
                                                            .only(
                                                            top: 10,
                                                            bottom: 1,
                                                            right:translator.currentLanguage=='ar'? 8:23,
                                                            left: 23),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0)),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 6,
                                                                height: 130,
                                                                color:entry
                                                                            .status ==
                                                                        'SUCCESSFUL'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red,
                                                              ),
                                                              SizedBox(width:10),
                                                              Container(
                                                                  width: 70,
                                                                  height: 94,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Center(
                                                                    child: Column(
                                                                        children: [
                                                                          SizedBox(
                                                                              height: 20),
                                                                          Text(
                                                                            time.day.toString(),
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 17),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 5),
                                                                          Text(
                                                                              months[time.month - 1],
                                                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17))
                                                                        ]),
                                                                  )
                                                                  // child:Text('${snapshot.data[index].created_at}')
                                                                  ),
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      top: 15,
                                                                      right: translator.currentLanguage=='ar'?10:22,
                                                                      left: 12,
                                                                      bottom:
                                                                          7),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  SizedBox( width:160,child: Text(
                                                                                      '${entry.type == "card" ? translator.translate('card') : entry.type == "wallet" ? translator.translate('wallet') : translator.translate("vodafone cash")}',
                                                                                      style: TextStyle(color:entry.status == 'SUCCESSFUL' ? Colors.green : Colors.red, fontSize: 15 , fontWeight: FontWeight.bold)),),
                                                                                  SizedBox(
                                                                                    height:2,
                                                                                  ),
                                                                                  Text(" ${entry.id}:معرف الايداع ", style: const TextStyle(color: Color.fromARGB(255, 130, 129, 129), fontSize: 14)),
                                                                                  SizedBox(
                                                                                    height: 2,
                                                                                  ),
                                                                                  Text("${entry.amount}", style: const TextStyle(color: Color.fromARGB(255, 130, 129, 129), fontSize: 14)),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 14,
                                                                              ),
                                                                              Center(
                                                                                child: Container(
                                                                                  width: 69,
                                                                                  height: 24,
                                                                                  child: Text(
                                                                                     entry.status == 'PENDING'
                                                                                          ? translator.translate("pending")
                                                                                          : entry.status == 'SUCCESSFUL'
                                                                                              ? translator.translate("success")
                                                                                              : translator.translate("fail"),
                                                                                      style: TextStyle(color: entry.status == 'SUCCESSFUL' ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                                                                                ),
                                                                              )
                                                                            ])
                                                                      ]))
                                                            ])));
                                              }
                    }, pageFuture: (pageIndex) {
                      pageIndex = pageIndex! + 1;

                      return bank.getdeposits(context, pageIndex);
                    },
                    loadingBuilder: (context) {
                      return const CircularProgressIndicator(color:CustomColors.MainColor);
                    }),
                 /*   SizedBox(
                      height: 600,
                      child: FutureBuilder(
                          future: bank.getdeposits(context,1),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data.length);
                              print('oooo');
                           
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: CustomColors.MainColor));
                            }
                          })) */
                )])))));
  }
} */