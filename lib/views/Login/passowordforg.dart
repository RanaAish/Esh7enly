// ignore_for_file: camel_case_types, prefer_const_constructors, deprecated_member_use, prefer_const_declarations

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/views/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class passwordforg extends StatefulWidget {
  const passwordforg({super.key});

  @override
  State<passwordforg> createState() => _passwordforgState();
}

class _passwordforgState extends State<passwordforg> {
  bool passwordsecure = true;
  bool passwordsecureconfirm = true;
  TextEditingController password = TextEditingController();
  TextEditingController passwordconfirm = TextEditingController();
  var mobile = Get.arguments;
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
                                top: 38,
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
                                top: 45,
                                left: translator.currentLanguage == 'en'
                                    ? 30
                                    : 335,
                              child: GestureDetector(
                                  onTap:(){
                                    Get.back();
                                  },
                                  child:Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 26,
                                )
                                ))
                          ])),
                      SizedBox(
                        height: 130,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(top: 25, right: 25, left: 25),
                          child: CustomTextField(
                            hint: translator.translate("new pass"),
                            w: 100,
                            OnTab: () {},
                            controller: password,
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
                            hint: translator.translate("reply new pass"),
                            w: 100,
                            OnTab: () {},
                            controller: passwordconfirm,
                            obsesure: passwordsecureconfirm,
                            suffic: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordsecureconfirm =
                                      !passwordsecureconfirm;
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
                          AuthApi authApi = AuthApi();
                          final storage = const FlutterSecureStorage();

                          storage.read(key: 'otpforgetpass').then((value) {
                            authApi
                                .postnewpassword(mobile, value!, password.text,
                                    passwordconfirm.text,context)
                                .then((value1) {
                              openAlert(value1);
                              //showAlertDialog(context, value1);
                            });
                          });
                          //  Get.to(login());
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 29),
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
                      )
                    ])))));
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Get.off(login());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void openAlert(String mess) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: SizedBox(
        height: 150.0,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //   decoration: boxDecorationStylealert,
          width: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("Success",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 14,
              ),
              Center(
                child: Text(
                  mess,
                
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Center(
                child: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 0),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.off(login());
                      },
                      color: CustomColors.MainColor,
                      // ignore: sort_child_properties_last
                      child: Text(
                        "OK",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
