// ignore_for_file: unused_import, unnecessary_import, camel_case_types, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'dart:math';

import 'package:esh7enly/Services/features/AuthApi.dart';
import 'package:esh7enly/core/utils/colors.dart';
import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:esh7enly/views/Login/login.dart';


class changeuserdata extends StatefulWidget {
  const changeuserdata({super.key});

  @override
  State<changeuserdata> createState() => _changeuserdataState();
}

class _changeuserdataState extends State<changeuserdata> {
  TextEditingController newmobile = TextEditingController();
  TextEditingController newname = TextEditingController();
  TextEditingController newemail = TextEditingController();
  late var firstnamecontroller = TextEditingController();
  late var lastnamecontroller = TextEditingController();
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
                                    top: 49,
                                    left: translator.currentLanguage == 'en'
                                        ? 66
                                        : 150,
                                    child: Text(
                                      translator.translate("change user data"),
                                      style: TextStyle(
                                        fontSize: 18,
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
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 26,
                                        )))
                              ])),
                          SizedBox(
                            height: 130.h,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25.h, right: 25.w, left: 25.w),
                              child: CustomTextField(
                                hint: translator.translate("enter mob"),
                                w: 100.w,
                                OnTab: () {},
                                controller: newmobile,
                              )),
                         Padding(
                padding:
                    EdgeInsets.only(top: 28.h, right: 25.w, left: 25.w, bottom: 5.h),
                child: SizedBox(
                  child: Row(
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
                  ),
                )),
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 25.h, right: 25.w, left: 25.w),
                              child: CustomTextField(
                                hint: translator.translate("enter email"),
                                w: 100.w,
                                OnTab: () {},
                                controller: newemail,
                              )),
                          SizedBox(
                            height: 45.h,
                          ),
                          GestureDetector(
                            onTap: () async{
                              AuthApi authApi = AuthApi();
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState!.save();
                              await  authApi
                                    .changeprofile(firstnamecontroller.text +' '+lastnamecontroller.text, newmobile.text,
                                        newemail.text, context)
                                    .then((value) {
                                    EasyLoading.show(
                                                      status: translator
                                                                  .currentLanguage ==
                                                              'ar'
                                                          ? 'جاري التحميل '
                                                          : 'loading...',
                                                      maskType:
                                                          EasyLoadingMaskType
                                                              .black);
                                  openAlert(value["message"],value['status']);
                                });
                              }
                            },
                            child: Container(
                              height: 50.h,
                              margin:
                                  EdgeInsets.symmetric(horizontal: 29.w),
                              decoration: BoxDecoration(
                                color: CustomColors.MainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  translator.translate("update data"),
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

  void openAlert(String mess,bool status) {
       EasyLoading.dismiss();
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Container(
        height: 150.0.h,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.only(top: 16.h),
          //   decoration: boxDecorationStylealert,
          width: 230.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 80.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(status==false?"Failed":"SUCCESS",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 14.h,
              ),
              Center(
                child: Text(
                  mess,
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Center(
                child: Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 0),
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
