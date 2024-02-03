// ignore_for_file: camel_case_types, unnecessary_new, deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import '../../Services/features/ServiceApi.dart';
import '../../core/utils/colors.dart';
import 'details_transaction.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class showtransactions extends StatefulWidget {
  const showtransactions({super.key});

  @override
  State<showtransactions> createState() => showtransactionsState();
}

class showtransactionsState extends State<showtransactions> {
  serviceApi service = new serviceApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
            textDirection:
                // ignore: unrelated_type_equality_checks
                translator.currentLanguage == 'ar'
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                  Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          color: CustomColors.MainColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 45,
                            left: translator.currentLanguage == 'en' ? 62 : 260,
                            child: Text(
                              translator.translate("transactions"),
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'ReadexPro',
                              ),
                            )),
                        Positioned(
                            top: 45,
                            left:  translator.currentLanguage=='ar'?   350:30,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                 Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 26,
                                  )),
                            ))
                      ])),
                  SizedBox(
                      height: 700.h,
                      child:  PagewiseListView(
                    pageSize: 15,
                    padding: const EdgeInsets.all(5.0),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, dynamic entry, index) {
                          if (entry == null) {
                        return const Center(
                          child: Text(
                            'لا يوجد عمليات',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      } else { 
                     
                         return SizedBox(
                                                    width: 80.w,
                                                    height: 108.h,
                                                    child: Padding(
                                                      padding:
                                                         EdgeInsets.only(
                                                              top: 12.h,
                                                              right: 8.w,//20 edit
                                                              left: 10.w),//20 edit
                                                      child: GestureDetector(
                                                          onTap: () {
                                                           
                                                            service
                                                                .getdetailstranaction(
                                                                  entry
                                                                        .id,
                                                                    context)
                                                                .then((value) {
                                                              //  print("tt${value.id}");
                                                              Get.to(
                                                                  transaction_details(
                                                                bluknumber: 0,
                                                                isbluck: false,
                                                                paymentobject:
                                                                    value,
                                                                servicetype:
                                                                    value
                                                                        .service
                                                                        .type,
                                                              ));
                                                            });
                                                          },
                                                          child: Card(
                                                              color: CustomColors
                                                                  .greycolor,
                                                              elevation: 3,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              margin:
                                                                 EdgeInsets
                                                                      .only(
                                                                      top: 0.h,
                                                                      bottom: 1.h,
                                                                      right: 0,
                                                                      left: 0),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0)),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                23.h,
                                                                            right:
                                                                                14.w, //18
                                                                            left:
                                                                                14.w, //20
                                                                            bottom:
                                                                                7.h),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                entry.status== 1
                                                                                    ? translator.translate("pending")
                                                                                    : entry.status == 2
                                                                                        ? translator.translate("success")
                                                                                        : translator.translate("fail"),
                                                                                style: TextStyle(color:entry.status == 2 ? Colors.green : Colors.red, fontSize: 14)),
                                                                            SizedBox(
                                                                              height: 8.h,
                                                                            ),
                                                                            Text(entry.totalAmount,
                                                                                style: TextStyle(color: entry.status == 2 ? Colors.green : Colors.red, fontSize: 14))
                                                                          ],
                                                                        )),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 10.h, right: 10), //10
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                //  entry.service.name
                                                                           SizedBox(width:150,child:  Text(  entry.service.name,
                                                                           textAlign:translator.currentLanguage=='ar'?TextAlign.right:TextAlign.left,
                                                                           softWrap: true, style: TextStyle(color: Colors.red, fontSize: 16 ,
                                                                                ),),),
                                                                                SizedBox(
                                                                                  height: 2.h,
                                                                                ),
                                                                                Text("${entry.id.toString()}:رقم العمليه", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                                                                Text(entry.createdAt, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 10.w, left: 8.w),//15
                                                                            width:
                                                                                60,
                                                                            height:
                                                                                64,
                                                                            color:
                                                                                Colors.white,
                                                                            child: entry.service.icon.isEmpty
                                                                                ? Image.asset('assets/logo.png')
                                                                                : CachedNetworkImage(
                                                                                    imageUrl: "https://system.e-esh7nly.net/storage/${entry.service.icon}",
                                                                                    placeholder: (context, url) => Center(
                                                                                      child: Image.asset('assets/logo.png'),
                                                                                    ),
                                                                                    errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
                                                                                  ),
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(right: 0),
                                                                              child: Container(
                                                                                width: 6.w,
                                                                                height: 130.h,
                                                                                color: entry.status == 2 ? Colors.green : Colors.red,
                                                                              )),
                                                                        ])
                                                                  ]))),
                                                    ));

                      }}
                       , pageFuture: (pageIndex) {
                      pageIndex = pageIndex! + 1;

                      return  service.gettranactions(pageIndex, context);
                    },
                    loadingBuilder: (context) {
                      return const CircularProgressIndicator(color:CustomColors.MainColor);
                    }),),
                      
                      
                      
                      
                     
                ])))));
  }
}
