
// ignore_for_file: library_prefixes

import 'package:flutter/foundation.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as Dio;

import '../global/dio.dart';

class PointApi extends ChangeNotifier {
  // String? token =  "f4090be887f3416759e281ca6943a11d5b62e7d147b4fc1cc447a44c9243fa81";
  final storage = const FlutterSecureStorage();
  Future getpoints() async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'points/get-points',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();
       if (response.data["message"] == "Unauthenticated") {
           EasyLoading.dismiss();
    
        return false;
      }
      return response.data['data']['points'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
  Future replacepoints() async {
    var token = await storage.read(key: 'token');
    try {
      Dio.Response response = await dio().post(
        'points/redeem-points',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (_) => true,
        ),
      );

      notifyListeners();

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
