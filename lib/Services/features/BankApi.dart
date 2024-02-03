// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unused_local_variable, unnecessary_string_interpolations, library_prefixes, file_names

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/core/loader/providerloader.dart';
import 'package:esh7enly/core/widgets/daioulge.dart';
import 'package:esh7enly/models/deposit.dart';
import 'package:esh7enly/models/deposits.dart';
import 'package:esh7enly/views/balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import '../global/dio.dart';

// ignore: camel_case_types
class BankApi extends ChangeNotifier {
  // String? token =  "f4090be887f3416759e281ca6943a11d5b62e7d147b4fc1cc447a44c9243fa81";
  final storage = const FlutterSecureStorage();
  Future getamount(double value, BuildContext context,String type) async {
    Map creds = {"amount": value,"payment_method_type":"paytabs","transaction_type":type};
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'payment-method/get-amount',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return;
      }

      return response.data['data'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future startsession(double value, double amount, BuildContext context,String type) async {
    var token = await storage.read(key: 'token');
    //Map creds = {"totalamount": value, "ip": "9", "amount": amount,"payment_method_type":"paytabs","transaction_type":type};
    Map creds = { "ip": "69", "amount": value,"payment_method_type":"paytabs","transaction_type":type};
    //Map creds = {"ip": "9", "amount":value};
    try {
      Dio.Response response = await dio().post(
        'payment-method/start-session',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
       DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return;
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future payamount(Map creds, BuildContext context) async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'payment-method/pay-amount',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
       DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return;
      }
      // print('final responce ${response.data}');
     // Get.snackbar("Successful", response.data['message']);
      //Get.back();
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<List> getdeposits(BuildContext context, int? page) async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'payment-method/list?page=$page',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
      deposits depositformat = deposits.fromjson((response.data));
      List<depositmodel> depositslist =
          depositformat.depos.map((e) => depositmodel.fromJson(e)).toList();

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return [];
      }
    
      return depositslist;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return [];
  }

  Future getbalance() async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'wallet/all',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        return null;
      }
      notifyListeners();

      return response.data['data'][0]["balance"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future totalamountvodavonecache(
      String? imie, String amount, String phone, BuildContext context) async {
    final modelhud = Provider.of<providerloader>(context, listen: false);
    //await modelhud.changeisloading(true);
    //await modelhud.chngechannel();
    List output = [];
    var token = await storage.read(key: 'token');
    Map creds = {
      "service_id": 3968,
      "imei": imie,
      "amount": amount,
      "parameters": [
        {"key": "billing_account", "value": "$phone"}
      ],
      "inquiry_transaction_id": 0
    };
    try {
      Dio.Response response = await dio().post(
        'service/total-amount',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

     
      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
       DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return;
      }
      if (response.data['status'] == true) {
        paymentvodavonecache(imie, amount, phone, context);
      } else {
        DailogAlert.openbackAlert(response.data["message"], translator.translate( "failedmessage"), context);
        //await modelhud.changeisloading(false);
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  }

  Future paymentvodavonecache(
      String? imie, String amount, String phone, BuildContext context) async {
    final modelhud = Provider.of<providerloader>(context, listen: false);
    // await modelhud.changeisloading(true);
    //  await modelhud.chngechannel();
    EasyLoading.show(
        status:
            translator.currentLanguage == 'ar' ? 'جاري التحميل ' : 'loading...',
        maskType: EasyLoadingMaskType.black);
  
    List output = [];
    var token = await storage.read(key: 'token');
    Map creds = {
      "service_id": 3968,
      "lang": " ",
      "imei": imie,
      "amount": amount,
      "external_transaction_id": "",
      "parameters": [
        {"key": "billing_account", "value": "$phone"}
      ],
    };
    try {
      Dio.Response response = await dio().post(
        'service/payment',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );
      //await modelhud.changeisloading(false);
      EasyLoading.dismiss();
     
      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"), translator.translate( "failedmessage"), context);
        return;
      }

      if (response.data['status'] == true) {
        DailogAlert.openbackAlert(
            translator.translate('cashmsg'), translator.translate("suceessmessage"), context);
        Get.off(const balance());
      } else {
        DailogAlert.openbackAlert(response.data["message"], translator.translate( "failedmessage"), context);
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  }
}
