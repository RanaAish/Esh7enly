// ignore_for_file: library_prefixes, deprecated_member_use, use_build_context_synchronously, prefer_collection_literals, file_names

import 'package:dio/dio.dart' as Dio;
import 'package:esh7enly/core/widgets/daioulge.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../models/TotalAmounts.dart';
import '../../models/inquiryobject.dart';

import '../../models/payment.dart';
import '../../models/tranactions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../models/transaction.dart';
import '../global/dio.dart';

// ignore: camel_case_types
class serviceApi extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  // String? token ="f4090be887f3416759e281ca6943a11d5b62e7d147b4fc1cc447a44c9243fa81";
  Future<Map> getamounts(totalamounts object, BuildContext context) async {
    var token = await storage.read(key: 'token');
    Map output = Map();

    Map creds = {
      "imei": object.imei,
      "service_id": object.serviceid,
      "amount": object.pricevalue,
      "parameters": object.parameters,
      "printLang": "",
      "inquiry_transaction_id": 0,
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
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return output;
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  }

  /*Future<Map> gettotalamounts(String? imei, int? serviceid, String? pricevalue,
      List<Map> parameters) async {
    Map output = new Map();
    int inquiry = 0;
    var token =
        "3c508228ab3143453b71daece521af90da569b3814dd5ef3a32d76d4e3947834";
    Map creds = {
      "imei": imei,
      "service_id": serviceid,
      // "price_value": pricevalue,
      "amount": pricevalue,
      "parameters": parameters,
      "printLang": "",
      "inquiry_transaction_id": inquiry,
    };
    /*  parameters.forEach((k, v) {
      creds[k] = v;
    });
     
    print(creds.values);
     */
    //print(creds.values);
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
      print(response.data);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  } */

  Future<Map> payment(paymentmodel object, BuildContext context) async {
    Map output = Map();
    var token = await storage.read(key: 'token');
    Map creds = {
    "inquiry_transaction_id":object.id ,
        "amount": object.amount,
        "external_transaction_id": "",
        "imei": object.imei,
    
     "lang":"",
     // "printLang": " ",
      //"total_amount": object.total,
      "parameters": object.parameters,
          "service_id": object.serviceid,
      //"id": object.id,
    };
    /*  "imei": object.imei,
      "service_id": object.serviceid,
      "amount": object.amount,
      "printLang": " ",
      "total_amount": object.total,
      "parameters": object.parameters,
      "external_transaction_id": "",
      "id": object.id, */
    /*"inquiry_transaction_id": "1169",
        "amount": object.amount,
        "external_transaction_id": "",
        "imei": object.imei,
  
     "lang":"",
     // "printLang": " ",
      //"total_amount": object.total,
      "parameters": object.parameters,
          "service_id": object.serviceid,
      //"id": object.id, */
    print(creds);
    try {
      Dio.Response response = await dio().post(
        'service/payment',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return output;
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  }

  /* Future<Map> paymentparameters(String? imei, int? serviceid, String? amount,
      List<Map> parameters, String total) async {
    Map output = new Map();
    var token =
        "3c508228ab3143453b71daece521af90da569b3814dd5ef3a32d76d4e3947834";
    Map creds = {
      "imei": imei,
      "service_id": serviceid,
      "amount": amount,
      "printLang": " ",
      "parameters": parameters,
      "total_amount": total
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

      print(response.data);
      notifyListeners();
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return output;
  }
 */
  Future inquire(String? imei, int? serviceid, String? amount,
      List<Map> parameters, BuildContext context) async {
    var token = await storage.read(key: 'token');
    Map creds = {
      "imei": imei,
      "service_id": serviceid,
      "amount": amount,
      "printLang": " ",

      "parameters": parameters,
      "external_transaction_id": "",
      //"inquiry_transaction_id": 0
    };
    print(creds);
    try {
      Dio.Response response = await dio().post(
        'service/inquiry',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return "";
  }

  Future checkintegration(
      String? imei, int? dataentityid, BuildContext context) async {
    var token = await storage.read(key: 'token');
    Map creds = {
      "imei": imei,
      "id": dataentityid,
    };

    try {
      Dio.Response response = await dio().post(
        'service/check-integration-provider-status',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return "";
  }

  /*Future finalpayment(String? imei, int? serviceid, String? amount,
      List<Map> parameters, int? id, String? total) async {
    var token =
        "3c508228ab3143453b71daece521af90da569b3814dd5ef3a32d76d4e3947834";

    Map creds = {
      "imei": imei,
      "service_id": serviceid,
      "amount": amount,
      "printLang": "",
      "parameters": parameters,
      "external_transaction_id": "",
      "id": id,
    };
    print(creds.values);
    try {
      Dio.Response response = await dio().post(
        'service/payment',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      print(response.data['data']['parameters']);
      notifyListeners();

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return "";
  } */

  Future<List<tranaction>> gettranactions(
      int? page, BuildContext context) async {
    var token = await storage.read(key: 'token');

    Map creds = {
      "page": page,
    };

    try {
      Dio.Response response = await dio().post(
        'service/transactions?page=$page',
        data: creds,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      //  print(response.data['data']['data']);
      Tranactions format = Tranactions.fromjson((response.data));
      List<tranaction> list =
          format.tranactions.map((e) => tranaction.fromJson(e)).toList();
      notifyListeners();

      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return [];
      }

      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return [];
  }

  Future getdetailstranaction(int id, BuildContext context) async {
    var token = await storage.read(key: 'token');

    try {
      Dio.Response response = await dio().post(
        'service/show-transaction/$id',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      Data format = Data.fromJson((response.data['data']));

      notifyListeners();
      if (response.data["message"] == "Unauthenticated") {
        EasyLoading.dismiss();
        DailogAlert.openAlert(translator.translate("unauth"),
            translator.translate("failedmessage"), context);
        return;
      }
      return format;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }
}
