// ignore_for_file: unnecessary_import, unused_import, camel_case_types, deprecated_member_use, prefer_const_constructors, unnecessary_new, unnecessary_brace_in_string_interps

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/header.dart';

class changepassword extends StatefulWidget {
  const changepassword({super.key});

  @override
  State<changepassword> createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  bool passwordsecure = true;
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController password3 = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                                    left: translator.currentLanguage == 'en'
                                        ? 66
                                        : 200,
                                    child: Text(
                                      translator.translate("change password"),
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'ReadexPro',
                                        color: Colors.white,
                                      ),
                                    )),
                                Positioned(
                                    top: 48,
                                    left: translator.currentLanguage == 'en'
                                        ? 30
                                        : 335,
                                    child: GestureDetector(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                      onTap: () {
                                        Get.back();
                                      },
                                    ))
                              ])),
                          SizedBox(
                            height: 130,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25, right: 25, left: 25),
                              child: CustomTextField(
                                hint: translator.translate("current pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password1,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25, right: 25, left: 25),
                              child: CustomTextField(
                                hint: translator.translate("new pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password2,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 14, right: 26, left: 26, bottom: 5),
                              child: Text(
                                translator.translate("passwordcodition"),
                                style: TextStyle(
                                    color: CustomColors.MainColor,
                                    fontSize: 15),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 12, right: 25, left: 25),
                              child: CustomTextField(
                                hint: translator.translate("reply new pass"),
                                w: 100,
                                OnTab: () {},
                                controller: password3,
                                obsesure: passwordsecure,
                                suffic: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordsecure = !passwordsecure;
                                    });
                                  },
                                  icon: passwordsecure
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              )),
                          SizedBox(
                            height: 45,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_globalKey.currentState!.validate()) {
                                //EasyLoading.showProgress(0.3, status: 'loading...');
                                EasyLoading.show(
                                    status: translator.currentLanguage == 'ar'
                                        ? 'جاري التحميل '
                                        : 'loading...',
                                    maskType: EasyLoadingMaskType.black);
                                _globalKey.currentState!.save();
                                AuthApi object = new AuthApi();
                                if (password2.text.trim() ==
                                    password3.text.trim()) {
                                       EasyLoading.dismiss();
                                  object.changepassword(
                                      password1.text, password2.text, context).then((value) {
                                        DailogAlert.openAlert(
                                      '${value}',
                                     translator.translate("suceessmessage"),
                                      context);
                                      });
                                 

                                } else {
                                  EasyLoading.dismiss();
                                  DailogAlert.openbackAlert(
                                      'password don\'t match',
                                       translator.translate("failedmessage"),
                                      context);
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              decoration: BoxDecoration(
                                color: CustomColors.MainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  translator.translate("change password"),
                                  style: const TextStyle(
                                      fontFamily: 'ReadexPro',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ])))));
  }
}
