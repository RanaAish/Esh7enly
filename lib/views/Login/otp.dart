// ignore_for_file: unnecessary_import, unused_import, camel_case_types, deprecated_member_use, prefer_const_constructors, prefer_const_declarations

import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/header.dart';
import 'login.dart';
import 'otpauth.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';

class otp extends StatefulWidget {
  const otp({Key? key}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late var phonecontroller = TextEditingController();

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
                child: Form(
                    key: _globalKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          header(
                            heightcon: 210,
                          ),
                          const SizedBox(
                            height: 130,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 20,//23
                            fontfamily: 'ReadexPro',
                            text: translator.translate("otp msg1"),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 20,//23
                            fontfamily: 'ReadexPro',
                            text: translator.translate("otp msg2"),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 30, right: 45, left: 45),
                              child: CustomTextField(
                                hint: translator.translate('enter phone'),
                                w: 60,
                                OnTab: () {},
                                controller: phonecontroller,
                              )),
                          SizedBox(height: 55),
                          GestureDetector(
                              onTap: () {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  AuthApi object = AuthApi();
                                  final storage = const FlutterSecureStorage();
                                  object.Sendotp(phonecontroller.text)
                                      .then((value) {
                                      
                                    if (value["status"] == true) {
                                      storage.write(
                                          key: 'mobile',
                                          value: phonecontroller.text);

                                      Get.to(const otpauth());
                                    } else if (value["data"]
                                                ["middleware_validation_error"]
                                            ["mobile"][0] ==
                                        "The mobile has already been taken.") {
                                           DailogAlert.openbackAlert(
                               'The mobile has already been taken', translator.translate("failedmessage"), context);
                                   
                                      storage.write(
                                          key: 'verifyotp', value: "true");
                                   
                                      Get.off(login());
                                    } else {
                                        DailogAlert.openbackAlert(
                          value['message'], translator.translate("failedmessage"), context);
                                  
                                    }
                                  });
                                }
                              },
                              child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 43),
                                  decoration: BoxDecoration(
                                    color: CustomColors.MainColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      translator.translate('send otp'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ReadexPro',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            translator.translate("reply send otp"),
                            style: TextStyle(
                                fontFamily: 'ReadexPro',
                                fontSize: 16,
                                color: CustomColors.MainColor),
                          )
                        ])))));
  }
}
