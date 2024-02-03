// ignore_for_file: unused_import, camel_case_types, prefer_typing_uninitialized_variables, deprecated_member_use, prefer_const_constructors, prefer_const_declarations, unused_local_variable

import 'package:esh7enly/core/widgets/CustomTextField.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/views/Login/changepassword.dart';
import 'package:esh7enly/views/Login/forgetpass.dart';
import 'package:esh7enly/views/Login/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unique_identifier/unique_identifier.dart';
import '../../Services/features/AuthApi.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/header.dart';
import '../../models/language.dart';
import '../controllhome.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool hide = true;
  TextEditingController password = TextEditingController();
  late var phonecontroller = TextEditingController();
  bool? remeberme = false;
  var textlang = "English";
  bool passwordsecure = true;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  var token;
  getremeberme() async {
    await storage.read(key: 'remeberme').then((value) {
      setState(() {
        if (value != null) {
          remeberme = value.trim() == "true" ? true : false;
        }
      });
    });
  }

  @override
  void initState() {
    getremeberme();
    init();
    super.initState();
  }

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
                header(
                  heightcon: 210,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  translator.translate('welcome'),
                  style: TextStyle(
                      color: CustomColors.MainColor,
                      fontSize: 24,
                      fontFamily: 'ReadexPro'),
                )),
                SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30, right: 25, left: 25),
                    child: CustomTextField(
                      hint: translator.translate('enter phone'),
                      w: 100,
                      type: TextInputType.number,
                      OnTab: () {},
                      controller: phonecontroller,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 25, right: 25, left: 25),
                    child: CustomTextField(
                      hint: translator.translate("enter pass"),
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
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Padding(
                      padding: translator.currentLanguage == 'en'
                          ? EdgeInsets.only(left: 20)
                          : EdgeInsets.only(right: 20),
                      child: Checkbox(
                        activeColor: remeberme! ? Colors.blue : Colors.white,
                        checkColor: CustomColors.MainColor,
                        value: remeberme,
                        onChanged: (bool? value) {
                          setState(() {
                            remeberme = value!;

                            if (remeberme == true) {
                              storage.write(
                                  key: 'remeberme',
                                  value: remeberme.toString());
                            } else {
                              storage.delete(key: 'remeberme');
                              storage.delete(key: 'auth');
                            }
                          });
                        },
                      ),
                    ),
                    Text(
                      translator.translate("rember"),
                      style: TextStyle(fontSize: 14, fontFamily: 'ReadexPro'),
                    ),
                    SizedBox(
                      width: translator.currentLanguage == 'en' ? 60 : 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(forgerpassword());
                      },
                      child: Text(
                        translator.translate("whats rember pass"),
                        style: TextStyle(
                            color: CustomColors.MainColor,
                            fontSize: 14,
                            fontFamily: 'ReadexPro'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_globalKey.currentState!.validate()) {
                      //EasyLoading.showProgress(0.3, status: 'loading...');
                      EasyLoading.show(
                          status: translator.currentLanguage == 'ar'
                              ? 'جاري التحميل '
                              : 'loading...',
                          maskType: EasyLoadingMaskType.black);
                      _globalKey.currentState!.save();
                      AuthApi object = AuthApi();
                      final storage = const FlutterSecureStorage();
                      String? identifier = await UniqueIdentifier.serial;

                      token = 'oooo';
                      /*  FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value;
      
      });
    }); */
                      print(phonecontroller.text.length);
                      if (phonecontroller.text.length > 11){ 
                        DailogAlert.openbackAlert(
                            translator.translate("msgmob"),
                            translator.translate("failedmessage"),
                            context);
                        EasyLoading.dismiss();
                      } else {
                        await object.Login(phonecontroller.text, identifier!,
                                password.text, '123')
                            .then((value) {
                          print(value);
                          //  if (value != null) {
                          if (value['status'] == true) {
                            //Get.to(home());
                            Get.to(Controllhomeview());
                            EasyLoading.dismiss();
                          } else {
                            DailogAlert.openbackAlert(value['message'],
                                translator.translate("failedmessage"), context);
                            EasyLoading.dismiss();
                            // Get.snackbar("Failed", value['message']);
                          }

                          /*}c else {
                          DailogAlert.openbackAlert(
                              translator.translate("tryagin"),
                              translator.translate("failedmessage"),
                              context);
                          EasyLoading.dismiss();
                          // Get.snackbar("Failed", 'Try Agin');
                        } */
                        });
                      }
                    }
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
                        translator.translate("login"),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translator.translate("have no account"),
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w300,
                            fontFamily: 'ReadexPro',
                            fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: Text(translator.translate("login now"),
                            style: TextStyle(
                              color: CustomColors.MainColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ReadexPro',
                              fontSize: 18,
                            )),
                        onTap: () async {
                          Get.to(otp());
                        },
                      )
                    ]),
                const SizedBox(
                  height: 28,
                ),
                GestureDetector(
                    onTap: () async {
                      if (textlang == "English") {
                        translator.setNewLanguage(
                          context,
                          newLanguage: languge.languageslist()[1].languagecode,
                        ); //  restart: true
                        translator.isDirectionRTL(context);
                        setState(() {
                          textlang = "العربيه";
                        });
                      } else {
                        translator.setNewLanguage(
                          context,
                          newLanguage: languge.languageslist()[0].languagecode,
                        ); //  restart: true
                        translator.isDirectionRTL(context);
                        setState(() {
                          textlang = "English";
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Center(
                            child: SvgPicture.asset("assets/lang.svg",
                                color: CustomColors.MainColor,
                                width: 30,
                                height: 30)),
                        Positioned(
                          top: 5,
                          left: 163,
                          child: Center(
                              child: Text(textlang,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'ReadexPro'))),
                        )
                      ],
                    ))
              ],
            ),
          ),
        )));
  }

  void init() {
    storage.containsKey(key: 'auth').then((value) async {
      if (value == true) {
        var mobile = await storage.read(key: 'mobile');
        print(mobile);

        var pass = await storage.read(key: 'pass');
        print(pass);
        setState(() {
          phonecontroller.text = mobile!;
          password.text = pass!;
        });
      }
    });
  }
}

   
//#791716
/*
Padding(
              padding: EdgeInsets.only(right: 240, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFF9E9E9E)))),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter your phone",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFF9E9E9E)))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.visibility_off),
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color(0xff791716)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                        color: Color(0xff791716),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create your account",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Sign Up",
                              style: TextStyle(
                                color: Color(0xff791716),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                        ]),
                  ],
                ),
              ),
            ))
///////////////////
Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  color: Color(0xff791716),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(130))),
            ),
            /* Center(
                child: Image.asset(
              "assets/logo.jpeg",
              width: 200,
              height: 200,
            )), */
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff791716)),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
/////////////////////////////////////
   Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.only(top: 200, left: 50, right: 50),
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0.1, blurRadius: 5)
                  ]),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: password,
                    obscureText: hide,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: cpassword,
                    obscureText: hide,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(horizontal: 100)),
                      onPressed: () {
                        if (password.text != cpassword.text) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                      "Your Enter Password Do Not Match Each Other"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              });
                        } else {}
                      },
                      child: Text("Register")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account"),
                      TextButton(onPressed: () {}, child: Text("Login?"))
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                top: 80,
                left: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    )
                  ],
                ))










////////////////////////////////////////////
final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    late var phonecontroller = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
            key: _globalKey,
            child: Padding(
                padding: EdgeInsets.only(top: 110, right: 30, left: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const customtext(
                          maxLine: 1,
                          fontSize: 24,
                          fontweight: FontWeight.bold,
                          text: "تسجيل الدخول"),
                      SizedBox(
                        height: 20,
                      ),
                      const customtext(
                        maxLine: 1,
                        text: "رقم الهاتف",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hint: "",
                        OnTab: () {},
                        controller: phonecontroller,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const customtext(
                            maxLine: 1,
                            text: "كلمه السر",
                          ),
                          SizedBox(
                            width: 170,
                          ),
                         customtext(
                            maxLine: 1,
                            fontSize: 16,
                            fontweight: FontWeight.bold,
                            color:Color(0xff791716),
                            text: "نسيت كلمه السر ؟",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        // obsesure: true,
                        hint: "",
                        OnTab: () {},
                        controller: phonecontroller,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomButton(
                        w: 310,
                        h: 65,
                        colortext: Colors.white,
                        onPress: () {},
                        text: "تسجيل الدخول",
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: prefer_const_constructors
                              Text(
                                "لست مشترك ؟",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              GestureDetector(
                                // ignore: prefer_const_constructors
                                child: Text(
                                  " انشاء حساب",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ))
                    ]))),
      ),
    ));
  }
}*/