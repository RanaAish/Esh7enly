// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors, deprecated_member_use, prefer_const_declarations, use_build_context_synchronously

import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/views/Login/otpauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/CustomTextField.dart';
import '../../core/widgets/customebuttun.dart';
import '../../core/widgets/customtext.dart';

import 'package:esh7enly/views/Login/login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../core/widgets/header.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late var namecontroller = TextEditingController();
  late var firstnamecontroller = TextEditingController();
  late var lastnamecontroller = TextEditingController();
  late var emailcontroller = TextEditingController();
  late var passwordcontroller = TextEditingController();
  late var confirmpasswordcontroller = TextEditingController();
  bool passwordsecure = true;
  bool passwordsecureconfirm = true;
  bool remeberme = false;
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
          children: <Widget>[
            header(
              heightcon: 200,
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: Text(
              translator.translate("register"),
              style: TextStyle(
                color: CustomColors.MainColor,
                fontSize: 24.sp,
                fontFamily: 'ReadexPro',
              ),
            )),
            /* Padding(
                padding: EdgeInsets.only(top: 20, right: 25, left: 25),
                child: CustomTextField(
                  hint: translator.translate("fullname"),
                  w: 100,
                  OnTab: () {},
                  controller: namecontroller,
                )), */
            Padding(
                padding:
                    EdgeInsets.only(top: 28, right: 25, left: 25, bottom: 5),
                child: SizedBox(
                  child: Expanded(child:Row(
                    
                    children: [
                      SizedBox(
                        width: 145.w,
                        child: CustomTextField(
                          hint: translator.translate("firstname"),
                          w: 145.w,
                          OnTab: () {},
                          controller: firstnamecontroller,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 147.w,
                        child: CustomTextField(
                          hint: translator.translate("lastname"),
                          w: 147.w,
                          OnTab: () {},
                          controller: lastnamecontroller,
                        ),
                      )
                    ],
                  ),)
                )),
            Padding(
                padding:
                    EdgeInsets.only(top: 20.h, right: 25.w, left: 25.w, bottom: 5.h),
                child: CustomTextField(
                  hint: translator.translate("Password"),
                  w: 100.w,
                  OnTab: () {},
                  controller: passwordcontroller,
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
                    EdgeInsets.only(top: 10.h, right: 26.w, left: 26.w, bottom: 5.h),
                child: Text(
                  translator.translate("passwordcodition"),
                  style: TextStyle(color: CustomColors.MainColor, fontSize: 15),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10.h, right: 25.w, left: 25.w),
                child: CustomTextField(
                  hint: translator.translate("confirm pass"),
                  w: 100.w,
                  OnTab: () {},
                  controller: confirmpasswordcontroller,
                  obsesure: passwordsecureconfirm,
                  suffic: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordsecureconfirm = !passwordsecureconfirm;
                      });
                    },
                    icon: passwordsecureconfirm
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20.h, right: 25.w, left: 25.w),
                child: CustomTextField(
                  hint: translator.translate("em"),
                  w: 100.w,
                  OnTab: () {},
                  controller: emailcontroller,
                )),
          SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Checkbox(
                    activeColor: remeberme ? Colors.blue : Colors.white,
                    checkColor: CustomColors.MainColor,
                    value: remeberme,
                    onChanged: (bool? value) {
                      setState(() {
                        remeberme = value!;
                      });
                    },
                  ),
                ),
                Text(
                  translator.translate("confirm"),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ],
            ),
           SizedBox(
              height: 10.h,
            ),
            GestureDetector(
                onTap: () async {
                  print(firstnamecontroller.text +lastnamecontroller.text);
                  final storage = const FlutterSecureStorage();

                  var mobile = await storage.read(key: 'mobile');

                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState!.save();
                    EasyLoading.show(
                        status: translator.currentLanguage == 'ar'
                            ? 'جاري التحميل '
                            : 'loading...',
                        maskType: EasyLoadingMaskType.black);
                    if (passwordcontroller.text.trim() ==
                        confirmpasswordcontroller.text.trim()) {
                      if (remeberme == true) {
                        AuthApi object = AuthApi();
                        String? identifier = await UniqueIdentifier.serial;

                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[%!@#\$&*~]).{8,}$');

                        if (!regex.hasMatch(passwordcontroller.text)) {
                          EasyLoading.dismiss();
                          DailogAlert.openbackAlert('Enter valid password',
                              translator.translate("Warning"), context);
                        } else {
                          object
                              .register(
                                  mobile!,
                                  identifier!,
                                  passwordcontroller.text,
                                 firstnamecontroller.text +' '+lastnamecontroller.text,
                                  emailcontroller.text)
                              .then((value) {
                            if (value["status"] == true) {
                              EasyLoading.dismiss();
                              DailogAlert.openAlert(
                                  value['message'],
                                  translator.translate("suceessmessage"),
                                  context);
                              // Get.to(login());
                            } else {
                              EasyLoading.dismiss();
                              DailogAlert.openbackAlert(
                                  value['message'],
                                  translator.translate("failedmessage"),
                                  context);
                            }
                          });
                        }
                        //mobile!
                      } else {
                        EasyLoading.dismiss();
                        DailogAlert.openbackAlert(
                            'please , Agree on conditions',
                            translator.translate("failedmessage"),
                            context);
                      }
                    } else {
                      EasyLoading.dismiss();
                      DailogAlert.openbackAlert('password don\'t match',
                          translator.translate("failedmessage"), context);
                    }
                  }
                },
                child: Container(
                  height: 40.h,
                  margin: const EdgeInsets.symmetric(horizontal: 29),
                  decoration: BoxDecoration(
                    color: CustomColors.MainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    translator.translate('login now'),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ReadexPro',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  )),
                )),
           SizedBox(
              height: 10.h,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translator.translate("have account"),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  ),
                SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Get.to(login());
                      },
                      child: Text(translator.translate("signin"),
                          style: TextStyle(
                            color: CustomColors.MainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ReadexPro',
                            fontSize: 18.sp,
                          )))
                ]),
          ],
        ),
      ),
    )));
  }
}
