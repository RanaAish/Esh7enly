// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors, non_constant_identifier_names, library_prefixes, file_names

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../models/user.dart';
import '../../views/Login/login.dart';
import '../global/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future register(
      String mobile, String imie, String password, String name, email) async {
    Map creds = {
      "mobile": mobile,
      "password": password,
      "imei": imie,
      "name": name,
      "email": email
    };

    try {
      Dio.Response response = await dio().post(
        'auth/register',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void storeToken(
      {required String token,
      required String pass,
      required String name,
      required String mobile,
      required String email}) async {
    storage.write(key: 'token', value: token);
    storage.write(key: 'name', value: name);
    storage.write(key: 'mobile', value: mobile);
    storage.write(key: 'pass', value: pass);
    storage.write(key: 'email', value: email);
    var rem = await storage.read(key: 'remeberme');

    if (rem != null) {
      if (rem.trim() == 'true') {
        storage.write(key: 'auth', value: "true");
      }
    }
  }

  void storkey(String key) async {
    storage.write(key: 'key', value: key);
  }

  Future Login(
      String mobile, String imie, String password, String token) async {
    Map creds = {
      "mobile": mobile,
      "password": password,
      "imei": imie,
      "device_token": token
    };
    try {
      Dio.Response response = await dio().post(
        'auth/login',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          user userformat = user.fromjson(response.data["data"]);
          storeToken(
              token: userformat.token,
              name: userformat.name,
              mobile: userformat.mobile,
              pass: password,
              email: response.data["data"]["email"]);
        }
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // return null;
  }

  Future Sendotp(String mobile) async {
    Map creds = {"mobile": mobile};
    storage.write(key: 'mobile', value: mobile);
    try {
      Dio.Response response = await dio().post(
        'auth/send-otp',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        /* if(response.data['status']==false){
           if (response.data["data"]["middleware_validation_error"]["mobile"][0] ==
            "The mobile has already been taken.") {
          Get.snackbar("Verified", 'The mobile has already been taken');
          Get.off(login());
        }
         } */
        if ((response.data['status']) != false) {
          storkey(response.data["data"]["key"]);
        }

        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future Verifyotp(String token) async {
    var key = await storage.read(key: 'key');
    var mobile = await storage.read(key: 'mobile');
    Map creds = {"mobile": mobile, "token": token, "key": key};

    try {
      Dio.Response response = await dio().post(
        'auth/otp',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          storage.write(key: 'verifyotp', value: "true");
        }
        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future forgetpassword(String mobile, BuildContext context) async {
    Map creds = {"mobile": mobile};

    try {
      Dio.Response response = await dio().post(
        'auth/send-forget-password-otp',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == 200) {
        if (response.data["message"] == "Unauthenticated") {
          EasyLoading.dismiss();
          DailogAlert.openAlert(translator.translate("unauth"),
              translator.translate("failedmessage"), context);
          return;
        }
        storage.write(
            key: 'otpforgetpass',
            value: response.data['data']["otp"].toString());

        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future postnewpassword(String mobile, String otp, String pass, String cofirm,
      BuildContext context) async {
    Map creds = {
      "mobile": mobile,
      "otp": otp,
      "password": pass,
      "password_confirmation": cofirm
    };

    try {
      Dio.Response response = await dio().post(
        'auth/forget-password',
        data: creds,
        options: Dio.Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["message"] == "Unauthenticated") {
          EasyLoading.dismiss();
          DailogAlert.openAlert(translator.translate("unauth"),
              translator.translate("failedmessage"), context);
          return;
        }

        return response.data["message"];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future changepassword(
      String currentpass, String newpass, BuildContext context) async {
    var tocken = await storage.read(key: 'token');
    Map creds = {
      "currant_password": currentpass,
      "new_password": newpass,
    };

    try {
      Dio.Response response = await dio().post(
        'misc/change-password',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $tocken'},
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["message"] == "Unauthenticated") {
          EasyLoading.dismiss();
          DailogAlert.openAlert(translator.translate("unauth"),
              translator.translate("failedmessage"), context);
          return;
        }

        return response.data["message"];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future changeprofile(
      String name, String mobile, String email, BuildContext context) async {
    var tocken = await storage.read(key: 'token');

    Map creds = {"name": name, "mobile": mobile, "email": email};

    try {
      Dio.Response response = await dio().post(
        'misc/update-profile',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $tocken'},
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["message"] == "Unauthenticated") {
          EasyLoading.dismiss();
          DailogAlert.openAlert(translator.translate("unauth"),
              translator.translate("failedmessage"), context);
          return;
        }

        return response.data;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void logout() async {
    try {
      var token = await storage.read(key: 'token');

      Dio.Response response = await dio().post(
        '/logout',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(" response msg ${response.data.toString()}");
        }
        cleanUp();
        notifyListeners();
        Get.offAll(login());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    //notifyListeners();
  }

  void cleanUp() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'mobile');
    await storage.delete(key: 'name');
    await storage.delete(key: 'key');
    await storage.delete(key: 'auth');
    await storage.delete(key: 'remeberme');
    await storage.delete(key: 'email');
    await storage.deleteAll();
  }
}
/*   ? _provider.name_ar.length >=11?'${_provider.name_ar.substring(1,9)}....':'  ${_provider.name_ar}'
                                              :  _provider.name_en.length >=20?'....${_provider.name_en.substring(0,36)}':'  ${_provider.name_en}', */