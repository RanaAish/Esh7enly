// ignore_for_file: library_prefixes

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/xpaydio.dart';

class XPAY extends ChangeNotifier {
  Future getiframetest() async {
    //  'https://staging.xpay.app/api/v1/payments/pay/variable-amount'
    try {
      Dio.Response response = await xpaydio().post(
        'payments/pay/variable-amount',
        options: Dio.Options(
          headers: {
            'Authorization':  
                "x-api-key DSpmn6Gw.Fc7z8Ssq3X9ZLV4rENuzy7kfUjmA24xm"
          },
          validateStatus: (_) => true,
        ),
      );
      // print(response.data['data']);
      return response.data['data']["iframe_url"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  /* Map creds = {
      "billing_data": {
        "name": "Rana Mahmoud",
        "email": "irostom@xpay.app",
        "phone_number": "+201119045759"
      },
      "amount": 50,
      "currency": "EGP",
      "variable_amount_id": 247,
      "language": "en",
      "community_id": "GBE794E",
      "pay_using": "card"
    }; */

  Future getiframe(double amount) async {
    const storage = FlutterSecureStorage();
    var name = await storage.read(key: 'name');
    var mobile= await storage.read(key: 'mobile');
    var email = await storage.read(key: 'email');
    Map creds = {
      "billing_data": {
        "name": name,
        "email":email ?? "",
        "phone_number": mobile
      },
      "amount": amount,
      "currency": "EGP",
      "variable_amount_id": 116,
      "language": "en",
      "community_id": "8p9e6pV",
      "pay_using": "card"
    };
    try {
      Dio.Response response = await xpaydio().post(
        'payments/pay/variable-amount',
        data: creds,
        options: Dio.Options(
          headers: {'x-api-key':'DSpmn6Gw.Fc7z8Ssq3X9ZLV4rENuzy7kfUjmA24xm'},
          validateStatus: (_) => true,
        ),
      );
      // print(response.data);
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future gettransaction(String uid) async {
    try {
      Dio.Response response = await xpaydio().get(
        'communities/GBE794E/transactions/$uid/',
        options: Dio.Options(
          headers: {'x-api-key': 'DSpmn6Gw.Fc7z8Ssq3X9ZLV4rENuzy7kfUjmA24xm'},
          validateStatus: (_) => true,
        ),
      );
      // print(response.data["data"]);
      return response.data["data"];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
