// ignore_for_file: unnecessary_import, camel_case_types, deprecated_member_use, prefer_const_constructors

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/core/widgets/customtext.dart';
import 'package:esh7enly/core/widgets/header.dart';
import 'package:esh7enly/views/Login/otpcheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class forgerpassword extends StatefulWidget {
  const forgerpassword({super.key});

  @override
  State<forgerpassword> createState() => _forgerpasswordState();
}

class _forgerpasswordState extends State<forgerpassword> {
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
                            heightcon: 200,
                          ),
                          const SizedBox(
                            height: 130,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 23,
                            fontfamily: 'ReadexPro',
                            text: translator.translate("otp msg1"),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          customtext(
                            maxLine: 2,
                            color: CustomColors.MainColor,
                            fontSize: 23,
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
                                  AuthApi authApi = AuthApi();
                                  authApi.forgetpassword(phonecontroller.text,context);
                                  Get.to(otpcheck(),arguments: phonecontroller.text);
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
