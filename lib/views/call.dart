// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/utils/colors.dart';
import 'dart:io';
import 'Service/showtransactions.dart';

class call extends StatefulWidget {
  const call({super.key});

  @override
  State<call> createState() => _callState();
}

class _callState extends State<call> {
  openwhatsapp() async {
    var whatsapp = "+201022997768";
   
    var whatsappURl_android = "whatsapp://send?phone=$whatsapp&text=";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("")}";

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
      }
    }
  }

  bool pressmail = false;
    late var emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List texts = [
      "    ${translator.translate("contact us")}",
      "    ${translator.translate("whatsapp")}",
      "    ${translator.translate("mail")}",
    ];

    List icons = [
      "assets/call.svg",
      "assets/whats app.svg",
      "assets/mail.svg",
    ];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 245, 245),
        body: SingleChildScrollView(
            child: Directionality(
                textDirection:
                    // ignore: unrelated_type_equality_checks
                    translator.currentLanguage == 'en'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
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
                                top: 48,
                                left: translator.currentLanguage == 'en'
                                    ? 56
                                    : 290,
                                child: Text(
                                  translator.translate("support"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'ReadexPro',
                                  ),
                                )),
                          ])),
                      Scrollbar(
                        child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: SizedBox(
                              width: 400,
                              height: 280,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          if (texts[index] ==
                                              "    ${translator.translate("whatsapp")}") {
                                            openwhatsapp();
                                          }
                                          if (texts[index] ==
                                              "    ${translator.translate("contact us")}") {
                                           // launch("tel://201022997768");
                                             launch("tel://19276");
                                          }
                                          if (texts[index] ==
                                              "    ${translator.translate("mail")}") {
                                            setState(() {
                                              pressmail = true;
                                            });
                                          }
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 300,
                                            margin: const EdgeInsets.only(
                                                left: 40,
                                                top: 10,
                                                right: 30,
                                                bottom: 30),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      CustomColors.MainColor),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 19, right: 20),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    icons[index],
                                                    color:
                                                        CustomColors.MainColor,
                                                  ),
                                                  Text(
                                                    texts[index],
                                                    style: const TextStyle(
                                                        fontFamily: 'ReadexPro',
                                                        color: CustomColors
                                                            .MainColor),
                                                  )
                                                ],
                                              ),
                                            )));
                                  }),
                            )),
                      ),
                      pressmail == true
                          ? SizedBox(
                              width: 300,
                              child: TextField(
                                controller:emailcontroller ,
                                cursorColor: Colors.green,
                                decoration: InputDecoration(
                                    iconColor: Colors.green,
                                    fillColor: Colors.green,
                                    labelText: translator.translate("write"),
                                    labelStyle: TextStyle(color: Colors.green)),
                              ))
                          : Text(""),
                      SizedBox(
                        height: 10,
                      ),
                      pressmail == true
                          ? GestureDetector(
                            onTap:() async {
                              String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
                              final Uri emailurl=Uri(
                              scheme: 'mailto',
                                path:'info@e-esh7nly.com',
                                query: encodeQueryParameters(<String, String>{
      'subject': 'Need Support',
      'body':emailcontroller.text
    }),
                              );
                                launchUrl(emailurl);
                              /*  final Email email = Email(
        body:emailcontroller.text
            ,
        subject: 'Need Support',
        recipients: ['info@e-esh7nly.com'],
        isHTML: true,
      );

await FlutterEmailSender.send(email);
                            }, */},
                            child:Container(
                              height: 30,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 47),
                              decoration: BoxDecoration(
                                color: CustomColors.MainColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  translator.translate("sendmsg"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'ReadexPro',
                                  ),
                                ),
                              ),
                            ))
                          : Text(""),
                    ]))));
  }
}
