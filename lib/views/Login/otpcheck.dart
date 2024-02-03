// ignore_for_file: camel_case_types, deprecated_member_use, prefer_const_constructors, prefer_const_declarations


import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:esh7enly/core/widgets/header.dart';
import 'package:esh7enly/views/Login/passowordforg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sms_autofill/sms_autofill.dart';

class otpcheck extends StatefulWidget {
  const otpcheck({super.key});

  @override
  State<otpcheck> createState() => _otpcheckState();
}

class _otpcheckState extends State<otpcheck> {
  var _code = "";
  var mob = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
     
      child: Directionality(
          textDirection:
              // ignore: unrelated_type_equality_checks
              translator.currentLanguage == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            header(
              heightcon: 200,
            ),
            const SizedBox(
              height: 100,
            ),
            customtext(
              maxLine: 2,
              color: CustomColors.MainColor,
              fontSize: 25,
              fontfamily: 'ReadexPro',
              text: translator.translate("confirmation"),
            ),
            const SizedBox(
              height: 29,
            ),
            customtext(
              maxLine: 2,
              color: CustomColors.MainColor,
              fontSize: 19,
              fontfamily: 'ReadexPro',
              text: translator.translate("enter otp1"),
            ),
            const SizedBox(
              height: 10,
            ),
            customtext(
              maxLine: 1,
              text: translator.translate('enter otp2'),
              fontfamily: 'ReadexPro',
              color: CustomColors.MainColor,
              fontSize: 19,
            ),
            SizedBox(height: 35),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 105),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                      textStyle: const TextStyle(
                          fontSize: 20, color: CustomColors.MainColor),
                      colorBuilder: FixedColorBuilder(CustomColors.MainColor)),
                  currentCode: _code,
                  codeLength: 6,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code!.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _code = code;
                      });
                    }
                  },
                )),
            SizedBox(height: 90),
            GestureDetector(
              onTap: () {
                final storage = const FlutterSecureStorage();
                storage.read(key: 'otpforgetpass').then((value) {
                  if (_code == value) {
                    Get.to(passwordforg(), arguments: mob);
                  } else {
                 
                  }
                });
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 47),
                decoration: BoxDecoration(
                  color: CustomColors.MainColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    translator.translate("confirmation2"),
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ])),
    ));
  }
}
